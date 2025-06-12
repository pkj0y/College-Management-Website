<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Available Course Materials</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Available Course Materials</h2>
    <table class="table table-striped table-bordered">
        <thead class="table-primary">
            <tr>
                <th>File Name</th>
                <th>Uploaded By</th>
                <th>Upload Date</th>
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
                        "databaseName=collegemgdb;"
                    );

                    String query = "SELECT filename, filepath, upload_date, uploaded_by FROM course_materials ORDER BY upload_date DESC";
                    ps = conn.prepareStatement(query);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String filename = rs.getString("filename");
                        String filepath = rs.getString("filepath"); // path on server or URL
                        String uploadDate = rs.getString("upload_date");
                        String uploadedBy = rs.getString("uploaded_by");
            %>
                        <tr>
                            <td><%= filename %></td>
                            <td><%= uploadedBy %></td>
                            <td><%= uploadDate %></td>
                            <td>
                                <a href="<%= filepath %>" download class="btn btn-sm btn-primary">
                                    <i class="bi bi-download"></i> Download
                                </a>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4' style='color:red;'>Error loading materials: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
            %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.js"></script>
</body>
</html>
