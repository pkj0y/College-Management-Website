<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // ✅ Session check to prevent unauthenticated access
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Marks</title>
    <link rel="stylesheet" href="css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>Exam Marks</h3>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Subject</th>
                <th>Internal Marks</th>
                <th>External Marks</th>
                <th>Total</th>
                <th>Grade</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Mathematics</td>
                <td>18</td>
                <td>72</td>
                <td>90</td>
                <td>A+</td>
            </tr>
            <tr>
                <td>Physics</td>
                <td>15</td>
                <td>65</td>
                <td>80</td>
                <td>A</td>
            </tr>
            <tr>
                <td>Computer Science</td>
                <td>20</td>
                <td>75</td>
                <td>95</td>
                <td>A+</td>
            </tr>
        </tbody>
    </table>
</div>
</body>
</html>
