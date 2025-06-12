<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<head>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #e9ecef;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 60px auto;
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            font-size: 2.2rem;
            margin-bottom: 30px;
            color: #004080;
            position: relative;
        }

        
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 1rem;
            transition: all 0.3s ease-in-out;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 6px rgba(0, 123, 255, 0.3);
            outline: none;
        }

        .form-check-label {
            margin-right: 15px;
            font-weight: normal;
        }

        .btn-submit {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border-radius: 6px;
            font-size: 1.1rem;
            width: 100%;
            border: none;
            transition: background-color 0.3s ease-in-out;
        }

        .btn-submit:hover {
            background-color: #0056b3;
        }

        .alert {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px 20px;
            border: 1px solid #f5c6cb;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 1rem;
        }

        @media (max-width: 576px) {
            .container {
                padding: 25px 20px;
            }

            h2 {
                font-size: 1.75rem;
            }
        }
    </style>
</head>

<div class="container">
    <h2>College Admission Form</h2>

    <!-- Display Error Message if Any -->
    <c:if test="${not empty error}">
        <div class="alert">${error}</div>
    </c:if>

    <form action="processAdmission.jsp" method="POST">
        <!-- Full Name -->
        <div class="form-group">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>

        <!-- Date of Birth -->
        <div class="form-group">
            <label for="dob" class="form-label">Date of Birth</label>
            <input type="date" class="form-control" id="dob" name="dob" required>
        </div>

        <!-- Gender -->
        <div class="form-group">
            <label class="form-label">Gender</label>
            <div>
                <input type="radio" id="male" name="gender" value="Male" required>
                <label for="male" class="form-check-label">Male</label>

                <input type="radio" id="female" name="gender" value="Female" required>
                <label for="female" class="form-check-label">Female</label>
            </div>
        </div>

        <!-- Contact Number -->
        <div class="form-group">
            <label for="contact" class="form-label">Contact Number</label>
            <input type="tel" class="form-control" id="contact" name="contact" pattern="[0-9]{10}" required>
        </div>

        <!-- Email Address -->
        <div class="form-group">
            <label for="email" class="form-label">Email Address</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <!-- Course Preference -->
        <div class="form-group">
            <label for="course" class="form-label">Course Preference</label>
            <select class="form-control" id="course" name="course" required>
                <option value="BSc">BSc - Bachelor of Science</option>
                <option value="BCom">BCom - Bachelor of Commerce</option>
                <option value="BA">BA - Bachelor of Arts</option>
                <option value="BCA">BCA - Bachelor of Computer Applications</option>
            </select>
        </div>

        <!-- Address -->
        <div class="form-group">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" id="address" name="address" rows="4" required></textarea>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn-submit">Submit</button>
    </form>
</div>

<%@ include file="footer.jsp" %>
