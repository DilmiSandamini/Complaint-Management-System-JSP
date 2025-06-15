package lk.ijse.gdse72.cmsaad.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse72.cmsaad.dto.UserDTO;
import lk.ijse.gdse72.cmsaad.model.UserModel;
import lk.ijse.gdse72.cmsaad.util.ValidationUtil;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "signup", value = "/signup")
public class SignUpServlet extends HttpServlet {

    private UserModel userModel = new UserModel();

    @Override
    protected void doGet(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        httpServletRequest.getRequestDispatcher("/jsp/signup.jsp").forward(httpServletRequest, httpServletResponse);
    }

    @Override
    protected void doPost(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws ServletException, IOException {
        String firstName = httpServletRequest.getParameter("firstName");
        String lastName = httpServletRequest.getParameter("lastName");
        String mobileNumber = httpServletRequest.getParameter("mobileNumber");
        String username = httpServletRequest.getParameter("username");
        String email = httpServletRequest.getParameter("email");
        String password = httpServletRequest.getParameter("password");
        String role = httpServletRequest.getParameter("role");

        boolean isError = false;

        if (!ValidationUtil.isValidfirstName(firstName)) {
            httpServletRequest.setAttribute("Name Error", "First name is required.");
            isError = true;
        }

        if (!ValidationUtil.isValidlastName(lastName)) {
            httpServletRequest.setAttribute("Name Error", "Last name is required.");
            isError = true;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            httpServletRequest.setAttribute("password Error", "Passwords is required.");
            isError = true;
        }

        if (!ValidationUtil.isValidMobileNumber(mobileNumber)) {
            httpServletRequest.setAttribute("Mobile Number Error", "Mobile Number is required.");
            isError = true;
        }

        if (!ValidationUtil.isValidUsername(username)) {
            httpServletRequest.setAttribute("Username Error", "Invalid username.");
            isError = true;
        }

        if (!ValidationUtil.isValidEmail(email)) {
            httpServletRequest.setAttribute("Email Error", "Invalid email address.");
            isError = true;
        }

        if (!(role != null && (role.equalsIgnoreCase("EMPLOYEE") || role.equalsIgnoreCase("ADMIN")))) {
            httpServletRequest.setAttribute("Role Error", "Role must be EMPLOYEE or ADMIN.");
            isError = true;
        }

        httpServletRequest.setAttribute("oldFirstName", firstName);
        httpServletRequest.setAttribute("oldLastName", lastName);
        httpServletRequest.setAttribute("oldMobileNumber", mobileNumber);
        httpServletRequest.setAttribute("oldUsername", username);
        httpServletRequest.setAttribute("oldEmail", email);

//        if (isError) {
//            System.out.println("Validation failed ... forwarding back to form");
//            httpServletRequest.getRequestDispatcher("/jsp/signup.jsp").forward(httpServletRequest, httpServletResponse);
//            return;
//        }
        UserDTO userDTO = new UserDTO(
                UserModel.generateUserId(),
                firstName,
                lastName,
                mobileNumber,
                username,
                email,
                password,
                role,
                LocalDateTime.now()
        );

        // Save the user using UserModel
        boolean isUserAdded = userModel.saveUser(userDTO);

        if (isUserAdded) {
            System.out.println("User created successfully");
            httpServletRequest.setAttribute("successMessage", "User created successfully.");
            httpServletRequest.getRequestDispatcher("/jsp/signin.jsp").forward(httpServletRequest, httpServletResponse);
        } else {
            System.out.println("Failed to create user");
            httpServletRequest.setAttribute("errorMessage", "Failed to create user. Please try again.");
            httpServletRequest.getRequestDispatcher("/jsp/signup.jsp").forward(httpServletRequest, httpServletResponse);
        }

    }
}
