<%@ page import="java.sql.*" %>
<%@ page import="java.io.IOException" %>
<%
    String semester = request.getParameter("semester");
    String amount = request.getParameter("amount");
    String username = (String) session.getAttribute("username");

    if (username == null) {
        // Not logged in, redirect to login
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(
            "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;" +
            "TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
        );
        System.out.println("Connected.....");

        String sql = "UPDATE student_fees SET is_paid = 1 WHERE student_id = ? AND semester = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, semester);
        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated == 0) {
            out.println("<p style='color:red;'>No matching fee record found or update failed.</p>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (stmt != null) stmt.close();
        } catch (Exception ignored) {}
        try {
            if (conn != null) conn.close();
        } catch (Exception ignored) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%
    String paymentStatus = request.getParameter("payment");
    if ("success".equals(paymentStatus)) {
%>
<script>
    window.onload = function() {
        alert("✅ Payment was successful! Thank you.");
    }
</script>
<% } %>
<body>
<div class="container mt-5">
    <div class="alert alert-success">
        <h4 class="alert-heading">Payment Successful!</h4>
        <p>You've paid ₹<%= amount %> for <%= semester %>.</p>
        <a href="studentdashbord.jsp" class="btn btn-primary mt-3">Return to Dashboard</a>
    </div>
</div>
</body>
</html>
