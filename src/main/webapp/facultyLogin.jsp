<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="header.jsp" %>
<head>
    <title>Faculty Login</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

   <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
         
        
        }

        .container {
            max-width: 550px;
            background: #fff;
            padding: 30px 25px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-top:3% ;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            color: #343a40;
        }

        .form-label {
            font-weight: 600;
        }

        .form-control {
            border-radius: 6px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.06);
            transition: border-color 0.3s ease;
            padding: 10px 12px;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 6px rgba(0,123,255,0.4);
            outline: none;
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 16px;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: #dc3545;
            font-size: 0.95rem;
            margin-top: 15px;
            text-align: center;
        }
    </style>
</head>

<body>

<div class="container">
    <div class="login-box">
        <h2>Faculty Login</h2>
       <form action="logincheck2.jsp" method="POST">
        
        <div class="mb-3">
            <label for="facultyId" class="form-label">Faculty ID</label>
            <input type="text" name="facultyId" id="facultyId" class="form-control" placeholder="Enter Faculty ID" required>
        </div>
        <div class="mb-3">
            <label for="username" class="form-label">Faculty Name</label>
            <input type="text" name="username" id="username" class="form-control" placeholder="Enter Faculty Name" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="btn btn-primary">Login</button>
</form>
    </div>
</div>

</body>
</html>
