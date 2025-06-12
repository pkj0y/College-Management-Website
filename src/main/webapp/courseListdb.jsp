<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String courseName = request.getParameter("courseName");
    String courseDescription = request.getParameter("courseDescription");
    String credits = request.getParameter("courseCredits");

    if (courseName != null && courseDescription != null && credits != null && !credits.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");

            String sql = "INSERT INTO Courses (courseName, courseDescription, courseCredits) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, courseName);
            stmt.setString(2, courseDescription);
            stmt.setInt(3, Integer.parseInt(credits));

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Redirect to addCourse.jsp with success message
                response.sendRedirect("addCourse.jsp?success=true");
            } else {
%>
                <p style="color:red;"> Failed to insert course.</p>
<%
            }
        } catch (Exception e) {
%>
            <p style="color:red;">Error: <%= e.getMessage() %></p>
<%
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    } else {
%>
    <p style="color:red;">Please fill in all fields.</p>
<%
    }
%>
