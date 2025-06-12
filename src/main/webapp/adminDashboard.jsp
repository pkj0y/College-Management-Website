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
        }

        .text-center {
            text-align: center;
            margin-bottom: 30px;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .col-md-4 {
            flex: 0 0 30%;
            display: flex;
            justify-content: center;
        }

        .btn-block {
            display: block;
            width: 100%;
            padding: 15px 0;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            border: none;
            background-color: #007bff;
            color: white;
            border-radius: 6px;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-block:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .col-md-4 {
                flex: 0 0 100%;
            }
        }
        
            footer {
            background-color: #343a40;
            color: white;
            padding: 10px;
            text-align: center;
            height: 60px;
            width: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
           
            position: fixed;
            bottom: 0;
            left: 0;
           
            font-weight: 500;
        }
        
    </style>
</head>

<div class="container">
    <h2 class="text-center">Admin Dashboard</h2>
    <div class="row">
        <div class="col-md-4">
            <a href="addStudent.jsp" class="btn btn-primary btn-block">Student Management</a>
        </div>
        <div class="col-md-4">
            <a href="addfaculty.jsp" class="btn btn-primary btn-block">Faculty Management</a>
        </div>
        <div class="col-md-4">
            <a href="manageCourses.jsp" class="btn btn-primary btn-block">Manage Courses</a>
        </div>
        <div class="col-md-4">
            <a href="manageNotices.jsp" class="btn btn-primary btn-block">Manage Notices</a>
        </div>
       
        <div class="col-md-4">
            <a href="uploadMaterials.jsp" class="btn btn-primary btn-block">Upload Materials</a>
        </div>
        
        <div class="col-md-4">
            <a href="edit_timetable.jsp" class="btn btn-primary btn-block">Edit Timetable</a>
        </div>
         <div class="col-md-4">
            <a href="adminInsertFees.jsp" class="btn btn-primary btn-block">Fees Management</a>
        </div>
          <div class="col-md-4">
            <a href="viewAdmissions.jsp" class="btn btn-primary btn-block">View Students Admission</a>
        </div>
        <div class="col-md-4">
            <a href="viewFaculty.jsp" class="btn btn-primary btn-block">View Facultys</a>
        </div>
          <div class="col-md-4">
            <a href="viewProfile.jsp" class="btn btn-primary btn-block">View Students</a>
        </div>
         
         <div class="text-center mt-4">
            <a href="logout.jsp" class="btn btn-danger">Logout</a>
        </div>
        
        
    </div>
</div>

<footer>
    &copy; 2025 GP Arts and Science College. All rights reserved.
</footer>
