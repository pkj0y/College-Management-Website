<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Faculty Members</title>
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

        .no-records {
            text-align: center;
            font-style: italic;
            color: #888;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="page-title">All Faculty Members</div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Faculty ID</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th>Password</th>
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
                            "databaseName=collegemgdb;" +
                            "integratedSecurity=true;" +
                            "TrustServerCertificate=true;" +
                            "Encrypt=false;" +
                            "portNumber=1433;"
                        );

                        String sql = "SELECT facultyId, facultyName, role, password FROM faculty";
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();

                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                %>
                            <tr>
                                <td><%= rs.getString("facultyId") %></td>
                                <td><%= rs.getString("facultyName") %></td>
                                <td><%= rs.getString("role") %></td>
                                <td><%= rs.getString("password") %></td>
                            </tr>
                <%
                        }

                        if (!hasData) {
                %>
                            <tr>
                                <td colspan="4" class="no-records">No faculty records found.</td>
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
