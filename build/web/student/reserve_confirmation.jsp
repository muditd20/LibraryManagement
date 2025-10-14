<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reservation Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="alert alert-success text-center">
        <h4>${message}</h4>
        <a href="<%= request.getContextPath() %>/student/home.jsp" class="btn btn-primary mt-3">Back to Home</a>
    </div>
</div>
</body>
</html>
