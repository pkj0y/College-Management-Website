<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<html>
<head>
    <title>Edit Faculty Timetable</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            overflow: hidden; /* disable page scroll */
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #e9eff5;
            background-image: url('ramyacollege.jpeg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed; /* fix background */
        }

        .timetable-box {
            max-width: 800px;
            max-height: 100vh; /* full viewport height */
            overflow-y: auto; /* internal scroll if needed */
            margin: 60px auto;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        h2 {
            color: #003366;
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #003366;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        td input {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn-submit {
            display: block;
            margin: 0 auto;
            padding: 10px 25px;
            background-color: #28a745;
            border: none;
            color: white;
            font-size: 14px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        .btn-submit:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="timetable-box">
        <h2>Edit Faculty Timetable</h2>
        <form action="timetable1.jsp" method="post">
            <table>
                <thead>
                    <tr>
                        <th>Day</th>
                        <th>9:00 - 10:00</th>
                        <th>10:00 - 11:00</th>
                        <th>11:00 - 12:00</th>
                        <th>1:00 - 2:00</th>
                        <th>2:00 - 3:00</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
                        for (int i = 0; i < days.length; i++) {
                            out.println("<tr>");
                            out.println("<td>" + days[i] + "</td>");
                            for (int j = 0; j < 5; j++) {
                                String fieldName = "cell_" + i + "_" + j;
                                out.println("<td><input type='text' name='" + fieldName + "' /></td>");
                            }
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
            <input type="submit" class="btn-submit" value="Save Timetable">
        </form>
    </div>

<%@ include file="footer.jsp" %>
</body>
</html>
