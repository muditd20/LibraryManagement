<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f8f9fa; /* light gray background */
        }
        .card-custom {
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .card-custom:hover {
            transform: translateY(-4px);
        }
        .welcome-text {
            font-weight: 600;
            color: #333;
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
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Page Content -->
<div class="container mt-5">
    <div class="row mb-4">
        <div class="col text-center">
            <h2 class="welcome-text">Student Dashboard</h2>
            <p class="text-muted">Manage your books and explore the library.</p>
        </div>
    </div>

    <div class="row justify-content-center g-4">
        <!-- My Books -->
        <div class="col-md-4">
            <div class="card card-custom text-center p-4">
                <i class="bi bi-journal-check fs-1 text-primary"></i>
                <h5 class="mt-3">My Books</h5>
                <p class="text-muted">View and manage books you have issued.</p>
                <a href="${pageContext.request.contextPath}/MyBooksServlet" class="btn btn-primary w-100">
                    Go to My Books
                </a>
            </div>
        </div>

        <!-- Search Books -->
        <div class="col-md-4">
            <div class="card card-custom text-center p-4">
                <i class="bi bi-search fs-1 text-success"></i>
                <h5 class="mt-3">Search Books</h5>
                <p class="text-muted">Find books available in the library.</p>
                <a href="${pageContext.request.contextPath}/student/search_books.jsp" class="btn btn-success w-100">
                    Search Books
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
