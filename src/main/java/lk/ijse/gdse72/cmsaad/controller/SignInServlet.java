package lk.ijse.gdse72.cmsaad.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse72.cmsaad.dto.UserDTO;
import lk.ijse.gdse72.cmsaad.model.UserModel;

import java.io.IOException;

@WebServlet("/signIn")
public class SignInServlet extends HttpServlet {

    private UserModel userModel = new UserModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserDTO user = userModel.checkAuthenticate(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            if (user.isAdmin()) {
                System.out.println("IsAdmin");
//                resp.sendRedirect(req.getContextPath() + "../../../web/view/admin-dashboard.jsp");
                resp.sendRedirect(req.getContextPath() + "/jsp/dashboard-admin.jsp");
            } else if (user.isEmployee()) {
                System.out.println("IsEmployee");
                resp.sendRedirect(req.getContextPath() + "/jsp/dashboard-employee.jsp");
            } else {
                System.out.println("Some Wrong");
                resp.sendRedirect(req.getContextPath() + "/index.jsp?error=role");
            }
        } else {
            req.setAttribute("error", "Invalid Username or Password.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);

        }
    }
}
