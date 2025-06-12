<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    HttpSession sessionn = request.getSession(false);
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="refresh" content="2;url=index.jsp">
    <title>Logging Out</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .logout-box {
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            text-align: center;
            max-width: 400px;
        }

        .logout-box h2 {
            color: #004080;
            margin-bottom: 15px;
        }

        .logout-box p {
            color: #555;
            font-size: 16px;
        }

        .spinner {
            margin-top: 20px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #004080;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 1s linear infinite;
            display: inline-block;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="logout-box">
        <h2>You have been successfully logged out.</h2>
        <p>Redirecting to homepage...</p>
        <div class="spinner"></div>
    </div>
</body>
</html>
