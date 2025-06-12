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
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Fee Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            display: flex;
            flex-direction: column;
            background-image: url('ramyacollege.jpeg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .header {
            background-color: #003366;
            color: white;
            padding: 20px 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: fixed;
            top: 0;
            width: 100%;
            height: 90px;
            z-index: 999;
        }

        .header h1 {
            margin: 0;
            font-size: 22px;
            font-weight: 600;
        }

        .user-info {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 14px;
        }

        .wrapper {
            flex: 1;
            padding-top: 100px;
            padding-bottom: 50px;
        }

        .container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            max-width: 1000px;
            margin: auto;
            margin-bottom: 30px;
        }

        h3 {
            font-weight: 600;
            color: #333;
        }

        table thead {
            background-color: #0d6efd;
            color: white;
        }

        table th, table td {
            vertical-align: middle !important;
            font-size: 15px;
            padding: 14px;
            text-align: center;
        }

        .btn-primary {
            background-color: #0d6efd;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0b5ed7;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #bb2d3b;
        }

        .text-success, .text-danger {
            font-weight: 500;
        }

        .status-icon {
            margin-right: 5px;
        }

        .no-records {
            font-style: italic;
            color: #888;
        }

        footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 20px 0;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 18px;
            }
            .user-info {
                font-size: 12px;
                top: 16px;
            }
        }
    </style>
</head>
<body>

<!-- Header -->
<div class="header">
    <h1>GP Arts and Science College</h1>
    <div class="user-info">
        Welcome, <strong><%= studentName %></strong>
    </div>
</div>

<!-- Page Content -->
<div class="wrapper">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h3>Fee Details</h3>
            <a href="logout.jsp" class="btn btn-danger btn-sm">Logout</a>
        </div>

        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(
                    "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
                );

                // Semester Fees Query
                String sql = "SELECT semester, ISNULL(total_fees, 0) AS total_fees, ISNULL(paid, 0) AS paid " +
                             "FROM student_fees WHERE student_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, studentId);
                rs = stmt.executeQuery();

                boolean hasRecords = false;
        %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
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
                    int semester = rs.getInt("semester");
                    double total = rs.getDouble("total_fees");
                    double paid = rs.getDouble("paid");
                    double due = total - paid;
        %>
                    <tr>
                        <td><%= semester %></td>
                        <td>₹<%= String.format("%.2f", total) %></td>
                        <td>₹<%= String.format("%.2f", paid) %></td>
                        <td>
                            <% if (paid >= total) { %>
                                <span class="text-success"><i class="bi bi-check-circle-fill status-icon"></i>Paid</span>
                            <% } else { %>
                                <span class="text-danger"><i class="bi bi-exclamation-circle-fill status-icon"></i>Pending</span><br>
                                <a href="card-payment.jsp?studentId=<%= studentId %>&semester=<%= semester %>&amount=<%= String.format("%.2f", due) %>" 
                                   class="btn btn-sm btn-primary mt-2">
                                    Pay Now
                                </a>
                            <% } %>
                        </td>
                    </tr>
        <%
                }

                if (!hasRecords) {
        %>
                    <tr><td colspan="4" class="no-records">No fee records found.</td></tr>
        <%
                }

                rs.close();
                stmt.close();

                // Arrear Fees Query
                PreparedStatement arrearStmt = null;
                ResultSet arrearRs = null;
                
                
                String arrearSql = "SELECT semester, subject_code, fee_amount, ISNULL(amount_paid, 0) AS amount_paid, ISNULL(payment_status, 0) AS payment_status FROM arrear_fees WHERE student_id = ?";

                arrearStmt = conn.prepareStatement(arrearSql);
                arrearStmt.setString(1, studentId);
                arrearRs = arrearStmt.executeQuery();

                boolean hasArrear = false;
        %>
                </tbody>
            </table>
        </div>

        <h3 class="mt-5">Arrear Fees</h3>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr>
                        <th>Semester</th>
                        <th>Subject Code</th>
                        <th>Fee Amount (₹)</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
        <%
        while (arrearRs.next()) {
            hasArrear = true;
            int arrSemester = arrearRs.getInt("semester");
            String subjectCode = arrearRs.getString("subject_code");
            int feeAmount = arrearRs.getInt("fee_amount");
            int amountPaid = arrearRs.getInt("amount_paid");
            int paymentStatus = arrearRs.getInt("payment_status"); // 0 or 1

        %>
            <tr>
                <td><%= arrSemester %></td>
                <td><%= subjectCode %></td>
                <td>₹<%= feeAmount %></td>
                <td>
                    <% if (paymentStatus == 1 || amountPaid >= feeAmount) { %>
                        <span class="text-success">
                            <i class="bi bi-check-circle-fill status-icon"></i>Paid
                        </span>
                    <% } else { %>
                        <span class="text-danger">
                            <i class="bi bi-exclamation-circle-fill status-icon"></i>Pending
                        </span>
                        <br>
                        <a href="card-payment.jsp?studentId=<%= studentId %>&semester=<%= arrSemester %>&subjectCode=<%= subjectCode %>&amount=<%= (feeAmount - amountPaid) %>" 
                           class="btn btn-sm btn-primary mt-2">
                            Pay Now
                        </a>
                    <% } %>
                </td>
            </tr>
        <%
        }


                if (!hasArrear) {
        %>
                    <tr><td colspan="4" class="no-records">No arrear fees found.</td></tr>
        <%
                }

                arrearRs.close();
                arrearStmt.close();

            } catch (Exception e) {
        %>
                <tr><td colspan="4" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
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
</div>

<!-- Footer -->
<footer>
    &copy; 2025 GP Arts and Science College. All rights reserved.
</footer>

</body>
</html>
