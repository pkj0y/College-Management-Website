<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String adminId = request.getParameter("adminId");
    String adminName = request.getParameter("username");
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

        String sql = "SELECT * FROM admin WHERE adminId = ? AND adminName = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, adminId);
        stmt.setString(2, adminName);
        stmt.setString(3, password);

        rs = stmt.executeQuery();

        if (rs.next()) {
            isValidUser = true;
            session.setAttribute("adminId", adminId);
            session.setAttribute("adminName", adminName);
            session.setAttribute("role", rs.getString("role"));

            response.sendRedirect("adminDashboard.jsp"); // Update with your landing page
        } else {
            message = "Invalid  ID, Name, or Password.";
        }

    } catch (Exception e) {
        e.printStackTrace();
        message = "Error: " + e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<% if (!isValidUser) { %>
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
            <a href="login.jsp">← Back to Login</a>
        </div>
    </body>
    </html>
<% } %>
