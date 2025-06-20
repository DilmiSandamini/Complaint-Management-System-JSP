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
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/employee/submit-complaint")
public class ComplaintSubmitServlet extends HttpServlet {

    private ComplaintModel complaintModel = new ComplaintModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet Method of Complain Submit ...");

        req.getRequestDispatcher("/jsp/complaint-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doPost Method of Complain Submit ...");

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String department = req.getParameter("department");

        Map<String, String> errors = new HashMap<>();
        if(title == null || title.isEmpty()){
            errors.put("titleError", "Title is required.");
        }
        if(description == null || description.isEmpty()){
            errors.put("descriptionError", "Description is required.");
        }
        if(department == null || department.isEmpty()){
            errors.put("departmentError" , "Department is required.");
        }

        if(!errors.isEmpty()){

            for(Map.Entry<String, String> entry : errors.entrySet()){
                req.setAttribute(entry.getKey(), entry.getValue());
            }

            req.setAttribute("oldTitle", title);
            req.setAttribute("oldDescription", description);
            req.setAttribute("oldDepartment", department);

            req.getRequestDispatcher("/jsp/complaint-form.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        String submittedBy = ((lk.ijse.gdse72.cmsaad.dto.UserDTO)session.getAttribute("user")).getUserId();

        ComplaintDTO complaint = new ComplaintDTO();
        complaint.setComplaintId(ComplaintModel.generateComplaintId());
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setDepartment(department);
        complaint.setStatus("PENDING");
        complaint.setSubmittedBy(submittedBy);
        complaint.setCreatedAt(LocalDateTime.now());

        System.out.println("before call complainDAO.createComplaint Method ...");
        boolean saved = complaintModel.createComplaint(complaint);
        System.out.println("After call complaintDAO.createComplaint Method ...");

        if (saved) {
            System.out.println("saved Complaint ...");
            resp.sendRedirect(req.getContextPath() + "/jsp/my-complaints.jsp?success=1");
        } else {
            System.out.println(" Save Failed Complaint ...");
            req.setAttribute("error", "Failed to submit complaint.");
            req.getRequestDispatcher("/jsp/complaint-form.jsp").forward(req, resp);
        }
    }
}
