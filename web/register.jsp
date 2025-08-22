<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Library Management - Register</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(120deg, #6a11cb, #2575fc);
            background-size: 200% 200%;
            animation: gradientBG 6s ease infinite;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .register-container {
            display: flex;
            width: 80%;
            max-width: 950px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.25);
            border-radius: 15px;
            overflow: hidden;
        }
        .register-image {
            flex: 1;
            background: url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f') no-repeat center center;
            background-size: cover;
        }
        .register-card {
            flex: 1;
            background-color: #fff;
            padding: 3rem;
        }
        .register-card h3 {
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            color: #2575fc;
        }
        /* input & select ke liye same padding */
        .form-control,
        .form-select {
            padding-left: 40px;
        }
        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #2575fc;
            pointer-events: none;
        }
        .form-group {
            position: relative;
        }
        .btn-register {
            background: linear-gradient(45deg, #2575fc, #6a11cb);
            color: #fff;
            font-weight: 600;
            border: none;
            border-radius: 30px;
            transition: 0.3s ease;
        }
        .btn-register:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        .login-link {
            margin-top: 1.5rem;
            text-align: center;
        }
        .login-link a {
            font-weight: 600;
            text-decoration: none;
            color: #2575fc;
        }
        .login-link a:hover {
            color: #6a11cb;
        }
    </style>
</head>
<body>

<div class="register-container">
    <!-- Left side image -->
    <div class="register-image d-none d-md-block"></div>

    <!-- Right side form -->
    <div class="register-card">
        <h3>Create Your Account</h3>
        <form action="RegisterServlet" method="post">
            <div class="form-group mb-3">
                <i class="bi bi-person-fill input-icon"></i>
                <input type="text" class="form-control" name="name" placeholder="Full Name" required>
            </div>

            <div class="form-group mb-3">
                <i class="bi bi-envelope-fill input-icon"></i>
                <input type="email" class="form-control" name="email" placeholder="Email" required>
            </div>

            <div class="form-group mb-3">
                <i class="bi bi-key-fill input-icon"></i>
                <input type="text" class="form-control" name="membership_no" placeholder="Membership No" required>
            </div>

            <div class="form-group mb-3">
                <i class="bi bi-lock-fill input-icon"></i>
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>

            <div class="form-group mb-4">
                <i class="bi bi-person-badge-fill input-icon"></i>
                <select class="form-select" name="role" required>
                    <option value="">-- Select Role --</option>
                    <option value="ADMIN">Admin</option>
                    <option value="STUDENT">Student</option>
                </select>
            </div>

            <button type="submit" class="btn btn-register w-100 py-2">Register</button>
        </form>

        <div class="login-link">
            Already have an account? <a href="index.jsp">Login Here</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
