<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #eef2f7;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-container {
            max-width: 500px;
            margin: 80px auto;
            padding: 40px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .login-container h2 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 30px;
            color: #343a40;
        }

        .login-btn {
            display: block;
            width: 100%;
            margin: 10px 0;
            padding: 12px;
            font-size: 1rem;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 123, 255, 0.2);
        }

        .footer-note {
            margin-top: 30px;
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Select Login</h2>
    <a href="studentLogin.jsp" class="btn btn-primary login-btn">Student Login</a>
    <a href="facultyLogin.jsp" class="btn btn-success login-btn">Faculty Login</a>
    <a href="adminLogin.jsp" class="btn btn-dark login-btn">Admin Login</a>

    <p class="footer-note">Please select the appropriate portal to log in securely.</p>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
