<%@ page import="lk.ijse.gdse72.cmsaad.dto.UserDTO" %>
<%@ page import="lk.ijse.gdse72.cmsaad.dto.ComplaintDTO" %>
<%@ page import="lk.ijse.gdse72.cmsaad.model.ComplaintModel" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(circle at top center, #2c4da8, #4f72c1, #6d90db);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            color: #fff;
            padding: 80px;
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

        .sidebar {
            width: 300px;
            background: rgba(0, 0, 0, 0.3);
            padding: 25px;
            border-right: 1px solid rgba(255, 255, 255, 0.08);
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo h1 {
            font-size: 2rem;
            margin-bottom: 0;
        }

        .logo p {
            font-size: 0.9rem;
            color: #dceeff;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .welcome-section h2 {
            font-size: 1.2rem;
            font-weight: 500;
        }

        .nav-menu {
            list-style: none;
            padding-left: 0;
        }

        .nav-item {
            margin-bottom: 10px;
        }

        .nav-link {
            color: #f0f0f0;
            text-decoration: none;
            padding: 10px 14px;
            display: block;
            border-radius: 6px;
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
            transition: 0.3s;
            text-decoration: none;
        }

        .logout-btn:hover {
            background: linear-gradient(to right, #2a5298, #1e3c72);
            color: #fff;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        .dashboard-header h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .status-card {
            border: 2px solid rgba(255, 255, 255, 0.25);
            background: rgba(255, 255, 255, 0.07);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            padding: 20px;
            text-align: center;
            margin-bottom: 20px;
        }

        canvas {
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 15px;
        }
    </style>
</head>
<body>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
    ComplaintModel complaintModel = new ComplaintModel();
    List<ComplaintDTO> complaints = complaintModel.getAllComplaints();
    int pendingCount = 0, resolvedCount = 0, inProgressCount = 0, rejectedCount = 0;
    for (ComplaintDTO complaint : complaints) {
        String status = complaint.getStatus() != null ? complaint.getStatus().toLowerCase() : "pending";
        switch (status) {
            case "pending": pendingCount++; break;
            case "resolved": resolvedCount++; break;
            case "in_progress": inProgressCount++; break;
            case "rejected": rejectedCount++; break;
        }
    }
%>
<div class="dashboard-container">
    <aside class="sidebar">
        <div class="logo">
            <h1>Complaints Management System</h1>
            <div>
                <img src="${pageContext.request.contextPath}/assets/icon/Customer Image.gif" alt="Employee Logo" style="width: 150px; height: 150px;">
            </div>
        </div>
        <div class="welcome-section">
            <h2>Welcome</h2>
            <span style="color:#162349; font-size: 2rem;font-weight: 500"><%= (user != null) ? user.getUsername() : "Guest" %></span>
        </div>
        <ul class="nav-menu">
            <li class="nav-item"><a href="#" class="nav-link active">Dashboard</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/jsp/view-all-complaints.jsp" class="nav-link">All Complaints</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Reports</a></li>
            <li class="nav-item"><a href="#" class="nav-link">Settings</a></li>
        </ul>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
    </aside>
    <main class="main-content">
        <div class="dashboard-header mb-4">
            <h1>Admin Dashboard</h1>
            <p>Manage all complaints and system reports.</p>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="status-card text-white bg-warning">
                    <h3><%= pendingCount %></h3>
                    <p>Pending</p>
                </div>
                <div class="status-card text-white bg-primary">
                    <h3><%= inProgressCount %></h3>
                    <p>In Progress</p>
                </div>
                <div class="status-card text-white bg-success">
                    <h3><%= resolvedCount %></h3>
                    <p>Resolved</p>
                </div>
                <div class="status-card text-white bg-danger">
                    <h3><%= rejectedCount %></h3>
                    <p>Rejected</p>
                </div>
            </div>
            <div class="col-md-6">
                <canvas id="statusBarChart" style="height: 220px;"></canvas>
            </div>
        </div>
    </main>
</div>
<script>
    const ctx = document.getElementById('statusBarChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Pending', 'In Progress', 'Resolved', 'Rejected'],
            datasets: [{
                label: 'Complaint Status',
                data: [<%= pendingCount %>, <%= inProgressCount %>, <%= resolvedCount %>, <%= rejectedCount %>],
                backgroundColor: ['#ffc107', '#0d6efd', '#198754', '#dc3545'],
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: {
                    ticks: { color: '#fff' },
                    grid: { color: 'rgba(255,255,255,0.1)' }
                },
                y: {
                    beginAtZero: true,
                    ticks: { color: '#fff' },
                    grid: { color: 'rgba(255,255,255,0.1)' }
                }
            },
            plugins: {
                legend: {
                    labels: { color: '#fff' }
                }
            }
        }
    });
</script>
</body>
</html>
