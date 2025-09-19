<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Book</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-card {
            max-width: 600px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-light bg-dark shadow-sm">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h5 text-white">📚 Library Admin</span>
        <div>
            <span class="text-white me-3">Welcome, <%= user.getName() %></span>
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<!-- Add Book Form -->
<div class="container mt-5">
    <div class="card form-card p-4">
        <h3 class="text-center text-primary mb-4">➕ Add New Book</h3>
        <form action="../AddBookServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Book Name</label>
                <input type="text" name="name" class="form-control" placeholder="Enter book name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Author</label>
                <input type="text" name="author" class="form-control" placeholder="Enter author name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Edition</label>
                <input type="text" name="edition" class="form-control" placeholder="Enter edition" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Quantity</label>
                <input type="number" name="quantity" class="form-control" min="1" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Parking Slot</label>
                <input type="text" name="parking_slot" class="form-control" placeholder="Enter parking slot" required>
            </div>

            <div class="d-flex justify-content-between">    
        <a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="btn btn-secondary">
                         ⬅ Back to Dashboard
                        </a>
                <button type="submit" class="btn btn-primary">Add Book</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
