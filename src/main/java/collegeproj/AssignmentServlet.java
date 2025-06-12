package collegeproj;



import collegeproj.Assignment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/assignments")
public class AssignmentServlet extends HttpServlet {

    // In-memory list of assignments (simulate a database for demo)
    private List<Assignment> assignments = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Pass assignments list to JSP
        request.setAttribute("assignments", assignments);
        request.getRequestDispatcher("assignments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form parameters
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        // Create and add new assignment
        Assignment newAssignment = new Assignment(title, description);
        assignments.add(newAssignment);

        // Redirect to GET to refresh the page
        response.sendRedirect("assignments");
    }
}
