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

@WebServlet("/employee/update-complaint")
public class ComplaintUpdateServlet extends HttpServlet {

    private ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp?error=unauthorized");
            return;
        }

            UserDTO user = (UserDTO) session.getAttribute("user");

            String complaintId = req.getParameter("complaintId");

            if (complaintId == null || complaintId.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/jsp/my-complaints.jsp?error=missingId");
                return;
            }

        ComplaintDTO complaint = complaintModel.getComplaintById(complaintId);

        if (complaint == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/my-complaints.jsp?error=notfound");
            return;
        }

        if (!complaint.getSubmittedBy().equals(user.getUserId()) && !user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/jsp/my-complaints.jsp?error=unauthorized");
            return;
        }

            req.setAttribute("complaint", complaint);
            req.getRequestDispatcher("/jsp/complaint-update.jsp").forward(req, resp);
        }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp?error=unauthorized");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");

        String complaintId = req.getParameter("complaintId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String department = req.getParameter("department");

        if (complaintId == null || complaintId.isEmpty()
                || title == null || title.isEmpty()
                || description == null || description.isEmpty()
                || department == null || department.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.setAttribute("complaint", complaintModel.getComplaintById(complaintId));
            req.getRequestDispatcher("/jsp/complaint-update.jsp").forward(req, resp);
            return;
            }

        ComplaintDTO complaint = complaintModel.getComplaintById(complaintId);

        if (complaint == null || !"PENDING".equalsIgnoreCase(complaint.getStatus())) {
            resp.sendRedirect(req.getContextPath() + "/jsp/my-complaints.jsp?error=invalid");
            return;
        }

        if (!complaint.getSubmittedBy().equals(user.getUserId()) && !user.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/jsp/my-complaints.jsp?error=unauthorized");
            return;
        }

        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setDepartment(department);

        System.out.println("Before calling updateComplaint method in complaintDAO");
        boolean updated = complaintModel.updateComplaint(complaint);
        System.out.println("After calling updateComplaint method in complaintDAO");

        if (updated) {
            System.out.println("Complaint updated successfully!");
            resp.sendRedirect(req.getContextPath() + "/jsp/my-complaints.jsp?success=updated");
        } else {
            System.out.println("Something went wrong while updating the complaint...");

            req.setAttribute("error", "Failed to update complaint.");
            req.setAttribute("complaint", complaint);
            req.getRequestDispatcher("/jsp/complaint-update.jsp").forward(req, resp);
        }
    }

}


