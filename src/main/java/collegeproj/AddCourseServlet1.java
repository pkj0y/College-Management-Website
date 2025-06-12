package collegeproj;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@WebServlet("/addCourseServlet1")
public class AddCourseServlet1 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // DB credentials and connection details
     
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("courseName");
        String description = request.getParameter("courseDescription");
        String creditsStr = request.getParameter("courseCredits");

        try {
            int credits = Integer.parseInt(creditsStr);

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-V55FPFK\\SQLExpress;integratedSecurity=true;TrustServerCertificate=true;Encrypt=false;portNumber=1433;databaseName=collegemgdb");
System.out.println("Add Course Connected");
            String sql = "INSERT INTO courses (course_name, description, credits) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, credits);

            int result = ps.executeUpdate();

            ps.close();
            conn.close();

            if (result > 0) {
                response.sendRedirect("manageCourses.jsp?success=1");
            } else {
                response.sendRedirect("manageCourses.jsp?error=insert_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manageCourses.jsp?error=exception");
        }
    }
}
