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
    <title>Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-custom {
            transition: 0.3s;
            border-radius: 10px;
        }
        .card-custom:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.12);
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

<!-- Dashboard Content -->
<div class="container mt-5">
    <h3 class="text-center mb-4">️ Admin Dashboard</h3>
    <div class="row g-4">
        
        <!--Book add karne ka section  -->
        <div class="col-md-3">
            <div class="card card-custom text-center p-4 bg-light">
                <h5 class="text-primary">➕ Add Book</h5>
                <p class="text-muted">Add new books to the library collection.</p>
                <a href="add_book.jsp" class="btn btn-primary">Go</a>
            </div>
        </div>

        <!-- View Books ka logic -->
        <div class="col-md-3">
            <div class="card card-custom text-center p-4 bg-light">
                <h5 class="text-success">📖 View Books</h5>
                <p class="text-muted">Check and manage all available books.</p>
                <a href="<%= request.getContextPath() %>/ViewBooksServlet" class="btn btn-success">Go</a>
            </div>
        </div>

        <!-- View Issued Books ka logic-->
        <div class="col-md-3">
            <div class="card card-custom text-center p-4 bg-light">
                <h5 class="text-danger">📦 Issued Books</h5>
                <p class="text-muted">Track and manage issued/returned books.</p>
                <a href="<%= request.getContextPath() %>/ViewIssuedBooksServlet" class="btn btn-danger">Go</a>
            </div>
        </div>

        <!-- View Reservations ka logic-->
        <div class="col-md-3">
            <div class="card card-custom text-center p-4 bg-light">
                <h5 class="text-warning">📌 Reservations</h5>
                <p class="text-muted">View and manage reserved books by students.</p>
                <a href="<%= request.getContextPath() %>/ViewReservationsServlet" class="btn btn-warning">Go</a>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
