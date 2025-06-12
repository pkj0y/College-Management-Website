<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>

<%
    if (session.getAttribute("studentName") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
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
    <meta charset="UTF-8" />
    <title>Student Fee Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background: url('ramyacollege.jpeg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background-color: #003366;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 20px 15px;
            font-weight: 600;
            font-size: 1.5rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }

        .user-info {
            position: absolute;
            right: 20px;
            font-size: 14px;
            font-weight: 400;
        }

        .container {
            max-width: 1000px;
            margin: 40px auto 140px; /* leave space for footer */
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #003366;
            font-weight: 600;
            font-size: 26px;
        }

        .logout-btn {
            font-size: 14px;
            font-weight: 500;
            border: none;
            border-radius: 6px;
            background-color: #dc3545;
            color: white;
            padding: 6px 14px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .logout-btn:hover {
            background-color: #bb2d3b;
            text-decoration: none;
            box-shadow: 0 0 6px rgba(220, 53, 69, 0.5);
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            text-align: center;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        thead th {
            background-color: #002855;
            color: #20c997;  /* Teal header text */
            font-size: 16px;
            font-weight: 700;
            padding: 16px 12px;
            letter-spacing: 0.05em;
            user-select: none;
            border-bottom: 3px solid #20c997;
        }

        tbody td {
            padding: 14px 12px;
            font-size: 15px;
            color: #333;
            border-bottom: 1px solid #e9ecef;
        }

        tbody tr:hover {
            background-color: #f1f3f5;
        }

        .status-paid {
            color: #198754;
            font-weight: 600;
        }

        .status-pending {
            color: #dc3545;
            font-weight: 600;
        }

        .no-records {
            text-align: center;
            padding: 20px;
            font-style: italic;
            color: #777;
        }

        .text-danger {
            text-align: center;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            header {
                font-size: 1.2rem;
                padding: 15px 10px;
            }
            .user-info {
                font-size: 12px;
                right: 10px;
            }
            .container {
                padding: 20px;
                margin: 30px auto 140px;
            }
            h2 {
                font-size: 22px;
            }
        }

        footer {
            background-color: #343a40;
            color: white;
            padding: 10px;
            text-align: center;
            height: 60px;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            position: fixed;
            bottom: 0;
            left: 0;
            font-weight: 500;
        }
    </style>
</head>

<body>

<header>
    GP Arts and Science College
    <div class="user-info">Welcome, <strong><%= studentName %></strong></div>
</header>

<div class="container">
    <div class="mb-3 text-end">
        <a href="logout.jsp" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </div>

    <h2>Fee Details for <%= studentName %> (ID: <%= studentId %>)</h2>

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

            String sql = "SELECT semester, ISNULL(total_fees, 0) AS total_fees, ISNULL(paid, 0) AS paid " +
                         "FROM student_fees WHERE student_id = ? AND student_name = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, studentId);
            stmt.setString(2, studentName);
            rs = stmt.executeQuery();

            boolean hasRecords = false;
    %>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Semester</th>
                <th>Total Fees</th>
                <th>Paid</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
    <%
            while (rs.next()) {
                hasRecords = true;
                double total = rs.getDouble("total_fees");
                double paid = rs.getDouble("paid");
    %>
            <tr>
                <td><%= rs.getInt("semester") %></td>
                <td>₹<%= String.format("%.2f", total) %></td>
                <td>₹<%= String.format("%.2f", paid) %></td>
                <td>
                    <%= (paid >= total)
                        ? "<span class='status-paid'>Paid</span>"
                        : "<span class='status-pending'>Pending</span>" %>
                </td>
            </tr>
    <%
            }

            if (!hasRecords) {
    %>
            <tr>
                <td colspan="4" class="no-records">No fee records found.</td>
            </tr>
    <%
            }

        } catch (Exception e) {
    %>
            <tr><td colspan="4" class="text-danger">Error: <%= e.getMessage() %></td></tr>
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

<footer>
    &copy; 2025 GP Arts and Science College. All rights reserved.
</footer>

</body>
</html>
