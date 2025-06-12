<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Courses</title>
    <link rel="stylesheet" href="styles.css">
    <style>
    
    
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }

        .course-board {
            max-width: 900px;
            margin: 60px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .course-board h1 {
            text-align: center;
            font-size: 2.2rem;
            color: #004080;
            margin-bottom: 30px;
            position: relative;
        }

        .course-board h1::after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background-color: #007bff;
            margin: 10px auto 0;
            border-radius: 2px;
        }

        .course {
            background-color: #f9fbff;
            padding: 20px;
            border: 1px solid #dbe2ef;
            border-radius: 8px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .course:hover {
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.1);
            transform: scale(1.01);
        }

        .course h2 {
            margin: 0 0 10px;
            font-size: 1.4rem;
            color: #003366;
        }

        .course-credits {
            font-size: 0.95rem;
            color: #555;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .course p {
            font-size: 1rem;
            color: #444;
            line-height: 1.6;
        }

        /* Responsive */
        @media (max-width: 600px) {
            .course-board {
                padding: 20px;
            }

            .course h2 {
                font-size: 1.2rem;
            }

            .course p {
                font-size: 0.95rem;
            }
        }
    </style>
</head>
<body>

<div class="course-board">
    <h1>Available Courses</h1>

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

            String sql = "SELECT courseName, courseDescription, courseCredits FROM Courses ORDER BY courseName";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString("courseName");
                String description = rs.getString("courseDescription");
                int courseCredits = rs.getInt("courseCredits");
    %>
        <div class="course">
            <h2><%= name %></h2>
            <div class="course-credits">Credits: <%= courseCredits %></div>
            <p><%= description %></p>
        </div>
    <%
            }
        } catch (Exception e) {
    %>
        <p style="color:red; font-weight: bold;">Error loading courses: <%= e.getMessage() %></p>
    <%
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>
</div>

</body>
</html>
