<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
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
    <title>Search Books</title>
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
        .table th {
            background-color: #0d6efd;
            color: white;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="student_home.jsp">📘 Library System</a>
        <div class="d-flex">
            <span class="navbar-text text-white me-3">
                Welcome, <%= student.getName() %>
            </span>
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-5">
    <div class="card card-custom p-4">
        <h2 class="text-center text-primary mb-4">🔍 Search Books</h2>

        <!-- Search Form -->
        <form action="<%= request.getContextPath() %>/SearchBookServlet" method="get" class="d-flex justify-content-center mb-4">
            <input type="text" name="keyword" class="form-control w-50 me-2" placeholder="Enter book name or author" required>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>

        <!-- Search Results -->
        <%
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null) {
                if (books.isEmpty()) {
        %>
            <div class="alert alert-warning text-center">No books found.</div>
        <%
                } else {
        %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="text-center">
                    <tr>
                        <th>Name</th>
                        <th>Author</th>
                        <th>Edition</th>
                        <th>Quantity</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Book book : books) {
                %>
                    <tr>
                        <td><%= book.getName() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getEdition() %></td>
                        <td><%= book.getQuantity() %></td>
                        <td class="text-center">
                            <% if (book.getQuantity() > 0) { %>
                                <!-- Issue Button -->
                                <form action="<%= request.getContextPath() %>/IssueBookServlet" method="post" class="d-inline">
                                    <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-success">Issue</button>
                                </form>
                            <% } else { %>
                                <!-- Reserve Button -->
                                <form action="<%= request.getContextPath() %>/ReserveBookServlet" method="post" class="d-inline">
                                    <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-warning">Reserve</button>
                                </form>
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <%
                }
            }
        %>

        <!-- Back Button -->
        <div class="text-center mt-4">
        <a href="<%= request.getContextPath() %>/student/home.jsp" class="btn btn-secondary">
                    ⬅ Back to Dashboard
            </a>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
