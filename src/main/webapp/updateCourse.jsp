<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String action = request.getParameter("action");
    if ("update".equals(action)) {
        String idParam = request.getParameter("id");
        String courseName = request.getParameter("courseName");
        String courseDescription = request.getParameter("courseDescription");
        String creditsParam = request.getParameter("courseCredits");

        if (idParam != null && courseName != null && courseDescription != null && creditsParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                int credits = Integer.parseInt(creditsParam);

                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
                );

                String sql = "UPDATE Courses SET courseName = ?, courseDescription = ?, courseCredits = ? WHERE id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, courseName);
                stmt.setString(2, courseDescription);
                stmt.setInt(3, credits);
                stmt.setInt(4, id);

                int rowsUpdated = stmt.executeUpdate();

                stmt.close();
                conn.close();

                if (rowsUpdated > 0) {
                    // Redirect back to edit page with success message
                    response.sendRedirect("editCourse.jsp?id=" + id + "&success=true");
                } else {
                    out.println("<p style='color:red;'>Update failed: Course not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p style='color:red;'>All fields are required.</p>");
        }
    } else {
        out.println("<p style='color:red;'>Invalid action.</p>");
    }
%>
