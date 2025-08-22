<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.IssuedBook" %>
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
    <title>My Issued Books</title>
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
        .btn-warning, .btn-danger {
            min-width: 80px;
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
    <div class="card card-custom p-4">
        <h2 class="text-center text-primary mb-4">📚 My Issued Books</h2>

        <%
            List<IssuedBook> myBooks = (List<IssuedBook>) request.getAttribute("myBooks");
            if (myBooks != null && !myBooks.isEmpty()) {
        %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="text-center">
                    <tr>
                        <th>Book Name</th>
                        <th>Issue Date</th>
                        <th>Return Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (IssuedBook ib : myBooks) {
                %>
                    <tr>
                        <td><%= ib.getBookName() %></td>
                        <td><%= ib.getIssueDate() %></td>
                        <td><%= ib.getReturnDate() %></td>
                        <td class="text-center">
                            <!-- Renew Button -->
                            <form action="<%= request.getContextPath() %>/RenewBookServlet" method="post" class="d-inline">
                                <input type="hidden" name="issuedBookId" value="<%= ib.getId() %>">
                                <button type="submit" class="btn btn-sm btn-warning">Renew</button>
                            </form>

                            <!-- Return Button -->
                            <form action="<%= request.getContextPath() %>/ReturnBookServlet" method="post" class="d-inline">
                                <input type="hidden" name="issue_id" value="<%= ib.getId() %>">
                                <button type="submit" class="btn btn-sm btn-danger">Return</button>
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <%
            } else {
        %>
        <div class="alert alert-info text-center shadow-sm">
            You have not issued any books yet.
        </div>
        <%
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
