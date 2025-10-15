<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String bookIdParam = request.getParameter("book_id");
    if (bookIdParam == null || bookIdParam.isEmpty()) {
        response.sendRedirect("ViewBooksServlet");
        return;
    }

    int bookId = Integer.parseInt(bookIdParam);
    UserDAO dao = new UserDAO();
    List<User> students = dao.getAllStudents();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Issue Book</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .form-card { max-width: 600px; margin: auto; border-radius: 10px; box-shadow: 0 6px 15px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<nav class="navbar navbar-light bg-dark shadow-sm">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h5 text-white">📚 Library Admin</span>
        <div>
            <span class="text-white me-3">Welcome, <%= admin.getName() %></span>
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="card form-card p-4">
        <h3 class="text-center text-primary mb-4">📖 Issue Book</h3>

        <form action="<%= request.getContextPath() %>/IssueBookServlet" method="post">
            <input type="hidden" name="book_id" value="<%= bookId %>">

            <div class="mb-3">
                <label class="form-label">Book ID</label>
                <input type="text" class="form-control" value="<%= bookId %>" disabled>
            </div>

            <div class="mb-3">
                <label class="form-label">Select Student</label>
                <select name="student_id" class="form-select" required>
                    <% for (User student : students) { %>
                        <option value="<%= student.getId() %>">
                            <%= student.getName() %> (<%= student.getMembershipNo() %>)
                        </option>
                    <% } %>
                </select>
            </div>

            <div class="d-flex justify-content-between">
                <a href="admin_dashboard.jsp" class="btn btn-secondary">⬅ Back to Dashboard</a>
                <button type="submit" class="btn btn-primary">Issue Book</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
