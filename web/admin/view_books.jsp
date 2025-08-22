<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Book" %>
<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Books</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-container {
            margin-top: 40px;
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
            <span class="text-white me-3">Welcome, <%= user.getName() %></span>
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<!-- Books Table -->
<div class="container table-container">
    <div class="card p-4">
        <h3 class="text-center text-primary mb-4">📖 All Books</h3>

        <table class="table table-bordered table-striped align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Author</th>
                    <th>Edition</th>
                    <th>Quantity</th>
                    <th>Parking Slot</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (books != null && !books.isEmpty()) {
                        for (Book b : books) {
                %>
                <tr>
                    <td><%= b.getId() %></td>
                    <td><%= b.getName() %></td>
                    <td><%= b.getAuthor() %></td>
                    <td><%= b.getEdition() %></td>
                    <td><%= b.getQuantity() %></td>
                    <td><%= b.getParkingSlot() %></td>
                    <td>
                        <!-- Edit -->
                        <a href="<%= request.getContextPath() %>/EditBookServlet?id=<%= b.getId() %>" 
                           class="btn btn-sm btn-warning me-1">✏ Edit</a>

                        <!-- Delete -->
                        <a href="<%= request.getContextPath() %>/DeleteBookServlet?id=<%= b.getId() %>" 
                           class="btn btn-sm btn-danger me-1" 
                           onclick="return confirm('Delete this book?')">🗑 Delete</a>

                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7" class="text-center text-muted">No books available</td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Only Back button -->
        <div class="mt-3">
<a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="btn btn-secondary">
                 ⬅ Back to Dashboard
                    </a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
