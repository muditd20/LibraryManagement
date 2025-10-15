<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Reservation" %>
<%@ page import="model.User" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("../index.jsp");
        return;
    }
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Reservations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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

<div class="container mt-4">
    <h3 class="text-center text-primary">📌 Reserved Books</h3>
    <div class="card p-3 mt-3">
        <% if (reservations != null && !reservations.isEmpty()) { %>
        <table class="table table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Book</th>
                    <th>Student</th>
                    <th>Reservation Date</th>
                </tr>
            </thead>
            <tbody>
            <% for (Reservation r : reservations) { %>
                <tr>
                    <td><%= r.getBookName() %></td>
                    <td><%= r.getStudentName() %></td>
                    <td><%= r.getFormattedReservationDate() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
            <p class="text-center text-muted">No reservations yet.</p>
        <% } %>
        <div class="mt-3">
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp" class="btn btn-secondary">
                ⬅ Back to Dashboard
            </a>
       </div>
    </div>
</div>
</body>
</html>
