<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SignUp page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signup.css">
</head>
<body>
<main>
    <section class="signup-container">
        <form action="${pageContext.request.contextPath}/signup" method="post" class="signup-form">
            <h1>Sign Up</h1>

            <div class="information-box">
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" name="firstName"
                       value="${not empty oldFirstName ? oldFirstName : ''}"
                       class="${not empty firstNameError ? 'invalid' : ''}"
                       placeholder="Enter your first name" required>
                <p class="error">${firstNameError}</p>
            </div>


            <div class="information-box">
                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" name="lastName"
                       value="${not empty oldLastName ? oldLastName : ''}"
                ${not empty lastNameError ? 'class="invalid"' : ''}
                       placeholder="Enter your last name" required>
                <p class="error">${lastNameError}</p>
            </div>

            <div class="information-box">
                <label for="mobileNumber">Mobile Number</label>
                <input type="tel" id="mobileNumber" name="mobileNumber"
                       value="${not empty oldMobileNumber ? oldMobileNumber : ''}"
                ${not empty mobileNumberError ? 'class="invalid"' : ''}
                       placeholder="Enter your mobile number" pattern="[0-9]{10}" required>
                <p class="error">${mobileNumberError}</p>
            </div>

            <div class="information-box">
                <label for="username">Username</label>
                <input type="text" id="username" name="username"
                       value="${not empty oldUsername ? oldUsername : ''}"
                ${not empty usernameError ? 'class="invalid"' : ''}
                       placeholder="Enter your username" required>
                <p class="error">${usernameError}</p>
            </div>

            <div class="information-box">
                <label for="email">Email</label>
                <input type="email" id="email" name="email"
                       value="${not empty oldEmail ? oldEmail : ''}"
                ${not empty emailError ? 'class="invalid"' : ''}
                       placeholder="Enter your email" required>
                <p class="error">${emailError}</p>
            </div>

            <div class="information-box">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       class="${not empty passwordError ? 'invalid' : ''}"
                       placeholder="Enter your password & min length 6 characters" required>
                <p class="error">${passwordError}</p>
            </div>

            <div class="information-box">
                <label for="role">Role</label>
                <select name="role" id="role" required>
                    <option value="EMPLOYEE">Employee</option>
                    <option value="ADMIN">Admin</option>
                </select>
                <p class="error">${roleError}</p>
            </div>


            <div class="information-box">
                <button type="submit" class="signup-button">Sign Up</button>
                <div class="information-box2">
                    <label id="signin-lable" for="signin">Do you have already existed account?</label>
                    <a href="signin.jsp" id="signin">Sign In</a>
                </div>
            </div>

        </form>
    </section>
</main>
</body>