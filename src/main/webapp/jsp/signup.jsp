<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Style -->
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: radial-gradient(circle at top center, #1a2a6c, #1e3c72, #2a5298);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .signup-container {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            color: #fff;
            padding: 50px;
            width: 120%;
            max-width: 900px;
            margin-right: 70px;
        }

        .signup-form h1 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .information-box {
            margin-bottom: 15px;
        }

        label {
            font-weight: 200;
            color: #ddd;
        }

        .form-control, input, select {
            background: rgba(255, 255, 255, 0.1);
            border: none;
            color: #fff;
            width: 100%;
            padding: 10px;
            border-radius: 5px;
        }

        .form-control:focus, input:focus, select:focus {
            background: rgba(255, 255, 255, 0.15);
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .invalid {
            border: 1px solid #ff6b6b;
        }

        .error {
            color: #ff6b6b;
            font-size: 0.85rem;
            margin-top: 5px;
        }

        .signup-button {
            width: 100%;
            background: linear-gradient(to right, #4f72b4,#6c8fcd);
            color: #fff;
            padding: 10px;
            font-weight: 300;
            border: none;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .signup-button:hover {
            background: linear-gradient(to right, #2a5298, #1e3c72);
        }

        .information-box2 {
            margin-top: 15px;
            text-align: center;
        }

        #signin-lable {
            color: #ccc;
        }

        #signin {
            color: #00f2fe;
            text-decoration: none;
        }

        #signin:hover {
            text-decoration: underline;
        }
    </style>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/signup-validation.js"></script>
</body>