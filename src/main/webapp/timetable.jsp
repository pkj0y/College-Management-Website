<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

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
    <meta charset="UTF-8" />
    <title>Faculty Timetable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            background: url('ramyacollege.jpeg') no-repeat center center fixed;
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        header {
            background-color: #003366;
            color: white;
            padding: 20px;
            text-align: center;
            font-weight: 600;
            font-size: 1.5rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }
        main {
            flex: 1;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }
        .form-container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            max-width: 900px;
            width: 100%;
        }
        .form-container h2 {
            color: #003366;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            font-size: 1.8rem;
            letter-spacing: 0.05em;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            text-align: center;
            font-size: 15px;
            border-bottom: 1px solid #ddd;
        }
        thead th {
            background-color: #003366;
            color: #fff;
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tbody tr:hover {
            background-color: #e3e9f3;
            transition: background-color 0.3s ease;
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 20px 10px;
            text-align: center;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>
<header>
    GP Arts and Science College
    <div class="user-info" style="font-weight: 400; font-size: 1rem; margin-top: 5px;">
        Welcome, <%= studentName %>
    </div>
</header>

<main>
    <div class="form-container">
        <h2>Faculty Timetable for <%= studentName %> (ID: <%= studentId %>)</h2>
        <table>
            <thead>
                <tr>
                    <th>Day</th>
                    <th>9:00 - 10:00</th>
                    <th>10:00 - 11:00</th>
                    <th>11:00 - 12:00</th>
                    <th>1:00 - 2:00</th>
                    <th>2:00 - 3:00</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
                    String[] timeSlots = {"9:00 - 10:00", "10:00 - 11:00", "11:00 - 12:00", "1:00 - 2:00", "2:00 - 3:00"};

                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        conn = DriverManager.getConnection(
                            "jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;" +
                            "integratedSecurity=true;" +
                            "TrustServerCertificate=true;" +
                            "Encrypt=false;" +
                            "portNumber=1433;" +
                            "databaseName=collegemgdb;"
                        );

                        String query = "SELECT subject FROM FacultyTimetable WHERE day = ? AND time_slot = ?";
                        ps = conn.prepareStatement(query);

                        for (String day : days) {
                            out.println("<tr>");
                            out.println("<td>" + day + "</td>");
                            for (String slot : timeSlots) {
                                ps.setString(1, day);
                                ps.setString(2, slot);
                                rs = ps.executeQuery();

                                if (rs.next()) {
                                    out.println("<td>" + rs.getString("subject") + "</td>");
                                } else {
                                    out.println("<td>-</td>");
                                }

                                if (rs != null) rs.close(); // Close result set here safely
                            }
                            out.println("</tr>");
                        }

                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' style='color: red; text-align:center;'>Error loading timetable: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
                    }
                %>
            </tbody>
        </table>
    </div>
</main>

<footer>
    &copy; 2025 GP Arts and Science College. All rights reserved.
</footer>

</body>
</html>
