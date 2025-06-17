<%--
  Created by IntelliJ IDEA.
  User: chathuranga
  Date: 6/16/2025
  Time: 8:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Submit Complaint Form</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/complaintForm.css">
</head>
<body>
<div class="container">
    <form action="<%= request.getContextPath() %>/jsp/dashboard-employee.jsp" style="position: absolute; right: 10px; top: 10px;">
        <button type="submit" style="background-color:darkmagenta; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer;">
            DashBoard
        </button>
    </form>
    <h1>Submit Complaint</h1>
    <form action="${pageContext.request.contextPath}/employee/submit-complaint" method="post">

        <label for="department">Department</label>
        <input type="text" name="department" id="department" class="${not empty departmentError ? 'invalid' : ''}">
        <span class="error" id="departmentError">${departmentError != null ? departmentError : ''}</span>

        <label for="title">Title</label>
        <input type="text" name="title" id="title" class="${not empty titleError ? 'invalid' : ''}">
        <span class="error" id="titleError">${titleError != null ? titleError : ''}</span>

        <label for="description">Description</label>
        <textarea name="description" rows="4" id="description"  class="${not empty descriptionError ? 'invalid' : ''}"></textarea>
        <span class="error" id="descriptionError">${descriptionError != null ? descriptionError : ''}</span>

        <input type="submit" value="Submit">
    </form>

<%--    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>
<%--    <script src="${pageContext.request.contextPath}/js/complaintFormValidation.js"></script>--%>
</div>
</body>
</html>
