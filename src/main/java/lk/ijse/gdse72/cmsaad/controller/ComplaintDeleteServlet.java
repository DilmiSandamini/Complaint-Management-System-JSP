package lk.ijse.gdse72.cmsaad.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse72.cmsaad.dto.ComplaintDTO;
import lk.ijse.gdse72.cmsaad.dto.UserDTO;
import lk.ijse.gdse72.cmsaad.model.ComplaintModel;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/complaint/delete-complaint")
public class ComplaintDeleteServlet extends HttpServlet {

    private final ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complaintId = req.getParameter("complaintId");

        HttpSession session = req.getSession(false);

        if (session == null) {
            redirectWithError(req, resp, "unauthorized");
            return;
        }

        if (complaintId == null || complaintId.isEmpty()) {
            redirectWithError(req, resp, "missingComplaintId");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            System.out.println("Logged in user ID = " + user.getUserId());
            redirectWithError(req, resp, "unauthorized");
            return;
        }

        boolean allowedToDelete = false;

        if (user.isAdmin()) {
            allowedToDelete = true;
        } else if (user.isEmployee()) {
            ComplaintDTO complaint = complaintModel.getComplaintById(complaintId);
            if (complaint != null
                    && "PENDING".equalsIgnoreCase(complaint.getStatus())
                    && complaint.getSubmittedBy().equals(user.getUserId())) {
                allowedToDelete = true;
            }
        }

        if (allowedToDelete) {
            boolean deleted = user.isAdmin()
                    ? complaintModel.deleteComplaint(complaintId)
                    : complaintModel.deleteComplaintByEmployee(complaintId, user.getUserId());

            if (deleted) {
                System.out.println("Complaint deleted successfully");
                redirectWithSuccess(req, resp, "deleted");
            } else {
                System.out.println("Complaint deletion failed");
                redirectWithError(req, resp, "deleteFailed");
            }
        } else {
            redirectWithError(req, resp, "unauthorized");
        }
    }
    private void redirectToReferer(HttpServletRequest req, HttpServletResponse resp, String param, String value) throws IOException {
        String referer = req.getHeader("referer");
        if (referer == null || referer.isEmpty()) {
            referer = req.getContextPath() + "/complaints";
        }
        String encodedValue = URLEncoder.encode(value, StandardCharsets.UTF_8);
        resp.sendRedirect(referer + "?" + param + "=" + encodedValue);
    }

    private void redirectWithError(HttpServletRequest req, HttpServletResponse resp, String errorCode) throws IOException {
        redirectToReferer(req, resp, "error", errorCode);
    }

    private void redirectWithSuccess(HttpServletRequest req, HttpServletResponse resp, String message) throws IOException {
        redirectToReferer(req, resp, "success", message);
    }
}
