<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.IssuedBook" %>
<%@ page import="model.User" %>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<IssuedBook> issuedBooks = (List<IssuedBook>) request.getAttribute("issuedBooks");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Issued Books</title>
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
            <span class="text-white me-3">Welcome, <%= admin.getName() %></span>
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<!-- Issued Books Table -->
<div class="container table-container">
    <div class="card p-4">
        <h3 class="text-center text-primary mb-4">📖 Issued Books</h3>

        <%
            if (issuedBooks != null && !issuedBooks.isEmpty()) {
        %>
        <table class="table table-bordered table-striped align-middle">
            <thead class="table-dark">
                <tr>
                    <th>Book Name</th>
                    <th>Student Name</th>
                    <th>Issue Date</th>
                    <th>Return Date</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (IssuedBook ib : issuedBooks) {
                %>
                <tr>
                    <td><%= ib.getBookName() %></td>
                    <td><%= ib.getStudentName() %></td>
                    <td><%= ib.getIssueDate() %></td>
                    <td><%= ib.getReturnDate() != null ? ib.getReturnDate() : "Not Returned" %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p class="text-center text-muted">No books issued yet.</p>
        <% } %>

        <!-- Back Button -->
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
