<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.Arrays" %>
<html>
<head>
    <title>Save Faculty Timetable</title>
</head>
<body>
    <h2>Save Faculty Timetable</h2>

    <%
        // Database connection setup
        Connection conn=null;
         PreparedStatement ps = null;

        String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
        String[] timeSlots = {"9:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "1:00 - 2:00", "2:00 - 3:00"};

        // Check if the form is submitted
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            try {
                // Establish connection to the database
           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    	 conn=DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");
		
                // Loop through each day and time slot to get the values from the form
                for (String day : days) {
                    for (int j = 0; j < timeSlots.length; j++) {
                        String fieldName = "cell_" + Arrays.asList(days).indexOf(day) + "_" + j;
                        String subject = request.getParameter(fieldName);

                        // If subject is entered, insert it into the database
                        if (subject != null && !subject.isEmpty()) {
                            String query = "INSERT INTO FacultyTimetable (day, time_slot, subject) VALUES (?, ?, ?)";
                            ps = conn.prepareStatement(query);
                            ps.setString(1, day);
                            ps.setString(2, timeSlots[j]);
                            ps.setString(3, subject);

                            ps.executeUpdate();
                        }
                    }
                }

               
                response.sendRedirect("edit_timetable.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<h3>Error saving timetable: " + e.getMessage() + "</h3>");
            } finally {
                // Close resources
                try {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

   
</body>
</html>
