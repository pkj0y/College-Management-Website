<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("index.jsp"); // redirect if no id param
        return;
    }

    int id = 0;
    try {
        id = Integer.parseInt(idParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("index.jsp"); // redirect if id invalid
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(
            "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
        );

        String sql = "DELETE FROM Courses WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);

        int rowsDeleted = stmt.executeUpdate();

        // Redirect to course list after deletion
        response.sendRedirect("manageCourses.jsp");
    } catch (Exception e) {
%>
    <h2>Error deleting course: <%= e.getMessage() %></h2>
    <a href="manageCourses.jsp">Back to Courses</a>
<%
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>
