<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<head>
  <style>
    body {
        background-color: #f4f6f8;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    .container {
        margin: 30px auto;
        background-color: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        max-width: 690px;
        width: 100%;
    }

    .text-center {
        text-align: center;
        margin-bottom: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }

    .form-control {
        width: 100%;
        padding: 10px 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .btn-success {
        background-color: #28a745;
        color: white;
        padding: 12px;
        font-size: 16px;
        border: none;
        width: 100%;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .btn-success:hover {
        background-color: #218838;
    }

    .alert {
        padding: 15px;
        margin: 15px 0;
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

    @media (max-width: 768px) {
        .container {
            padding: 20px;
        }

        .btn-success {
            font-size: 14px;
        }

        .form-control {
            font-size: 14px;
        }
    }
</style>

</head>

<div class="container">
    <h2 class="text-center">Add New Faculty</h2>

    <%
        String message = "";
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String facultyId = request.getParameter("facultyId");
            String facultyName = request.getParameter("facultyName");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(
                    "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;" +
                    "databaseName=collegemgdb;" +
                    "integratedSecurity=true;" +
                    "TrustServerCertificate=true;" +
                    "Encrypt=false;" +
                    "portNumber=1433;"
                );

                // Password hashing can be added here later (e.g., using BCrypt)

                String sql = "INSERT INTO faculty (facultyId, facultyName, password, role) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, facultyId);
                stmt.setString(2, facultyName);
                stmt.setString(3, password);
                stmt.setString(4, role);

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    message = "Faculty added successfully!";
                } else {
                    message = "Failed to add faculty.";
                }

            } catch (Exception e) {
                e.printStackTrace();
                message = "Error: " + e.getMessage();
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

    <% if (message != null && !message.isEmpty()) { %>
        <div class="alert <%= message.contains("successfully") ? "success" : "error" %>">
            <%= message %>
        </div>
    <% } %>

    <!-- Faculty Registration Form -->
    <form action="addfaculty.jsp" method="POST">
        <div class="form-group">
            <label for="facultyId">Faculty ID</label>
            <input type="text" id="facultyId" name="facultyId" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="facultyName">Faculty Name</label>
            <input type="text" id="facultyName" name="facultyName" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="role">Role</label>
            <input type="text" id="role" name="role" class="form-control" required>
        </div>
        <button type="submit" class="btn btn-success">Add Faculty</button>
    </form>
</div>

<%@ include file="footer.jsp" %>
