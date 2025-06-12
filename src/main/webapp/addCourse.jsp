<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<head>
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
            margin-left: auto;
            margin-right: auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            color: #212529;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #495057;
        }

        input[type="text"],
        input[type="number"],
        textarea {
            width: 100%;
            padding: 12px 15px;
            font-size: 16px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus {
            border-color: #007bff;
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: 700;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            display: block;
            width: 100%;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-success:hover {
            background-color: #218838;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                max-width: 100%;
            }
        }
    </style>
</head>

<body>
<div class="container">
    <h2>Add New Course</h2>

    <form action="courseListdb.jsp" method="POST">
        <div class="form-group">
            <label for="courseName">Course Name</label>
            <input type="text" id="courseName" name="courseName" required>
        </div>

        <div class="form-group">
            <label for="courseDescription">Description</label>
            <textarea id="courseDescription" name="courseDescription" required></textarea>
        </div>

        <div class="form-group">
            <label for="courseCredits">Credits</label>
            <input type="number" id="courseCredits" name="courseCredits" min="0" required>
        </div>

        <button type="submit" class="btn-success">Add Course</button>
    </form>
</div>

<%@ include file="footer.jsp" %>

<%
    String success = request.getParameter("success");
%>
<script>
    <% if ("true".equals(success)) { %>
        alert("✅ Course added successfully!");
    <% } %>
</script>

</body>
