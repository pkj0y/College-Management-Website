<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fees Details</title>
    <link rel="stylesheet" href="css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>Fees Status</h3>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Semester</th>
                <th>Total Fees</th>
                <th>Paid</th>
                <th>Pending</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>₹50,000</td>
                <td>₹50,000</td>
                <td>₹0</td>
                <td class="text-success">Paid</td>
            </tr>
            <tr>
                <td>2</td>
                <td>₹50,000</td>
                <td>₹30,000</td>
                <td>₹20,000</td>
                <td class="text-warning">Pending</td>
            </tr>
        </tbody>
    </table>
</div>
</body>
</html>
