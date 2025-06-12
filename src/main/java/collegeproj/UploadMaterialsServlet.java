package collegeproj;

import java.io.*;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/uploadMaterials")
@MultipartConfig
public class UploadMaterialsServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("material");
        String fileName = filePart.getSubmittedFileName();

        InputStream fileContent = filePart.getInputStream();

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
        	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        	Connection con =DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");
    		System.out.println("Connected.....");
    		
            String sql = "INSERT INTO CourseMaterials (file_name, file_data) VALUES (?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, fileName);
            pstmt.setBinaryStream(2, fileContent, (int) filePart.getSize());

            int rows = pstmt.executeUpdate();

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (rows > 0) {
                out.println("<script>alert('File uploaded successfully!'); window.location='uploadMaterials.jsp';</script>");
            } else {
                out.println("<script>alert('Upload failed.'); window.location='uploadMaterials.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
