<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String facultyId = request.getParameter("facultyId");
    String facultyName = request.getParameter("username");
    String password = request.getParameter("password");

    String message = "";
    boolean isValidUser = false;

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
    	  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          conn = DriverManager.getConnection(
              "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
          );

        String sql = "SELECT * FROM faculty WHERE facultyId = ? AND facultyName = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, facultyId);
        stmt.setString(2, facultyName);
        stmt.setString(3, password);

        rs = stmt.executeQuery();

        if (rs.next()) {
            isValidUser = true;
            session.setAttribute("facultyId", facultyId);
            session.setAttribute("facultyName", facultyName);
            session.setAttribute("role", rs.getString("role"));
            response.sendRedirect("facultyDashboard.jsp");
        } else {
            message = "Invalid Faculty ID, Name, or Password.";
        }

    } catch (ClassNotFoundException e) {
        message = "JDBC Driver not found: " + e.getMessage();
    } catch (SQLException e) {
        message = "Database error: " + e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }
%>

<% if (!isValidUser) { %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Failed</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f8d7da;
            color: #721c24;
            padding: 50px;
            text-align: center;
        }
        .message-box {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 20px;
            border-radius: 8px;
            display: inline-block;
        }
        a {
            display: block;
            margin-top: 20px;
            color: #0056b3;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <h3>Login Failed</h3>
        <p><%= message %></p>
        <a href="facultyLogin.jsp">← Back to Faculty Login</a>
    </div>
</body>
</html>
<% } %>
