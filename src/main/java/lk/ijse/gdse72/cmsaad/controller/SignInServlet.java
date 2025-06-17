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

        if (user == null) {
            req.setAttribute("error", "Invalid Username or Password.");
            req.getRequestDispatcher("/index.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("user", user);

        String contextPath = req.getContextPath();

        if (user.isAdmin()) {
            System.out.println("Login successful - Admin user: " + user.getUsername());
            resp.sendRedirect(contextPath + "/jsp/dashboard-admin.jsp");
        } else if (user.isEmployee()) {
            System.out.println("Login successful - Employee user: " + user.getUsername());
            resp.sendRedirect(contextPath + "/jsp/dashboard-employee.jsp");
        } else {
            System.out.println("Login failed - Unknown role for user: " + user.getUsername());
            resp.sendRedirect(contextPath + "/index.jsp?error=role");
        }

    }
}
