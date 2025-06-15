<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login - Complaint Management System</title>
<%--  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>--%>
  <link rel="stylesheet" href="css/signin.css">
</head>
<body>
<div class="container">
  <h1>Sign In</h1>

  <% String error = (String) request.getAttribute("error"); %>
  <% if (error != null) { %>
  <script>
    Swal.fire({
      icon:'error',
      title:'Login Failed',
      text:'<%= "invalid".equals(error) ? "Invalid Username or Password" : "User role not recognized" %>',
      confirmButtonText:'OK'
    });
  </script>
  <% } %>

  <form action="signIn" method="post" id="signInForm">
    <label for="username">Username</label>
    <input type="text" name="username" id="username" required>

    <label for="password">Password</label>
    <input type="password" name="password" id="password" required>

    <input type="submit" value="signIn">
  </form>

  <p style="text-align: center; margin-top: 1rem">
    Don't have an account? <a href="jsp/signup.jsp">Register here</a>
  </p>
</div>
</body>
</html>
