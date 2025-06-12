<%@ include file="header.jsp" %>
<head>
<style>
    /* Reset & base */
    * {
        box-sizing: border-box;
    }
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8f9fa;
        padding: 40px 20px;
        color: #343a40;
    }

    h1 {
        text-align: center;
        font-weight: 700;
        margin-bottom: 30px;
        color: #212529;
        letter-spacing: 1px;
    }

    form {
        width: 40%;
        height: 70%;
        background: #fff;
        margin: 0 auto;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 6px 15px rgba(0,0,0,0.1);
    }

    .form-group {
        margin-bottom: 22px;
    }

    label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #444;
        font-size: 15px;
    }

    input[type="text"], input[type="date"], textarea {
        width: 100%;
        padding: 12px 15px;
        font-size: 15px;
        border: 1.8px solid #ccc;
        border-radius: 7px;
        transition: border-color 0.3s ease;
        font-family: inherit;
        resize: vertical;
        min-height: 120px;
    }
    input[type="text"]:focus, input[type="date"]:focus, textarea:focus {
        border-color: #28a745;
        outline: none;
        box-shadow: 0 0 8px rgba(40, 167, 69, 0.3);
    }

    textarea {
        min-height: 140px;
    }

    .btn-success {
        background-color: #28a745;
        border: none;
        color: white;
        font-weight: 700;
        padding: 14px 30px;
        font-size: 16px;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        display: block;
        width: 100%;
        margin-top: 10px;
    }
    .btn-success:hover {
        background-color: #218838;
    }

    a.back-link {
        display: block;
        text-align: center;
        margin-top: 25px;
        color: #007bff;
        text-decoration: none;
        font-weight: 600;
        font-size: 15px;
    }
    a.back-link:hover {
        text-decoration: underline;
        color: #0056b3;
    }
</style>
</head>

<body>
<h1>Add Notice</h1>
<form action="saveNotice.jsp" method="POST">
    <div class="form-group">
        <label for="noticeTitle">Notice Title</label>
        <input type="text" id="noticeTitle" name="noticeTitle" placeholder="Enter notice title" required>
    </div>
    <div class="form-group">
        <label for="noticeContent">Notice Content</label>
        <textarea id="noticeContent" name="noticeContent" placeholder="Enter notice content" required></textarea>
    </div>
    <div class="form-group">
        <label for="noticeDate">Notice Date</label>
        <input type="date" id="noticeDate" name="noticeDate" required>
    </div>
    <button type="submit" class="btn-success">Add Notice</button>
</form>

<a href="manageNotices.jsp" class="back-link">← Back to Notices</a>

<%@ include file="footer.jsp" %>
</body>
