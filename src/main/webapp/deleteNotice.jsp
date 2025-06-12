<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("manageNotices.jsp");
        return;
    }

    int id = Integer.parseInt(idParam);
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");

        String sql = "DELETE FROM notices WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);

        int rowsDeleted = stmt.executeUpdate();

        // Redirect back to list no matter what
        response.sendRedirect("manageNotices.jsp");
    } catch (Exception e) {
%>
    <h2>Error deleting notice: <%= e.getMessage() %></h2>
    <a href="manageNotices.jsp">Back to Notices</a>
<%
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
