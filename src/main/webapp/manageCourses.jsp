<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<head>
    <style>
        body {
            background-color: #f4f6f8;
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 900px;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 12px;
            font-size: 16px;
        }

        thead tr {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 8px;
        }

        thead th {
            padding: 12px 20px;
            text-align: left;
        }

        tbody tr {
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            transition: background-color 0.2s ease;
        }

        tbody tr:hover {
            background-color: #e9f7ff;
        }

        tbody td {
            padding: 14px 20px;
            vertical-align: middle;
            color: #333;
            border: none;
        }

        a.action-btn {
            color: #007bff;
            font-weight: 600;
            text-decoration: none;
            margin-right: 15px;
            font-size: 14px;
        }

        a.action-btn:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        .add-new {
            display: block;
            width: max-content;
            margin: 0 auto 30px auto;
            padding: 12px 28px;
            background-color: #28a745;
            color: white;
            font-weight: 700;
            font-size: 16px;
            border-radius: 6px;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .add-new:hover {
            background-color: #218838;
            box-shadow: 0 6px 18px rgba(33, 136, 56, 0.4);
        }

        @media (max-width: 768px) {
            table {
                font-size: 14px;
            }
            a.action-btn {
                margin-right: 10px;
                font-size: 13px;
            }
        }
    </style>
</head>

<body>
<div class="container">
    <h2>Course List</h2>
    <a class="add-new" href="addCourse.jsp">Add New Course</a>

    <table>
        <thead>
            <tr>
                <th>Course Name</th>
                <th>Description</th>
                <th>Credits</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");

                String sql = "SELECT id, courseName, courseDescription, courseCredits FROM courses ORDER BY courseName";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("courseName");
                    String description = rs.getString("courseDescription");
                    int credits = rs.getInt("courseCredits");
        %>
            <tr>
                <td><%= name %></td>
                <td><%= description.length() > 50 ? description.substring(0, 50) + "..." : description %></td>
                <td><%= credits %></td>
                <td>
                    <a class="action-btn" href="editCourse.jsp?id=<%= id %>">Edit</a>
                    <a class="action-btn" href="deleteCourse.jsp?id=<%= id %>" onclick="return confirm('Are you sure to delete this course?');">Delete</a>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
        %>
            <tr><td colspan="4" style="color:red;">Error loading courses: <%= e.getMessage() %></td></tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        %>
        </tbody>
    </table>
</div>

<%@ include file="footer.jsp" %>
</body>
