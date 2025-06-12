<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    String studentId = (String) session.getAttribute("studentId");
    String studentName = (String) session.getAttribute("studentName");

    if (studentId == null || studentName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Attendance Records</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: url('ramyacollege.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        header {
            background-color: rgba(0, 51, 102, 0.9);
            color: white;
            padding: 20px;
            text-align: center;
            font-weight: 600;
            font-size: 1.5rem;
        }

        .user-info {
            font-size: 0.9rem;
            margin-top: 5px;
            color: #ccc;
        }

        main {
            flex: 1;
            padding: 40px 20px;
        }

        .overlay {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            max-width: 1000px;
            margin: auto;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .table-heading {
            font-size: 2rem;
            font-weight: 700;
            color: #212529;
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        .table-heading::after {
            content: '';
            display: block;
            width: 70px;
            height: 4px;
            background-color: #0d6efd;
            margin: 10px auto 0;
            border-radius: 2px;
        }

        table thead {
            background-color: #0d6efd;
            color: white;
        }

        table th, table td {
            text-align: center;
            vertical-align: middle;
            padding: 12px;
        }

        table tbody tr:hover {
            background-color: #f1f3f5;
        }

        .no-records {
            font-style: italic;
            color: #888;
        }

        footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 20px 10px;
            font-size: 0.95rem;
        }

        .btn-logout {
            float: right;
        }
    </style>
</head>
<body>

<header>
    GP Arts and Science College
    <div class="user-info">
        Welcome, <%= studentName %>
        <a href="logout.jsp" class="btn btn-danger btn-sm btn-logout">Logout</a>
    </div>
</header>

<main>
    <div class="overlay">
        <h2 class="table-heading">Attendance Records</h2>

        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

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

                String sql = "SELECT Subject, Attendance FROM StudentAttendance WHERE StudentId = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, studentId);
                rs = stmt.executeQuery();

                boolean hasData = false;
        %>

        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Attendance</th>
                    </tr>
                </thead>
                <tbody>
        <%
                while (rs.next()) {
                    hasData = true;
        %>
                    <tr>
                        <td><%= rs.getString("Subject") %></td>
                        <td><%= rs.getString("Attendance") %></td>
                    </tr>
        <%
                }

                if (!hasData) {
        %>
                    <tr>
                        <td colspan="2" class="no-records text-center">No attendance records found.</td>
                    </tr>
        <%
                }

            } catch (Exception e) {
        %>
                <tr><td colspan="2" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            }
        %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<footer>
    &copy; 2025 GP Arts and Science College. All rights reserved.
</footer>

</body>
</html>
