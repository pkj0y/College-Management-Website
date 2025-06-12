<%@ page import="java.sql.*" %>

<%@ include file="header.jsp" %>

<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String studentName = request.getParameter("student_name");
        String studentId = request.getParameter("student_id");
        String semesterStr = request.getParameter("semester");
        String feeType = request.getParameter("fee_type");
        String feeAmountStr = request.getParameter("fee_amount");
        String subjectCode = request.getParameter("subject_code");

        try {
            int feeAmount = Integer.parseInt(feeAmountStr);
            int semester = Integer.parseInt(semesterStr.replace("Semester ", ""));

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb"
            );

            String sql;
            PreparedStatement stmt;

            if ("semester".equals(feeType)) {
                sql = "INSERT INTO student_fees (student_name, student_id, semester, total_fees, paid) VALUES (?, ?, ?, ?, ?)";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, studentName);
                stmt.setString(2, studentId);
                stmt.setInt(3, semester);
                stmt.setInt(4, feeAmount);
                stmt.setInt(5, 0);
            } else {
                sql = "INSERT INTO arrear_fees (student_name, student_id, semester, subject_code, fee_amount) VALUES (?, ?, ?, ?, ?)";
                stmt = con.prepareStatement(sql);
                stmt.setString(1, studentName);
                stmt.setString(2, studentId);
                stmt.setInt(3, semester);
                stmt.setString(4, subjectCode);
                stmt.setInt(5, feeAmount);
            }

            int rows = stmt.executeUpdate();
            message = (rows > 0) ? "Fee details inserted successfully." : "Failed to insert fee details.";

            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            message = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin - Insert Fees</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 40%;
            margin: 0;
            font-family: Arial, sans-serif;
            background-image: url('ramyacollege.jpeg'); /* Replace with your actual image */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
        }

        .container {
            margin-top: 40px;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 850px;
        }

        .alert {
            padding: 15px;
            margin: 10px 0 20px 0;
            border-radius: 5px;
            font-weight: 600;
        }

        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        h3 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 30px;
            color: #003366;
        }
    </style>
</head>

<body>
<div class="container">
    <h3>Insert Fee Details</h3>

    <% if (!message.isEmpty()) { %>
        <div class="alert alert-info"><%= message %></div>
    <% } %>

    <form method="post" action="adminInsertFees.jsp">
        <div class="mb-3">
            <label>Student Name</label>
            <input type="text" name="student_name" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Student ID</label>
            <input type="text" name="student_id" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Semester</label>
            <select name="semester" class="form-select" required>
                <% for (int i = 1; i <= 6; i++) { %>
                    <option value="Semester <%= i %>">Semester <%= i %></option>
                <% } %>
            </select>
        </div>

        <div class="mb-3">
            <label>Fee Type</label>
            <select name="fee_type" class="form-select" required onchange="toggleSubjectCode(this.value)">
                <option value="semester">Semester Fee</option>
                <option value="arrear">Arrear Fee</option>
            </select>
        </div>

        <div class="mb-3" id="subjectCodeDiv" style="display: none;">
            <label>Subject Code (for arrear only)</label>
            <input type="text" name="subject_code" class="form-control">
        </div>

        <div class="mb-3">
            <label>Fee Amount (INR)</label>
            <input type="number" name="fee_amount" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-success">Insert Fee</button>
    </form>
</div>

<script>
    function toggleSubjectCode(value) {
        document.getElementById('subjectCodeDiv').style.display = value === 'arrear' ? 'block' : 'none';
    }
</script>

<%@ include file="footer.jsp" %>
</body>
</html>
