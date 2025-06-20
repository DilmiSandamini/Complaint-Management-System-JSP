<%@ page import="lk.ijse.gdse72.cmsaad.dto.ComplaintDTO" %>
<%@ page import="lk.ijse.gdse72.cmsaad.dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.ijse.gdse72.cmsaad.model.ComplaintModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Complaints</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: radial-gradient(circle at top center, #1a2a6c, #1e3c72, #2a5298);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px;
        }

        .title {
            width: 100%;
            max-width: 1400px;
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            backdrop-filter: blur(12px);
            padding: 30px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .btn {
            background: linear-gradient(to right, #1e3c72, #2a5298);
            border: none;
            color: white !important;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            margin: 5px;
            font-weight: 500;
            display: inline-block;
        }

        .btn:hover {
            background: linear-gradient(to right, #2a5298, #1e3c72);
        }

        .success-msg {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
            color: #e0e0e0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        th {
            background: rgba(255, 255, 255, 0.12);
        }

        .status-pending {
            color: #ffc107;
            font-weight: 600;
        }

        .status-in_progress {
            color: #0dcaf0;
            font-weight: 600;
        }

        .status-resolved {
            color: #28a745;
            font-weight: 600;
        }

        .status-rejected {
            color: #dc3545;
            font-weight: 600;
        }

        form[method="post"] {
            display: inline;
        }

        .no-actions {
            color: #888;
            font-style: italic;
        }

        .back-button {
            position: absolute;
            right: 20px;
            top: 20px;
        }

        @media (max-width: 768px) {
            .title {
                padding: 20px;
            }

            table, thead, tbody, th, td, tr {
                display: block;
            }

            tr {
                margin-bottom: 15px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            th {
                display: none;
            }

            td {
                padding: 10px 0;
                text-align: right;
                position: relative;
            }

            td::before {
                content: attr(data-label);
                position: absolute;
                left: 0;
                color: #ccc;
                font-weight: bold;
                text-align: left;
                padding-left: 10px;
            }
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
<div class="title position-relative">
    <form action="<%= request.getContextPath() %>/jsp/dashboard-employee.jsp" class="back-button">
        <button type="submit" class="btn">Dashboard</button>
    </form>

    <h1>My Complaints</h1>

    <%
        String success = request.getParameter("success");
        if ("1".equals(success)) {
    %>
    <%
        }
    %>

    <a href="<%= request.getContextPath() %>/employee/submit-complaint" class="btn">Submit New Complaint</a>

    <table>
        <thead>
        <tr>
            <th>Complaint ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Department</th>
            <th>Status</th>
            <th>Created Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<ComplaintDTO> complaints = null;
            UserDTO currentUser = (UserDTO) session.getAttribute("user");
            if (currentUser == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            String userId = currentUser.getUserId();

            try {
                ComplaintModel complaintModel = new ComplaintModel();
                complaints = complaintModel.getComplaintsByUser(userId);
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (complaints != null && !complaints.isEmpty()) {
                for (ComplaintDTO complaint : complaints) {
        %>
        <tr>
            <td data-label="Complaint ID"><%= complaint.getComplaintId() %></td>
            <td data-label="Title"><strong><%= complaint.getTitle() %></strong></td>
            <td data-label="Description"><%= complaint.getDescription() %></td>
            <td data-label="Department"><%= complaint.getDepartment() %></td>
            <td data-label="status">
                <span class="status-<%= complaint.getStatus().toLowerCase() %>">
                    <%= complaint.getStatus() %>
                </span>
            </td>
            <td data-label="Created Date">
                <%= complaint.getCreatedAt() != null ? complaint.getCreatedAt().toString() : "N/A" %>
            </td>
            <td data-label="Actions">
                <%
                    if ("PENDING".equalsIgnoreCase(complaint.getStatus())) {
                %>
                <a href="<%= request.getContextPath() %>/employee/update-complaint?complaintId=<%= complaint.getComplaintId() %>" class="btn">Edit</a>
                <form action="<%= request.getContextPath() %>/complaint/delete-complaint" method="post"
                      onsubmit="return confirm('Are you sure you want to delete this complaint?');">
                    <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">
                    <button type="submit" class="btn">Delete</button>
                </form>
                <%
                } else {
                %>
                <span class="no-actions">No actions available</span>
                <%
                    }
                %>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="7" style="text-align: center; padding: 40px;">
                <h4>No complaints found</h4>
                <p>You haven't submitted any complaints yet.</p>
                <a href="<%= request.getContextPath() %>/employee/submit-complaint" class="btn">Submit Your First Complaint</a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <% if (complaints != null) { %>
    <p style="margin-top: 20px; color: #ccc;">
        Total Complaints: <%= complaints.size() %>
    </p>
    <% } %>
</div>
</body>
</html>
