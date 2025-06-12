<%@ page import="java.sql.*" %>

<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Course Materials</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
      body {
    margin: 0;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    background: url('ramyacollege.jpeg') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

main {
    flex: 1 0 auto;  /* Make main expand to fill available space */
    padding: 40px 20px;
}

.overlay {
    background-color: rgba(255, 255, 255, 0.95);
    padding: 30px;
    border-radius: 10px;
    max-width: 1000px;
    margin: 60px auto;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.material-heading {
    font-size: 2rem;
    font-weight: 700;
    color: #212529;
    text-align: center;
    margin-bottom: 30px;
    position: relative;
}

.material-heading::after {
    content: '';
    display: block;
    width: 70px;
    height: 4px;
    background-color: #0d6efd;
    margin: 10px auto 0;
    border-radius: 2px;
}

table thead {
    background-color: #0d6efd;
    color: white;
}

table th, table td {
    text-align: center;
    vertical-align: middle;
    padding: 12px;
}

table tbody tr:hover {
    background-color: #f1f3f5;
}

.btn-primary {
    background-color: #0d6efd;
    border: none;
    transition: background-color 0.3s ease;
}

.btn-primary:hover {
    background-color: #0b5ed7;
}

footer {
    background-color: #343a40;
    color: white;
    padding: 20px 10px;
    text-align: center;
    font-size: 0.95rem;
    flex-shrink: 10%; /* Prevent footer from shrinking */
     width: 100%;
}
</style>
</head>
<body>

<main>
    <div class="overlay">
        <h2 class="material-heading">Available Course Materials</h2>
        <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>File Name</th>
                        <th>Download</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
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

                        String sql = "SELECT id, file_name FROM CourseMaterials ORDER BY id DESC";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String fileName = rs.getString("file_name");
                %>
                    <tr>
                        <td><%= fileName %></td>
                        <td><a href="downloadMaterial.jsp?id=<%=id%>" class="btn btn-primary btn-sm">Download</a></td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr><td colspan="2" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
                <%
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<footer>
    &copy; 2025 GP Arts and Science College. All rights reserved.
</footer>
</body>
</html>
