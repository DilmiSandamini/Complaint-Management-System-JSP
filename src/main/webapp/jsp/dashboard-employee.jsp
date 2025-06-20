<%@ page import="lk.ijse.gdse72.cmsaad.dto.UserDTO" %>
<%@ page import="lk.ijse.gdse72.cmsaad.model.ComplaintModel" %>
<%@ page import="lk.ijse.gdse72.cmsaad.dto.ComplaintDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Employee Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(circle at top center, #2c4da8, #4f72c1, #6d90db);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            color: #fff;
            padding: 70px;
        }

        .dashboard-container {
            display: flex;
            width: 100%;
            max-width: 1700px;
            background: rgba(255, 255, 255, 0.06);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(12px);
            border-radius: 16px;
            overflow: hidden;
        }

        .dashboard-sidebar {
            width: 300px;
            background: rgba(0, 0, 0, 0.3);
            padding: 25px;
            border-right: 1px solid rgba(255, 255, 255, 0.08);
        }

        .employee-logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .employee-logo img {
            width: 80px;
            border-radius: 50%;
        }

        .employee-welcome {
            text-align: center;
            margin-bottom: 30px;
        }

        .nav-menu {
            list-style: none;
            padding-left: 0;
        }

        .nav-link {
            color: #f0f0f0;
            text-decoration: none;
            padding: 10px 14px;
            display: block;
            border-radius: 6px;
            margin-bottom: 10px;
            transition: background 0.3s;
        }

        .nav-link:hover,
        .nav-link.active {
            background: rgba(255, 255, 255, 0.12);
            color: #ffffff;
        }

        .logout-btn {
            display: block;
            margin-top: 30px;
            padding: 10px;
            background: linear-gradient(to right, #1e3c72, #2a5298);
            color: #fff;
            text-align: center;
            border-radius: 6px;
            font-weight: bold;
            text-decoration: none;
            transition: 0.3s;
        }

        .dashboard-content {
            flex: 1;
            padding: 40px;
        }

        .dashboard-header h1 {
            font-size: 2.2rem;
            margin-bottom: 8px;
        }

        .card-title {
            font-size: 2.4rem;
        }

        .card-text {
            font-size: 1.1rem;
        }

        canvas {
            max-width: 100%;
        }

        .vertical-stack {
            display: flex;
            flex-direction: column;
            gap: 30px;
            width: 100%;
        }

        .pie-chart-card,
        .status-card,
        .recent-activity {
            border: 2px solid rgba(255, 255, 255, 0.25);
            background: rgba(255, 255, 255, 0.07);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            animation: fadeInUp 0.8s ease-in-out forwards;
            opacity: 0;
        }

        .status-card:hover,
        .pie-chart-card:hover,
        .recent-activity:hover {
            transform: scale(1.03);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.3);
        }

        .recent-activity {
            padding: 20px;
            color: #fff;
        }

        .activity-title {
            font-size: 1.5rem;
            margin-bottom: 20px;
        }

        .activity-item {
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 15px 0;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-header {
            font-weight: 600;
        }

        .activity-status {
            font-size: 0.9rem;
            margin-left: 10px;
        }

        .activity-subject {
            font-size: 1rem;
            margin-top: 5px;
        }

        .activity-text {
            font-size: 0.9rem;
            margin-top: 5px;
            color: #dfefff;
        }

        .activity-time {
            font-size: 0.8rem;
            margin-top: 5px;
            color: #ccc;
        }

        .empty-state {
            text-align: center;
            padding: 20px;
            color: #dceeff;
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/signin.jsp");
        return;
    }
    ComplaintModel complaintModel = new ComplaintModel();
    List<ComplaintDTO> complaints = complaintModel.getComplaintsByUser(user.getUserId());
    List<ComplaintDTO> complaintsWithRemarks = new ArrayList<>();

    int pendingCount = 0, resolvedCount = 0, inProgressCount = 0, rejectedCount = 0;
    if (complaints != null && !complaints.isEmpty()) {
        for (ComplaintDTO complaint : complaints) {
            String status = complaint.getStatus() != null ? complaint.getStatus().toLowerCase() : "pending";
            switch (status) {
                case "pending": pendingCount++; break;
                case "resolved": resolvedCount++; break;
                case "in_progress": inProgressCount++; break;
                case "rejected": rejectedCount++; break;
            }
            if (complaint.getAdminRemarks() != null && !complaint.getAdminRemarks().trim().isEmpty()) {
                complaintsWithRemarks.add(complaint);
            }
        }
    }
%>
<div class="dashboard-container">
    <aside class="dashboard-sidebar">
        <div class="employee-logo">
            <h2>Complaints Management System</h2>
            <div>
                <img src="${pageContext.request.contextPath}/assets/icon/Customer Image.gif" alt="Employee Logo" style="width: 150px; height: 150px;">
                <h3>Welcome</h3>
            </div>
        </div>
        <div class="employee-welcome">

            <span style="color:#162349; font-size: 1.5rem;font-weight: 500"><%= user.getFirstName() %> <%= user.getLastName() %></span>
        </div>
        <nav>
            <ul class="nav-menu">
                <li><a href="#" class="nav-link active">Dashboard</a></li>
                <li><a href="complaint-form.jsp" class="nav-link">New Complaint</a></li>
                <li><a href="my-complaints.jsp" class="nav-link">My Complaints</a></li>
            </ul>
        </nav>
        <a href="<%= request.getContextPath() %>/logout" class="logout-btn">Logout</a>
    </aside>
    <main class="dashboard-content">
        <header class="dashboard-header mb-4">
            <h2>Employee Dashboard</h2>
            <p>Welcome to your dashboard. Check your latest updates below.</p>
        </header>
        <div class="d-flex gap-5 flex-wrap">
            <div class="card pie-chart-card w-75" style="max-width: 400px; padding: 30px;">
                <canvas id="statusPieChart"></canvas>
            </div>
            <div class="w-75" style="max-width: 400px;">
                <div class="card status-card text-white bg-warning mb-3 text-center ">
                    <div class="card-body">
                        <h3 class="card-title"><%= pendingCount %></h3>
                        <p class="card-text">Pending</p>
                    </div>
                </div>
                <div class="card status-card text-white bg-primary mb-3 text-center">
                    <div class="card-body">
                        <h3 class="card-title"><%= inProgressCount %></h3>
                        <p class="card-text">In Progress</p>
                    </div>
                </div>
                <div class="card status-card text-white bg-success mb-3 text-center">
                    <div class="card-body">
                        <h3 class="card-title"><%= resolvedCount %></h3>
                        <p class="card-text">Resolved</p>
                    </div>
                </div>
                <div class="card status-card text-white bg-danger text-center">
                    <div class="card-body">
                        <h3 class="card-title"><%= rejectedCount %></h3>
                        <p class="card-text">Rejected</p>
                    </div>
                </div>
            </div>

            <div class="recent-activity glass w-50" style="max-width: 400px;">
                <h3 class="activity-title">
                    Recent Admin Remarks
                </h3>

                <div class="activity-list">
                    <%
                        if (!complaintsWithRemarks.isEmpty()) {
                            int maxRemarks = Math.min(5, complaintsWithRemarks.size());
                            for (int i = complaintsWithRemarks.size() - 1; i >= complaintsWithRemarks.size() - maxRemarks; i--) {
                                ComplaintDTO complaint = complaintsWithRemarks.get(i);
                                String status = complaint.getStatus() != null ? complaint.getStatus().toLowerCase() : "pending";
                                String statusClass = status.replace("_", "-");

                    %>
                    <div class="activity-item <%= statusClass %>">
                        <div class="activity-content">
                            <div class="activity-header">
                                <span class="complaint-id">Complaint : <%= complaint.getComplaintId() %></span>
<%--                                <span class="activity-status <%= statusClass %>">--%>
<%--                                <%= status.replace("_", " ").toUpperCase() %>--%>
<%--                            </span>--%>
                            </div>
                            <div class="activity-subject">
                                 <%= complaint.getTitle() != null ? complaint.getTitle() : "General" %>
                            </div>
                            <div class="activity-text" style="color: darkblue; font-weight: 700; font-size: 1.2rem">
                                 <%= complaint.getAdminRemarks() %>
                            </div>
                        </div>
                        <div class="activity-time">
                            <%= complaint.getCreatedAt() != null ? complaint.getCreatedAt().toString() : "N/A" %>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <div class="empty-state">
                        <p>No admin remarks available yet.</p>
                        <small>Remarks will appear here when admins respond to your complaints.</small>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('statusPieChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Pending', 'In Progress', 'Resolved', 'Rejected'],
            datasets: [{
                label: 'Status Distribution',
                data: [<%= pendingCount %>, <%= inProgressCount %>, <%= resolvedCount %>, <%= rejectedCount %>],
                backgroundColor: ['#ffcc00', '#3399ff', '#28a745', '#dc3545'],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: '#ffffff'
                    }
                }
            }
        }
    });
</script>
</body>
</html>