<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Signin Page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/signin.css">
</head>
<body>
<div class="container">
    <h1>Sign In</h1>

    <% String error = request.getParameter("error"); %>
    <% if (error != null) { %>
    <p style="color: red; text-align: center;"><%= error %></p>
    <% } %>

    <form action="signIn" method="post">
        <label for="username">Username</label>
        <input type="text" name="username" id="username" required>

        <label for="password">Password</label>
        <input type="password" name="password" id="password" required>

        <input type="submit" value="signIn">
    </form>

    <p style="text-align: center; margin-top: 1rem;">
        Don't have an account? <a href="signup.jsp">Register here</a>
    </p>
</div>
</body>
</html>
