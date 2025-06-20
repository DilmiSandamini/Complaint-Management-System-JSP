<%@ page import="lk.ijse.gdse72.cmsaad.model.ComplaintModel" %>
<%@ page import="lk.ijse.gdse72.cmsaad.dto.ComplaintDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>All Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: radial-gradient(circle at top center, #2c4da8, #163883, #4a74cf);
            min-height: 100vh;
            margin: 0;
            padding: 80px 40px;
            color: #fff;
        }

        .container {
            background: rgba(255, 255, 255, 0.07);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(12px);
            max-width: 1800px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #ffffff;
        }

        .stats-bar {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.08);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            margin: 10px;
            min-width: 160px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: scale(1.05);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
        }

        .stat-label {
            font-size: 1rem;
            color: #dceeff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 16px;
            text-align: left;
            color: #fff;
        }

        th {
            background-color: rgba(255, 255, 255, 0.1);
        }

        tr:nth-child(even) {
            background-color: rgba(255, 255, 255, 0.03);
        }

        .status-pending {
            color: #ffcc00;
        }

        .status-in_progress {
            color: #3399ff;
        }

        .status-resolved {
            color: #28a745;
        }

        .status-rejected {
            color: #dc3545;
        }

        .delete-link, .view-link, .action-form input[type="submit"] {
            background: #dc3545;
            border: none;
            padding: 5px 10px;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s;
        }

        .delete-link:hover {
            background: #b02a37;
        }

        .action-form select {
            padding: 5px;
            border-radius: 4px;
            margin-right: 6px;
            border: 1px solid #ccc;
        }

        .action-form input[type="submit"] {
            background-color: #2c4da8;
        }

        .action-form input[type="submit"]:hover {
            background-color: #1e3c72;
        }

        .no-complaints {
            text-align: center;
            padding: 20px;
            color: #dceeff;
        }

        .error-message {
            color: #ff4d4d;
            text-align: center;
        }

        .dashboard-back-button {
            text-align: right;
            margin-bottom: 30px;
        }

        .dashboard-back-button button {
            padding: 10px 20px;
            background-color: #0056b3;
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        .dashboard-back-button button:hover {
            background-color: #4f72c1;
            color: #ffffff;
            box-shadow: 0 6px 30px rgba(0, 0, 0, 0.35);
        }

        /* General pill style for status */
        td span[class^="status-"] {
            display: inline-block;
            padding: 6px 14px;
            font-size: 0.85rem;
            font-weight: 600;
            color: #fff;
            border-radius: 20px;
            text-transform: capitalize;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
        }

        /* Status-specific background colors */
        .status-pending {
            background-color: #ffcc00;
            color: #000;
        }

        .status-in_progress {
            background-color: #3399ff;
        }

        .status-resolved {
            background-color: #28a745;
        }

        .status-rejected {
            background-color: #dc3545;
        }

    </style>
</head>
<body>
<div class="container">
    <div class="dashboard-back-button">
        <form action="<%= request.getContextPath() %>/jsp/dashboard-admin.jsp">
            <button type="submit">Dashboard</button>
        </form>
    </div>

    <h1>All Complaints Management</h1>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="error-message"><%= error %></div>
    <%
        }

        ComplaintModel complaintModel = new ComplaintModel();
        List<ComplaintDTO> complaints = complaintModel.getAllComplaints();

        int totalComplaints = 0;
        int pendingCount = 0;
        int resolvedCount = 0;
        int inProgressCount = 0;
        int rejectedCount = 0;

        if (complaints != null) {
            totalComplaints = complaints.size();

            for (ComplaintDTO complaint : complaints) {
                String status = complaint.getStatus() != null ? complaint.getStatus().toLowerCase() : "";

                if ("pending".equals(status)) pendingCount++;
                else if ("resolved".equals(status)) resolvedCount++;
                else if ("in_progress".equals(status)) inProgressCount++;
                else if ("rejected".equals(status)) rejectedCount++;
            }
        }
    %>

    <div class="stats-bar">
        <div class="stat-card">
            <div class="stat-number"><%= totalComplaints %></div>
            <div class="stat-label">Total Complaints</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= pendingCount %></div>
            <div class="stat-label">Pending</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= inProgressCount %></div>
            <div class="stat-label">In Progress</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= resolvedCount %></div>
            <div class="stat-label">Resolved</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= rejectedCount %></div>
            <div class="stat-label">Rejected</div>
        </div>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
            <tr>
                <th style="display: none">ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Department</th>
                <th>Status</th>
                <th>Submitted By</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (complaints != null && !complaints.isEmpty()) {
                    for (ComplaintDTO complaint : complaints) {
                        String statusClass = complaint.getStatus() != null ? complaint.getStatus().toLowerCase() : "";
            %>
            <tr>
                <td style="display: none"><%= complaint.getComplaintId() %></td>
                <td class="title-cell"><strong><%= complaint.getTitle() %></strong></td>
                <td><%= complaint.getDescription() %></td>
                <td><%= complaint.getDepartment() %></td>
                <td>
                    <span class="status-<%= statusClass %>">
                        <%= complaint.getStatus() != null ? complaint.getStatus().replace("_", " ") : "Unknown" %>
                    </span>
                </td>
                <td><%= complaint.getSubmittedByName() != null ? complaint.getSubmittedByName() : complaint.getSubmittedBy() %></td>
                <td><%= complaint.getCreatedAt() %></td>
                <td>
                    <div class="action-form">
                        <form action="<%= request.getContextPath() %>/admin/complaint-status-edit" method="post" style="display:inline-block;">
                            <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>" />
                            <select name="status" required>
                                <option value="PENDING" <%= "PENDING".equals(complaint.getStatus()) ? "selected" : "" %>>Pending</option>
                                <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
                                <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                                <option value="REJECTED" <%= "REJECTED".equals(complaint.getStatus()) ? "selected" : "" %>>Rejected</option>
                            </select>
                            <input type="text" name="adminRemarks" placeholder="Admin remarks..." value="<%= complaint.getAdminRemarks() != null ? complaint.getAdminRemarks() : "" %>">
                            <input type="submit" value="Update">
                        </form>
                    </div>
                    <form action="<%= request.getContextPath() %>/complaint/delete-complaint" method="post" onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                        <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">
                        <button type="submit" class="delete-link">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="9" class="no-complaints">
                    <h3>No complaints found</h3>
                    <p>There are currently no complaints in the system.</p>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
