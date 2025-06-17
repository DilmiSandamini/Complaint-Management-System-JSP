<%@ page import="lk.ijse.gdse72.cmsaad.dto.UserDTO" %>
<%@ page import="lk.ijse.gdse72.cmsaad.model.ComplaintModel" %>
<%@ page import="lk.ijse.gdse72.cmsaad.dto.ComplaintDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: chathuranga
  Date: 6/15/2025
  Time: 3:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="../css/employeeDashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>
<body>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    ComplaintModel complaintModel = new ComplaintModel();
    List<ComplaintDTO> complaints = complaintModel.getComplaintsByUser(user.getUserId());

    int pendingCount = 0;
    int resolvedCount = 0;
    int inProgressCount = 0;
    int rejectedCount = 0;

    if (complaints != null && !complaints.isEmpty()) {
        for (ComplaintDTO complaint : complaints) {
            String status = complaint.getStatus() != null ? complaint.getStatus().toLowerCase() : "pending";

            if ("pending".equals(status)) {
                pendingCount++;
            } else if ("resolved".equals(status)) {
                resolvedCount++;
            } else if ("in_progress".equals(status)) {
                inProgressCount++;
            } else if ("rejected".equals(status)) {
                rejectedCount++;
            }
        }
    }
%>

<div class="dashboard-container">
    <aside class="dashboard-sidebar">
        <div class="employee-logo">
            <img src="assets/icon/Customer Image.gif" alt="Employee Logo">
            <p>Employee Dashboard</p>
        </div>

        <div class="employee-welcome">
            <h2>Hello</h2>
            <span><%= user.getUserId() %></span>
            <span>
    <%=
    (user.getFirstName() != null ? user.getFirstName() : "") +
            " " +
            (user.getLastName() != null ? user.getLastName() : "")
    %>
        </span>
        </div>

        <nav>
            <ul class="nav-menu">
                <li class="nav-item">
                    <a href="#dashboard" class="nav-link active">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="complaint-form.jsp" class="nav-link">
                        <i class="nav-icon fas fa-plus-circle"></i>
                        <span>New Complaint</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="my-complaints.jsp" class="nav-link">
                        <i class="nav-icon fas fa-list-alt"></i>
                        <span>My Complaints</span>
                    </a>
                </li>
            </ul>
        </nav>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Logout</a>
    </aside>
    <main class="dashboard-content">
        <header class="dashboard-header">
            <h1>Dashboard</h1>
            <p>Welcome to your dashboard, <%= user.getFirstName() %>!</p>
        </header>
    </main>

    </div>
</body>
</html>
