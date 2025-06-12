<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" type="text/css" href="styles.css">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GP Arts and Science College</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #004080;
            color: white;
            padding: 15px;
            text-align: center;
        }

        nav ul {
            list-style: none;
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
            background-color: #003060;
        }

        nav ul li {
            margin: 0 15px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 15px;
            display: block;
        }

        nav ul li a:hover {
            background-color: #002050;
            border-radius: 5px;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #ffffff;
            margin: 8% auto;
            padding: 40px;
            border-radius: 12px;
            width: 70%;
            max-width: 800px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            position: relative;
            color: #333;
        }

        .modal-content h2 {
            font-size: 28px;
            color: #004080;
            margin-bottom: 15px;
            border-bottom: 2px solid #004080;
            padding-bottom: 10px;
        }

        .modal-content h3 {
            color: #0056b3;
            margin-top: 25px;
            font-size: 20px;
        }

        .modal-content p {
            font-size: 16px;
            line-height: 1.6;
        }

        .close {
            color: #888;
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 32px;
            font-weight: bold;
            cursor: pointer;
            transition: color 0.3s;
        }

        .close:hover {
            color: #ff4d4d;
        }
footer {
    position: fixed;
    bottom: 0;
    left: 0;
    background-color: #003366;
    color: white;
    padding: 10px;
    text-align: center;
    height: 12%;
    width: 100%;
    font-family: 'Segoe UI', sans-serif;
    border-top: 2px solid #0059b3;
    /* optional, ensures it's on top */
}

    </style>
</head>
<body>

<!-- Header -->
<header>
    <h1>GP Arts and Science College</h1>
    <nav>
        <ul>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="noticeBoard.jsp">E-NoticeBoard</a></li>
            <li><a href="ViewCourse.jsp">Courses</a></li>
            <li><a href="admission.jsp">Admission</a></li>
            <li><a href="#" onclick="openAbout()">About Us</a></li>
        </ul>
    </nav>
</header>

<!-- Modal -->
<div id="aboutModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeAbout()">&times;</span>
        <h2>About GP Arts and Science College</h2>
        <p>
            GP Arts and Science College is committed to academic excellence, cultural development, and producing responsible graduates. 
            Our programs aim to equip students with both theoretical knowledge and practical skills.
        </p>
        <h3>Mission</h3>
        <p>To provide quality higher education that promotes innovation, critical thinking, and lifelong learning.</p>
        <h3>Vision</h3>
        <p>To be a center of excellence in education, shaping leaders who contribute positively to society.</p>
        <h3>Contact</h3>
        <p>Email: info@GPcollege.edu | Phone: +91-9876543210</p>
    </div>
</div>

<!-- JavaScript -->
<script>
    function openAbout() {
        document.getElementById("aboutModal").style.display = "block";
    }

    function closeAbout() {
        document.getElementById("aboutModal").style.display = "none";
    }

    // Close modal on outside click
    window.onclick = function(event) {
        const modal = document.getElementById("aboutModal");
        if (event.target === modal) {
            modal.style.display = "none";
        }
    }
</script>

<!-- Footer -->
 <footer>
        <p>📍 Address: 123 College Road, City, State, Country</p>
        <p>📞 Phone: +123 456 7890</p>
        <p>✉️ Email: info@gpartscollege.com</p>
    </footer>
    

</body>
</html>
