<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<head>
    <style>
        body {
            background-color: #f4f6f8;
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 800px;
        }

        .text-center {
            text-align: center;
            margin-bottom: 30px;
        }

        .alert {
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
        }

        .alert.success {
            background-color: #4CAF50;
            color: white;
        }

        .alert.error {
            background-color: #f44336;
            color: white;
        }
    </style>
</head>

<div class="container">
    <h2 class="text-center">Login Creation</h2>

    <%
        String message = "";
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String studentId = request.getParameter("studentid");
            String studentName = request.getParameter("studentname");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
            	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(
                    "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
                );

                String sql = "INSERT INTO users (studentid, studentname, password, role) VALUES (?, ?, ?, ?)";
               
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, studentId);
                stmt.setString(2, studentName);
                stmt.setString(3, password);
                stmt.setString(4, role);
                

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    message = "Student added successfully!";
                } else {
                    message = "Failed to add student.";
                }

            } catch (Exception e) {
                e.printStackTrace();
                message = "Error: " + e.getMessage();
            } finally {
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>

    <% if (message != null && !message.isEmpty()) { %>
        <div class="alert <%= message.contains("success") ? "success" : "error" %>">
            <%= message %>
        </div>
    <% } %>

    <form action="addStudent.jsp" method="POST">
        <div class="row">
            <div class="form-group col-md-6">
                <label for="studentId">ID</label>
                <input type="text" id="Id" name="id" class="form-control" required>
            </div>
            <div class="form-group col-md-6">
                <label for="studentName">Name</label>
                <input type="text" id="Name" name="name" class="form-control" required>
            </div>
        </div>

        <div class="form-group mt-3">
            <label for="Password">Password</label>
            <input type="password" id="Password" name="password" class="form-control" required>
        </div>

        <div class="form-group mt-3">
            <label for="role">Role</label>
            <input type="text" id="role" name="role" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success mt-4">Submit</button>
    </form>
</div>

<%@ include file="footer.jsp" %>
