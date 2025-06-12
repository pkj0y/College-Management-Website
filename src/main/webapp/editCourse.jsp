<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    int courseId = 0;
    try {
        courseId = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        out.println("Invalid Course ID.");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String courseName = "", courseDescription = "";
    int courseCredits = 0;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(
            "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
        );

        String sql = "SELECT courseName, courseDescription, courseCredits FROM Courses WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, courseId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            courseName = rs.getString("courseName");
            courseDescription = rs.getString("courseDescription");
            courseCredits = rs.getInt("courseCredits");
        } else {
            out.println("Course not found.");
            return;
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        return;
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Course</title>
    <style>
        body {
            background-color: #f4f6f8;
            font-family: Arial, sans-serif;
        }

        .container {
            margin: 50px auto;
            max-width: 800px;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #212529;
            font-weight: 700;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #495057;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px 15px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            margin-bottom: 20px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus {
            border-color: #007bff;
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        button {
            display: block;
            width: 100%;
            background-color: #28a745;
            color: white;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }

        .back-link:hover {
            text-decoration: underline;
            color: #0056b3;
        }
    </style>
</head>
<body>


<div class="container">
    <%
        String success = request.getParameter("success");
        if ("true".equals(success)) {
    %>
    <script>
        alert("✅ Course updated successfully!");
    </script>
    <%
        }
    %>

    <!-- Rest of your form HTML here -->

    <h2>Edit Course</h2>
    <form action="updateCourse.jsp" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= courseId %>">

        <label for="courseName">Course Name</label>
        <input type="text" id="courseName" name="courseName" value="<%= courseName %>" required>

        <label for="courseDescription">Description</label>
        <textarea id="courseDescription" name="courseDescription" required><%= courseDescription %></textarea>

        <label for="courseCredits">Credits</label>
        <input type="number" id="courseCredits" name="courseCredits" min="0" value="<%= courseCredits %>" required>

        <button type="submit">Update Course</button>
    </form>

</div>
</body>
</html>
