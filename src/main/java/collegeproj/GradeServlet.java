package collegeproj;

import collegeproj.Grade;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/grades")
public class GradeServlet extends HttpServlet {

    // In-memory list to store grades (simulating a database)
    private List<Grade> gradeList = new ArrayList<>();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String studentId = request.getParameter("studentId");
        String gradeValue = request.getParameter("grade");

        // Create new Grade object and add it to the list
        Grade grade = new Grade(studentId, gradeValue);
        gradeList.add(grade);

        // You could also set a success message here if needed
        request.setAttribute("message", "Grade submitted successfully.");

        // Redirect or forward as needed (here we'll forward to a confirmation JSP or back to form)
        request.getRequestDispatcher("enter_grades.jsp").forward(request, response);
    }
}
