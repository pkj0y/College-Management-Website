<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<head>
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
    <h2>Student Login</h2>
    <form method="post" novalidate>
        <div class="mb-3">
            <label for="studentName" class="form-label">Student Name</label>
            <input type="text" name="studentName" id="studentName" class="form-control" placeholder="Enter your name" required>
        </div>
        <div class="mb-3">
            <label for="studentId" class="form-label">Student ID</label>
            <input type="text" name="studentId" id="studentId" class="form-control" placeholder="Enter your ID" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="btn btn-primary">Login</button>

        <%-- Login Logic --%>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String studentName = request.getParameter("studentName").trim();
                String studentId = request.getParameter("studentId").trim();
                String password = request.getParameter("password").trim();

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    conn = DriverManager.getConnection(
                        "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress:1433;" +
                        "databaseName=collegemgdb;" +
                        "integratedSecurity=true;" +
                        "encrypt=false;" +
                        "trustServerCertificate=true;"
                    );

                    String sql = "SELECT studentname FROM users WHERE studentid = ? AND password = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, studentId);
                    stmt.setString(2, password);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        session.setAttribute("studentId", studentId);
                        session.setAttribute("studentName", rs.getString("studentname"));
                        response.sendRedirect("studentdashbord.jsp");
                    } else {
        %>
                        <div class="error-message">Invalid Student ID or Password</div>
        <%
                    }

                } catch (Exception e) {
        %>
                    <div class="error-message">Error: <%= e.getMessage() %></div>
        <%
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                    try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
                    try { if (conn != null) conn.close(); } catch (Exception ignored) {}
                }
            }
        %>
    </form>
</div>
</body>
</html>
