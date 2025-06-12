<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String idParam = request.getParameter("id");
    String title = request.getParameter("noticeTitle");
    String date = request.getParameter("noticeDate");
    String content = request.getParameter("noticeContent");

    if (idParam == null || title == null || date == null || content == null) {
        response.sendRedirect("manageNotices.jsp");
        return;
    }

    int id = Integer.parseInt(idParam);

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");

        String sql = "UPDATE notices SET title = ?, Notice_date = ?, content = ? WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, title);
        stmt.setString(2, date);
        stmt.setString(3, content);
        stmt.setInt(4, id);

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            response.sendRedirect("manageNotices.jsp");
        } else {
%>
            <h2>Failed to update notice.</h2>
            <a href="editNotice.jsp?id=<%= id %>">Try Again</a>
<%
        }
    } catch (Exception e) {
%>
    <h2>Error: <%= e.getMessage() %></h2>
    <a href="editNotice.jsp?id=<%= id %>">Back to Edit Notice</a>
<%
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
