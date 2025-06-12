<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("noticeTitle");
    String date = request.getParameter("noticeDate");
    String content = request.getParameter("noticeContent");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");

        String sql = "INSERT INTO notices (title, Notice_date, content) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, title);
        stmt.setString(2, date);
        stmt.setString(3, content);

        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            response.sendRedirect("manageNotices.jsp");
        } else {
%>
            <h2>Failed to add notice.</h2>
            <a href="addNotice.jsp">Try Again</a>
<%
        }
    } catch (Exception e) {
%>
    <h2>Error: <%= e.getMessage() %></h2>
    <a href="addNotice.jsp">Back to Add Notice</a>
<%
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
