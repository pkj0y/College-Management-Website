<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Manage Attendance</title>
    <style>
        body {
            background-color: #f4f6f8;
            font-family: Arial, sans-serif;
        }

        .container {
            margin-top: 50px;
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: auto;
        }

        .text-center {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        input[type="text"],
        select,
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #1e7e34;
        }

        /* Inline radio buttons */
        .radio-group label {
            margin-right: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="text-center">Mark Attendance</h2>

    <form action="saveattendance.jsp" method="POST">

        <div class="form-group">
            <label for="studentId">Enter Student ID</label>
            <input type="text" name="studentId" id="studentId" placeholder="e.g. 12345" required>
        </div>

        <div class="form-group">
            <label for="studentName">Enter Student Name</label>
            <input type="text" name="studentName" id="studentName" placeholder="e.g. John Doe" required>
        </div>

        <div class="form-group">
            <label for="subject">Select Subject</label>
            <select name="subject" id="subject" required>
                <option value="">-- Select Subject --</option>
                <option value="Mathematics">Mathematics</option>
                <option value="Physics">Physics</option>
                <option value="Chemistry">Chemistry</option>
                <option value="Biology">Biology</option>
                <option value="English">English</option>
            </select>
        </div>

        <div class="form-group radio-group">
            <label>Attendance</label><br>
            <label><input type="radio" name="attendance" value="Present" required> Present</label>
            <label><input type="radio" name="attendance" value="Absent" required> Absent</label>
        </div>

        <input type="submit" value="Submit Attendance" />
    </form>
</div>
</body>
<%@ include file="footer.jsp" %>
</html>
