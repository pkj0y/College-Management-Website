<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String studentId = request.getParameter("student_id");
    String selectedSemester = request.getParameter("semester");

    int regularFee = 0;
    int arrearFee = 0;
    boolean hasRegularFee = false;
    boolean hasArrearFee = false;

    Connection conn = null;
    PreparedStatement ps1 = null, ps2 = null;
    ResultSet rs1 = null, rs2 = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(
            "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;databaseName=collegemgdb;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false"
        );

        if (studentId != null && selectedSemester != null) {
            // Regular fee
            String sql1 = "SELECT fee_amount FROM student_fees WHERE student_id = ? AND semester = ?";
            ps1 = conn.prepareStatement(sql1);
            ps1.setString(1, studentId);
            ps1.setString(2, selectedSemester);
            rs1 = ps1.executeQuery();
            if (rs1.next()) {
                regularFee = rs1.getInt("fee_amount");
                hasRegularFee = true;
            }

            // Arrear fee
            String sql2 = "SELECT SUM(fee_amount) AS total_arrear FROM arrear_fees WHERE student_id = ? AND semester = ?";
            ps2 = conn.prepareStatement(sql2);
            ps2.setString(1, studentId);
            ps2.setString(2, selectedSemester);
            rs2 = ps2.executeQuery();
            if (rs2.next()) {
                arrearFee = rs2.getInt("total_arrear");
                hasArrearFee = arrearFee > 0;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs1 != null) rs1.close();
        if (rs2 != null) rs2.close();
        if (ps1 != null) ps1.close();
        if (ps2 != null) ps2.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Exam Fee Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3 class="text-center">Pay Exam Fees</h3>

    <form method="get" action="payFees.jsp">
        <div class="mb-3">
            <label for="student_id" class="form-label">Enter Student ID</label>
            <input type="text" name="student_id" class="form-control" required value="<%= studentId != null ? studentId : "" %>">
        </div>

        <div class="mb-3">
            <label for="semester" class="form-label">Select Semester</label>
            <select name="semester" class="form-select" required>
                <option value="">-- Choose Semester --</option>
                <% for (int i = 1; i <= 6; i++) {
                    String sem = "Semester " + i;
                %>
                    <option value="<%= sem %>" <%= (sem.equals(selectedSemester) ? "selected" : "") %>><%= sem %></option>
                <% } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">View Fees</button>
    </form>

    <% if (studentId != null && selectedSemester != null) { %>
        <hr/>
        <h5>Results for Student ID: <%= studentId %> - <%= selectedSemester %></h5>

     <% if (hasRegularFee) { %>
    <div class="alert alert-info">Regular Exam Fee: ₹<strong><%= regularFee %></strong></div>
<% } %>

<% if (!hasRegularFee) { %>
    <div class="alert alert-warning">⚠️ No regular fee found for this semester.</div>
<% } %>
     
        <% if (hasRegularFee || hasArrearFee) {
            int total = regularFee + arrearFee;
        %>
            <form method="post" action="processPayment.jsp">
                <input type="hidden" name="student_id" value="<%= studentId %>">
                <input type="hidden" name="semester" value="<%= selectedSemester %>">
                <input type="hidden" name="amount" value="<%= total %>">
                <button type="submit" class="btn btn-success">Pay Total ₹<%= total %></button>
            </form>
        <% } %>
    <% } %>
</div>
</body>
</html>
