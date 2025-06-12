<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enter Grades</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f0f2f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .form-container {
            max-width: 800px;
            margin-top:2%;
            margin-left:30%;
            padding: 10px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .form-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .form-header h2 {
            font-size: 2rem;
            font-weight: 700;
            color: #333333;
            margin-bottom: 10px;
        }

        .form-header::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background-color: #0d6efd;
            margin: 10px auto 0;
            border-radius: 2px;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
        }

        .alert {
            margin-top: 20px;
            font-size: 1rem;
        }

        .form-label {
            font-weight: 600;
        }
    </style>
</head>
<body>

<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String studentId = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String semester = request.getParameter("semester");
        String subject = request.getParameter("subject");
        String grade = request.getParameter("grade");

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

            String sql = "INSERT INTO Grades (studentId, studentName, semester, subject, grade) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, studentId);
            stmt.setString(2, studentName);
            stmt.setString(3, semester);
            stmt.setString(4, subject);
            stmt.setString(5, grade);

            int result = stmt.executeUpdate();
            if (result > 0) {
                message = "<div class='alert alert-success text-center'>✅ Grade submitted successfully!</div>";
            } else {
                message = "<div class='alert alert-danger text-center'>❌ Failed to submit grade.</div>";
            }

        } catch (Exception e) {
            message = "<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>";
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
%>

<div class="form-container">
    <div class="form-header">
        <h2>Enter Student Grades</h2>
    </div>

    <form action="grades.jsp" method="post">
        <div class="mb-3">
            <label for="studentId" class="form-label">Student ID</label>
            <input type="text" class="form-control" id="studentId" name="studentId" required>
        </div>

        <div class="mb-3">
            <label for="studentName" class="form-label">Student Name</label>
            <input type="text" class="form-control" id="studentName" name="studentName" required>
        </div>

        <div class="mb-3">
            <label for="semester" class="form-label">Semester</label>
            <input type="text" class="form-control" id="semester" name="semester" required placeholder="e.g., 1, 2, 3...">
        </div>

        <div class="mb-3">
            <label for="subject" class="form-label">Subject</label>
            <select class="form-select" id="subject" name="subject" required>
                <option value="" disabled selected>Select Subject</option>
                <option value="Mathematics">Mathematics</option>
                <option value="English">English</option>
                <option value="Computer Science">Computer Science</option>
                <option value="Physics">Physics</option>
                <option value="Chemistry">Chemistry</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="grade" class="form-label">Grade</label>
            <input type="text" class="form-control" id="grade" name="grade" required>
        </div>

        <div class="d-grid">
            <input type="submit" class="btn btn-primary" value="Submit Grade">
        </div>
    </form>

    <%= message %>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
