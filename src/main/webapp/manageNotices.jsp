<%@ page import="java.sql.*" %>

<%@ include file="header.jsp" %>
<head>
<style>
    /* Reset & base */
    * {
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
        padding: 40px 20px;
        color: #343a40;
    }

    h1 {
        text-align: center;
        font-weight: 700;
        margin-bottom: 30px;
        color: #212529;
        letter-spacing: 1px;
    }

    /* Add New Button */
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

    /* Container for all notice cards */
    .notice-container {
        max-width: 900px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* Single notice card */
    .notice-card {
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        padding: 25px 30px;
        transition: box-shadow 0.3s ease;
    }

    .notice-card:hover {
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
    }

    /* Title styling */
    .notice-title {
        font-size: 20px;
        font-weight: bold;
        color: #212529;
        margin-bottom: 8px;
    }

    /* Date styling */
    .notice-date {
        font-size: 14px;
        color: #6c757d;
        margin-bottom: 15px;
    }

    /* Content styling */
    .notice-content {
        font-size: 15px;
        color: #343a40;
        margin-bottom: 15px;
        line-height: 1.5;
    }

    /* Action links */
    .notice-actions {
        display: flex;
        gap: 20px;
    }

    .notice-actions a {
        color: #007bff;
        text-decoration: none;
        font-weight: 600;
        transition: color 0.3s ease;
        font-size: 14px;
    }

    .notice-actions a:hover {
        color: #0056b3;
        text-decoration: underline;
    }

    /* Responsive */
    @media (max-width: 768px) {
        body {
            padding: 20px 10px;
        }

        .notice-card {
            padding: 20px;
        }

        .notice-title {
            font-size: 18px;
        }

        .notice-content {
            font-size: 14px;
        }

        .notice-actions a {
            font-size: 13px;
        }
    }
</style>
</head>

<body>

<h1>Notices</h1>
<a class="add-new" href="addNotice.jsp">Add New Notice</a>

<div class="notice-container">
<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");
        String sql = "SELECT id, title, Notice_date, content FROM notices ORDER BY Notice_date DESC";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String content = rs.getString("content");
            String date = rs.getString("Notice_date");
%>
    <div class="notice-card">
        <div class="notice-title"><%= title %></div>
        <div class="notice-date">Posted on: <%= date %></div>
        <div class="notice-content"><%= content %></div>
        <div class="notice-actions">
            <a href="editNotice.jsp?id=<%= id %>">Edit</a>
            <a href="deleteNotice.jsp?id=<%= id %>" onclick="return confirm('Are you sure you want to delete this notice?');">Delete</a>
        </div>
    </div>
<%
        }
    } catch (Exception e) {
%>
    <p style="color:red; text-align:center;">Error loading notices: <%= e.getMessage() %></p>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
</div>

<%@ include file="footer.jsp" %>
</body>
