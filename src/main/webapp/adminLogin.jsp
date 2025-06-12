<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<head>
    <style>
        .container {
            max-width: 600px;
            margin-top: 50px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: bold;
        }

        .form-control {
            border-radius: 5px;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 10px 20px;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .mb-3 {
            margin-bottom: 1.5rem;
        }

        .text-center {
            text-align: center;
        }
    </style>
</head>

<div class="container">
    <h2 class="text-center">Admin Login</h2>
    <form action="logincheck3.jsp" method="POST">
 
    
        <div class="mb-3">
            <label for="adminId" class="form-label">Admin ID</label>
            <input type="text" class="form-control" id="adminId" name="adminId" placeholder="Enter Admin ID" required>
        </div>
        <div class="mb-3">
            <label for="username" class="form-label">Admin Name</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="Enter Admin Name" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
        </div>

        <button type="submit" class="btn btn-primary">Login as Admin</button>

    </form>
</div>










