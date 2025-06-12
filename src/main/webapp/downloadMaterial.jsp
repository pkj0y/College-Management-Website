<%@ page import="java.sql.*, java.io.*" %>
<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing file ID");
        return;
    }

    int id = Integer.parseInt(idStr);

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

        String sql = "SELECT file_name, file_data FROM CourseMaterials WHERE id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
            String fileName = rs.getString("file_name");
            InputStream fileData = rs.getBinaryStream("file_data");

            String contentType = application.getMimeType(fileName);
            if (contentType == null) {
                contentType = "application/octet-stream";
            }

            response.setContentType(contentType);
            response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");

            ServletOutputStream con = response.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = fileData.read(buffer)) != -1) {
                con.write(buffer, 0, bytesRead);
            }

            fileData.close();
            con.flush();
            con.close();

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
