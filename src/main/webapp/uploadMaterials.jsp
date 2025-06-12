<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Upload Materials</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e0eafc, #cfdef3);
            margin: 0;
            padding: 0;
        }

        .upload-container {
            max-width: 500px;
            margin: 60px auto;
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .upload-container h2 {
            text-align: center;
            color: #004080;
            margin-bottom: 25px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        input[type="file"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 20px;
            cursor: pointer;
        }

        input[type="submit"] {
            background-color: #004080;
            color: white;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0066cc;
        }
    </style>
</head>
<body>

<div class="upload-container">
    <h2>Upload Course Materials</h2>
    <form action="uploadMaterials" method="post" enctype="multipart/form-data">
        <label for="material">Select Material:</label>
        <input type="file" id="material" name="material" required>
        <input type="submit" value="Upload">
    </form>
</div>

</body>
<%@ include file="footer.jsp" %>
</html>
