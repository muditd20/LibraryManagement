<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    User student = (User) session.getAttribute("user");
    if (student == null || !"STUDENT".equalsIgnoreCase(student.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Issue Confirmation</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-custom {
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .success-icon {
            font-size: 60px;
            color: #28a745;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#">📚 Library Portal</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="nav-link">Welcome, <strong>${sessionScope.user.name}</strong></span>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light" href="${pageContext.request.contextPath}/LogoutServlet">
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Content -->
<div class="container mt-5">
    <div class="card card-custom p-5 text-center">
        <div class="success-icon mb-3"></div>
        <h2 class="text-success mb-3">${message}</h2>
        <p class="text-muted">Your book has been successfully issued.</p>
        
        <div class="mt-4">
            <a href="student_home.jsp" class="btn btn-primary">🏠 Back to Dashboard</a>
<a href="${pageContext.request.contextPath}/MyBooksServlet" class="btn btn-outline-secondary ms-2">
    📖 View My Books
</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
