package collegeproj;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class AdmissionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String address = request.getParameter("address");

        try {
            Connection conn = DBUtil.getConnection();
            String sql = "INSERT INTO admissions (full_name, dob, gender, contact, email, course, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, dob);
            ps.setString(3, gender);
            ps.setString(4, contact);
            ps.setString(5, email);
            ps.setString(6, course);
            ps.setString(7, address);

            ps.executeUpdate();
            response.sendRedirect("success.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("admission.jsp").forward(request, response);
        }
    }
}
