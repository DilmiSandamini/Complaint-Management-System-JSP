<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SignUp page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
</head>
<body>
<main>
    <section class="signup-container">
        <form>
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" name="First Name" placeholder="Enter your first name" required>
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" name="Last Name" placeholder="Enter your last name" required>
            <label for="mobilNumber">Mobile Number</label>
            <input type="tel" id="mobilNumber" name="mobileNumber" placeholder="Enter your mobile number" pattern="[0-9]{10}" required>
            <label for="userName">Username</label>
            <input type="text" id="userName" name="User Name" placeholder="Enter your User name" required>
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
            <label for="role">Department</label>
            <select name="department" id="department" required>
                <option value="Engineering department">Engineering department</option>
                <option value="Water & Drainage department">Water & Drainage department</option>
                <option value="Environment department">Environment department</option>
                <option value="Sanitation department">Sanitation department</option>
            </select>
            <label for="role">Role:</label>
            <select name="role" id="role" required>
                <option value="EMPLOYEE">EMPLOYEE</option>
                <option value="ADMIN">ADMIN</option>
            </select>
            <div>
                <button type="submit" class="signup-button">Sign Up</button>
                <div>
                    <label for="signin">Do you have already existed account?</label>
                    <a href="signin.jsp" id="signin">Sign In</a>
                </div>
            </div>

        </form>
    </section>
</main>
</body>