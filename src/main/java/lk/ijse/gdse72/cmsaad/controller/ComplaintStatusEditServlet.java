package lk.ijse.gdse72.cmsaad.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.cmsaad.dto.ComplaintDTO;
import lk.ijse.gdse72.cmsaad.model.ComplaintModel;

import java.io.IOException;

@WebServlet("/admin/complaint-status-edit")
public class ComplaintStatusEditServlet extends HttpServlet {

    private ComplaintModel complaintModel = new ComplaintModel();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String complaintId = req.getParameter("complaintId");
        String status = req.getParameter("status");
        String adminRemarks = req.getParameter("adminRemarks");


        ComplaintDTO complaint = complaintModel.getComplaintById(complaintId);
        if (complaint == null) {
            resp.sendRedirect(req.getContextPath() + "/jsp/view-all-complaints.jsp?error=notfound");
            return;
        }
        complaint.setStatus(status);
        complaint.setAdminRemarks(adminRemarks);


        boolean updated = complaintModel.updateComplaintStatus(complaintId,status,adminRemarks);

        if (updated) {
            System.out.println("Updated status and add a mark also ...!");
            resp.sendRedirect(req.getContextPath() + "/jsp/view-all-complaints.jsp?success=updated");
        } else {
            System.out.println("Failed to update status and could not add a mark also ...!");
            resp.sendRedirect(req.getContextPath() + "/jsp/view-all-complaints.jsp?error=updatefailed");
        }
    }
}