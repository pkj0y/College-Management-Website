package collegeproj;



import collegeproj.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viewStudents")
public class ViewStudentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Sample list of students – in a real app, you'd retrieve this from a database
        List<Student> students = new ArrayList<>();
        students.add(new Student(1, "Alice", "Computer Science"));
        students.add(new Student(2, "Bob", "Mechanical Engineering"));
        students.add(new Student(3, "Charlie", "Mathematics"));

        // Set the list in the request scope
        request.setAttribute("students", students);

        // Forward to JSP
        request.getRequestDispatcher("viewStudents.jsp").forward(request, response);
    }
}
