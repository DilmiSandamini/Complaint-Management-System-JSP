package lk.ijse.gdse72.cmsaad.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse72.cmsaad.dto.ComplaintDTO;
import lk.ijse.gdse72.cmsaad.model.ComplaintModel;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/all-complaints-view")
public class AdminAllComplaintServlet extends HttpServlet {

    private final ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("get method called in AdminAllComplaintServlet");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {

            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        try {
            System.out.println("Before Call getAllComplaints In complainModel ...");

            List<ComplaintDTO> complaints = complaintModel.getAllComplaints();
            System.out.println("After Call getAllComplaints In complaintDAO ..." + complaints);

            req.setAttribute("complaints", complaints);

            req.getRequestDispatcher("/jsp/view-all-complaints.jsp").forward(req, resp);

        } catch (RuntimeException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load complaints at this time.");
        }
    }
}
