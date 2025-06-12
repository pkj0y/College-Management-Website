<%@ page import="java.sql.*" %>

<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Admissions Data</title>
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
    <div class="page-title">Submitted Admission Forms</div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Date of Birth</th>
                    <th>Gender</th>
                    <th>Contact</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Address</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    String errorMsg = "";

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

                        String sql = "SELECT * FROM admissions";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        boolean hasRecords = false;
                        while (rs.next()) {
                            hasRecords = true;
                %>
                            <tr>
                                <td><%= rs.getInt("id") %></td>
                                <td><%= rs.getString("full_Name") %></td>
                                <td><%= rs.getDate("dob") %></td>
                                <td><%= rs.getString("gender") %></td>
                                <td><%= rs.getString("contact") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= rs.getString("course") %></td>
                                <td><%= rs.getString("address") %></td>
                            </tr>
                <%
                        }

                        if (!hasRecords) {
                %>
                            <tr>
                                <td colspan="8" class="no-records">No admission records found.</td>
                            </tr>
                <%
                        }

                    } catch (Exception e) {
                        errorMsg = "Error: " + e.getMessage();
                %>
                        <tr>
                            <td colspan="8" class="text-danger text-center"><%= errorMsg %></td>
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

    <div class="text-center mt-4">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Admin Dashboard</a>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
