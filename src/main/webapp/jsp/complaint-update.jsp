<%@ page import="lk.ijse.gdse72.cmsaad.dto.ComplaintDTO" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <title>Update Complaint</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            background: radial-gradient(circle at top center, #3a5ba0, #4f72b4, #6c8fcd);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: rgba(255, 255, 255, 0.07);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 40px 30px;
            color: #fff;
            max-width: 500px;
            width: 90%;
            position: relative;
        }

        h1 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 700;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #f0f0f0;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            margin-bottom: 10px;
        }

        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.3);
        }

        input[type="submit"] {
            background: linear-gradient(to right, #1e3c72, #2a5298);
            color: #fff;
            border: none;
            padding: 10px;
            width: 100%;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background: linear-gradient(to right, #2a5298, #1e3c72);
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Edit Complaint</h1>

    <form action="<%= request.getContextPath() %>/employee/update-complaint" method="post">
        <%
            ComplaintDTO complaint = (ComplaintDTO) request.getAttribute("complaint");
        %>

        <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">

        <label for="title">Title</label>
        <input type="text" name="title" id="title" value="<%= complaint.getTitle() %>" required>

        <label for="description">Description</label>
        <textarea name="description" rows="4" id="description" required><%= complaint.getDescription() %></textarea>

        <label for="department">Department</label>
        <input type="text" name="department" id="department" value="<%= complaint.getDepartment() %>" required>

        <input type="submit" value="Update">
    </form>
</div>
</body>
</html>
