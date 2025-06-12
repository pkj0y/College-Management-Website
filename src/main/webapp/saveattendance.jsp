<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    String studentId = request.getParameter("studentId");
    String studentName = request.getParameter("studentName");
    String subject = request.getParameter("subject");
    String attendance = request.getParameter("attendance");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(
            "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;" +
            "integratedSecurity=true;" +
            "TrustServerCertificate=true;" +
            "Encrypt=false;" +
            "portNumber=1433;" +
            "databaseName=collegemgdb"
        );

        String sql = "INSERT INTO StudentAttendance (StudentId, StudentName, Subject, Attendance) VALUES (?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, studentId);
        stmt.setString(2, studentName);
        stmt.setString(3, subject);
        stmt.setString(4, attendance);

        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            out.println("<h3 style='color: green;'>Attendance marked successfully!</h3>");
        } else {
            out.println("<h3 style='color: red;'>Error: Attendance not saved.</h3>");
        }
    } catch (Exception e) {
        out.println("<h3 style='color: red;'>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>
