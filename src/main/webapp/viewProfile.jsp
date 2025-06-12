<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Students with Grades</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f8;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 50px;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .page-title {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            color: #343a40;
            margin-bottom: 30px;
        }

        .page-title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background-color: #007bff;
            margin: 10px auto 0;
            border-radius: 2px;
        }

        table thead {
            background-color: #007bff;
            color: white;
        }

        table tbody tr:hover {
            background-color: #f1f3f5;
        }

        .grade-list {
            font-size: 0.95rem;
            line-height: 1.5;
        }

        .no-records {
            text-align: center;
            font-style: italic;
            color: #888;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="page-title">All Students with Grades</div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th>Grades</th>
                </tr>
            </thead>
            <tbody>
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

                        String sql = "SELECT u.studentid, u.studentname, u.role, g.subject, g.grade " +
                                     "FROM users u " +
                                     "LEFT JOIN grades g ON u.studentid = g.studentid " +
                                     "ORDER BY u.studentid, g.subject";

                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        String lastStudentId = "";
                        boolean hasData = false;

                        java.util.Map<String, java.util.List<String>> studentGrades = new java.util.LinkedHashMap<>();

                        // Group grades by studentId
                        while (rs.next()) {
                            hasData = true;
                            String studentId = rs.getString("studentid");
                            String name = rs.getString("studentname");
                            String role = rs.getString("role");
                            String subject = rs.getString("subject");
                            String grade = rs.getString("grade");

                            String key = studentId + "|" + name + "|" + role;
                            if (!studentGrades.containsKey(key)) {
                                studentGrades.put(key, new java.util.ArrayList<>());
                            }

                            if (subject != null && grade != null) {
                                studentGrades.get(key).add(subject + ": " + grade);
                            }
                        }

                        // Display grouped data
                        for (String key : studentGrades.keySet()) {
                            String[] parts = key.split("\\|");
                            String studentId = parts[0];
                            String name = parts[1];
                            String role = parts[2];
                            java.util.List<String> grades = studentGrades.get(key);
                %>
                            <tr>
                                <td><%= studentId %></td>
                                <td><%= name %></td>
                                <td><%= role %></td>
                                <td>
                                    <% if (grades.isEmpty()) { %>
                                        <span class="text-muted">No grades yet</span>
                                    <% } else { %>
                                        <div class="grade-list">
                                            <ul class="mb-0 ps-3">
                                            <% for (String g : grades) { %>
                                                <li><%= g %></li>
                                            <% } %>
                                            </ul>
                                        </div>
                                    <% } %>
                                </td>
                            </tr>
                <%
                        }

                        if (!hasData) {
                %>
                            <tr>
                                <td colspan="4" class="no-records">No student records found.</td>
                            </tr>
                <%
                        }

                    } catch (Exception e) {
                %>
                        <tr>
                            <td colspan="4" class="text-danger text-center">Error: <%= e.getMessage() %></td>
                        </tr>
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

<%@ include file="footer.jsp" %>
</body>
</html>
