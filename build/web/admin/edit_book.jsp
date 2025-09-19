<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Book" %>
<%@ page import="model.User" %>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }

    Book book = (Book) request.getAttribute("book");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            margin-top: 40px;
            max-width: 600px;
        }
        .card {
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
            <span class="text-white me-3">Welcome, <%= admin.getName() %></span>
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<!-- Edit Book Form -->
<div class="container form-container">
    <div class="card p-4">
        <h3 class="text-center text-primary mb-4">✏ Edit Book</h3>

        <form action="<%= request.getContextPath() %>/EditBookServlet" method="post">
            <input type="hidden" name="id" value="<%= book.getId() %>">

            <div class="mb-3">
                <label class="form-label">Book Name</label>
                <input type="text" name="name" class="form-control" value="<%= book.getName() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Author</label>
                <input type="text" name="author" class="form-control" value="<%= book.getAuthor() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Edition</label>
                <input type="text" name="edition" class="form-control" value="<%= book.getEdition() %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Quantity</label>
                <input type="number" name="quantity" class="form-control" value="<%= book.getQuantity() %>" min="1" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Parking Slot</label>
                <input type="text" name="parkingSlot" class="form-control" value="<%= book.getParkingSlot() %>" required>
            </div>

            <div class="d-flex justify-content-between">
                <a href="admin_dashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
                <button type="submit" class="btn btn-primary">💾 Update Book</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
