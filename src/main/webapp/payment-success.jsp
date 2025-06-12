<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String studentId = request.getParameter("studentId");
    String semester = request.getParameter("semester");
    String amountStr = request.getParameter("amount");
    String subjectCode = request.getParameter("subjectCode"); // for arrear payments

    if (studentId == null || semester == null || amountStr == null) {
        response.sendRedirect("adminFeesView.jsp");
        return;
    }

    double amount = 0.0;
    try {
        amount = Double.parseDouble(amountStr);
    } catch (NumberFormatException e) {
        out.println("<h3>Invalid amount.</h3>");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null; // Use only one PreparedStatement variable
    boolean updateSuccess = false;
    String errorMsg = null;

    try {
        // Debug input values
        System.out.println("DEBUG: studentId = " + studentId);
        System.out.println("DEBUG: semester = " + semester);
        System.out.println("DEBUG: amount = " + amount);
        System.out.println("DEBUG: subjectCode = " + subjectCode);

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection(
            "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
        );

        if (subjectCode != null && !subjectCode.trim().isEmpty()) {
            // Arrear fee payment update
            String sql = "UPDATE arrear_fees " +
                         "SET amount_paid = amount_paid + ?, " +
                         "    payment_status = CASE WHEN amount_paid + ? >= fee_amount THEN 1 ELSE 0 END " +
                         "WHERE student_id = ? AND semester = ? AND subject_code = ?";

            stmt = conn.prepareStatement(sql);
            stmt.setDouble(1, amount);
            stmt.setDouble(2, amount);
            stmt.setString(3, studentId);
            stmt.setString(4, semester);  // semester as String (if it is string in DB)
            stmt.setString(5, subjectCode);

        } else {
            // Regular semester fee payment update
            String sql = "UPDATE student_fees " +
                         "SET paid = paid + ?, " +
                         "    is_paid = CASE WHEN paid + ? >= total_fees THEN 1 ELSE 0 END " +
                         "WHERE student_id = ? AND semester = ?";

            stmt = conn.prepareStatement(sql);
            stmt.setDouble(1, amount);
            stmt.setDouble(2, amount);
            stmt.setString(3, studentId);
            stmt.setString(4, semester);
        }

        int rows = stmt.executeUpdate();
        System.out.println("DEBUG: Rows updated = " + rows);
        updateSuccess = (rows > 0);

    } catch (Exception e) {
        e.printStackTrace();  // Log full stack trace to server console
        errorMsg = e.toString(); // Class + message
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function showAlert(msg) {
            alert(msg);
        }
    </script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <% if (updateSuccess) { %>
        <div class="alert alert-success">
            <h4 class="alert-heading">Payment Successful!</h4>
            <p>
                You've paid ₹<%= String.format("%.2f", amount) %> for semester <%= semester %>
                <%
                    if (subjectCode != null && !subjectCode.trim().isEmpty()) {
                %>
                    (Arrear Subject: <%= subjectCode %>)
                <%
                    }
                %>
                .
            </p>
            <a href="studentdashbord.jsp" class="btn btn-primary">Return to Dashboard</a>
        </div>
        <script>
            window.onload = function() {
                showAlert("✅ Payment was successful! Thank you.");
            }
        </script>
    <% } else { %>
        <div class="alert alert-danger">
            <h4 class="alert-heading">Payment Failed!</h4>
            <p>Error updating payment: <%= errorMsg != null ? errorMsg : "Unknown error" %></p>
            <a href="studentdashbord.jsp" class="btn btn-secondary">Return to Dashboard</a>
        </div>
    <% } %>
</div>
</body>
</html>
