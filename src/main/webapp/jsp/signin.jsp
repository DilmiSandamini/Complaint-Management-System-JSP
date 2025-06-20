<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign In</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Styles -->
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

        .glass-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.18);

            width: 90%;
            max-width: 450px;
            padding: 40px 30px;
            color: #fff;

            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 60px;
        }

        .glass-card h2 {
            text-align: center;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .form-label {
            color: #ddd;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            border: none;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-custom {
            background: linear-gradient(to right, #4f72b4,#6c8fcd);
            color: #fff;
            border: none;
            margin-top: 10px;
            transition: background 0.3s ease;
        }

        .btn-custom:hover {
            background: linear-gradient(to right, #2a5298, #1e3c72); /* reverse on hover */
        }

        .text-muted {
            margin-top: -50px;
            color: #ffffff !important;
        }

        .form-footer {
            text-align: center;
            margin-top: 15px;
        }

        .form-footer a {
            color: #00f2fe;
            text-decoration: none;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="glass-card">
    <h2>Welcome Back</h2>
    <p class="text-center text-muted">Please enter your details to sign in.</p>

    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= error %>
    </div>
    <% } %>

    <form action="signIn" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" name="username" id="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-custom">Sign In</button>
        </div>
    </form>

    <div class="form-footer mt-3">
        <span>Don't have an account? </span>
        <a href="${pageContext.request.contextPath}/jsp/signup.jsp">Create Account</a>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/js/signin-validation.js"></script>
</body>
</html>
