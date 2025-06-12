<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String studentId = request.getParameter("studentId");

    if (studentId != null && !studentId.isEmpty()) {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
            );

            // Get total fees for this student
            PreparedStatement ps1 = con.prepareStatement("SELECT total_fees FROM student_fees WHERE student_id = ?");
            ps1.setString(1, studentId);
            ResultSet rs = ps1.executeQuery();

            double totalFees = 0;
            if (rs.next()) {
                totalFees = rs.getDouble("total_fees");
            }

            rs.close();
            ps1.close();

            // Simulate successful payment and update paid column
            PreparedStatement ps2 = con.prepareStatement("UPDATE student_fees SET paid = ? WHERE student_id = ?");
            ps2.setDouble(1, totalFees);
            ps2.setString(2, studentId);
            int updated = ps2.executeUpdate();
            ps2.close();
            con.close();

            if (updated > 0) {
%>
                <script>
                    alert("Payment successful! Paid amount updated.");
                    window.location.href = "adminFeesView.jsp"; // go back to main page
                </script>
<%
            } else {
%>
                <script>
                    alert("Payment failed: Student not found.");
                    window.location.href = "adminFeesView.jsp";
                </script>
<%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
            e.printStackTrace();
        }
    } else {
%>
        <script>
            alert("Invalid request: Student ID missing.");
            window.location.href = "adminFeesView.jsp";
        </script>
<%
    }
%>
