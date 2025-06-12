<%@ page import="java.sql.*" %>

<%@ include file="header.jsp" %>
<%
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("manageNotices.jsp");
        return;
    }
    int id = Integer.parseInt(idParam);

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    String title = "";
    String content = "";
    String date = "";

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");

        String sql = "SELECT title, content, Notice_date FROM notices WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
            date = rs.getString("Notice_date");
        } else {
            response.sendRedirect("manageNotices.jsp");
            return;
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>

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

    form {
        width: 40%;
        height: 85%;
        background: #fff;
        margin: 0 auto;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #444;
        font-size: 15px;
    }

    input[type="text"], input[type="date"], textarea {
        width: 100%;
        padding: 12px 15px;
        font-size: 15px;
        border: 1.8px solid #ccc;
        border-radius: 7px;
        transition: border-color 0.3s ease;
        font-family: inherit;
        resize: vertical;
        min-height: 120px;
    }
    input[type="text"]:focus, input[type="date"]:focus, textarea:focus {
        border-color: #28a745;
        outline: none;
        box-shadow: 0 0 8px rgba(40, 167, 69, 0.3);
    }

    textarea {
        min-height: 140px;
    }

    .btn-success {
        background-color: #28a745;
        border: none;
        color: white;
        font-weight: 700;
        padding: 14px 30px;
        font-size: 16px;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        display: block;
        width: 100%;
        margin-top: 10px;
    }
    .btn-success:hover {
        background-color: #218838;
    }

    a.back-link {
        display: block;
        text-align: center;
        margin-top: 25px;
        color: #007bff;
        text-decoration: none;
        font-weight: 600;
        font-size: 15px;
    }
    a.back-link:hover {
        text-decoration: underline;
        color: #0056b3;
    }
</style>
</head>

<body>
<h1>Edit Notice</h1>
<form action="updateNotice.jsp" method="POST">
    <input type="hidden" name="id" value="<%= id %>">
    <div class="form-group">
        <label for="noticeTitle">Notice Title</label>
        <input type="text" id="noticeTitle" name="noticeTitle" value="<%= title %>" required>
    </div>
    <div class="form-group">
        <label for="noticeContent">Notice Content</label>
        <textarea id="noticeContent" name="noticeContent" required><%= content %></textarea>
    </div>
    <div class="form-group">
        <label for="noticeDate">Notice Date</label>
        <input type="date" id="noticeDate" name="noticeDate" value="<%= date %>" required>
    </div>
    <button type="submit" class="btn-success">Update Notice</button>
</form>



<%@ include file="footer.jsp" %>
</body>
