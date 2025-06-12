<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home - Notice Board</title>
    <link rel="stylesheet" href="styles.css">
    <style>
     body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: url('ramyacollege.jpeg') no-repeat center center fixed;
    background-size: cover;
    margin: 0;
    padding: 0;
    color: #333;
}


.notice-board {

    padding: 40px 20px;
    max-width: 800px;
    margin: 40px auto;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease-in-out;
}

.notice-board h1 {
    text-align: center;
    color: #004080;
    margin-bottom: 30px;
    font-size: 2em;
    border-bottom: 2px solid #004080;
    padding-bottom: 10px;
   
}

.notice {
    background-color: #f9fbff;
    margin-bottom: 20px;
    padding: 20px 25px;
    border-left: 6px solid #004080;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    transition: transform 0.2s ease;
    
}

.notice:hover {
    transform: translateY(-2px);
}

.notice h2 {
    font-size: 1.3em;
    color: #003366;
    margin: 0 0 8px 0;
}

.notice p {
    font-size: 1em;
    color: #555;
    margin-top: 10px;
}

.notice-date {
    font-size: 0.85em;
    color: #888;
    margin-top: 4px;
    font-style: italic;
}

    </style>
</head>
<body>

<div class="notice-board">
    <h1>Latest Notices</h1>

<%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");

        String sql = "SELECT title, content, notice_date FROM notices ORDER BY notice_date DESC";
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();

        while (rs.next()) {
            String nTitle = rs.getString("title");
            String nContent = rs.getString("content");
            String nDate = rs.getString("notice_date");
%>
        <div class="notice">
            <h2><%= nTitle %></h2>
            <div class="notice-date">Posted on: <%= nDate %></div>
            <p><%= nContent %></p>
        </div>
<%
        }
    } catch (Exception e) {
%>
        <p>Error loading notices: <%= e.getMessage() %></p>
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
