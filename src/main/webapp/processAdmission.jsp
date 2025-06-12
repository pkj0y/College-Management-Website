<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("UTF-8");

    String fullName = request.getParameter("fullName");
    String dob = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String contact = request.getParameter("contact");
    String email = request.getParameter("email");
    String course = request.getParameter("course");
    String address = request.getParameter("address");


    Connection conn = null;


    boolean success = false;
    String errorMsg = "";

    try {
    	  // Load SQL Server JDBC driver
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

        // Connect to the SQL Server (update server, database, username, password)
          Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    	 conn=DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");
		
        String sql = "INSERT INTO admissions (full_Name, dob, gender, contact, email, course, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, fullName);
        stmt.setDate(2, java.sql.Date.valueOf(dob));
        stmt.setString(3, gender);
        stmt.setString(4, contact);
        stmt.setString(5, email);
        stmt.setString(6, course);
        stmt.setString(7, address);

        int rows = stmt.executeUpdate();
        conn.close();

        if (rows > 0) {
            success = true;
        } else {
            errorMsg = "Failed to insert data.";
        }
    } catch (Exception e) {
        errorMsg = "Database error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admission Status</title>
</head>
<body>
    <% if (success) { %>
        <h2>Admission form submitted successfully!</h2>
        <a href="admission.jsp">Back to Form</a>
    <% } else { %>
        <h2>Error Submitting Form</h2>
        <p style="color:red;"><%= errorMsg %></p>
        <a href="admission.jsp">Try Again</a>
    <% } %>
</body>
</html>
