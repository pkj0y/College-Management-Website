<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String studentId = request.getParameter("studentId");
    String semester = request.getParameter("semester");
    String amount = request.getParameter("amount");
    String subjectCode = request.getParameter("subjectCode"); // new for arrear fees

    if (studentId == null || semester == null || amount == null) {
        response.sendRedirect("fee-status.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Make Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
        // Client-side validation function
        function validatePaymentForm() {
            const cardNumber = document.getElementById('cardNumber').value.trim();
            const expiry = document.getElementById('expiry').value.trim();
            const cvv = document.getElementById('cvv').value.trim();

            // Card number: 16 digits (allow spaces)
            const cardNumberClean = cardNumber.replace(/\s+/g, '');
            if (!/^\d{16}$/.test(cardNumberClean)) {
                alert('Please enter a valid 16-digit card number.');
                return false;
            }

            // Expiry date: MM/YY format and valid month/year
            if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiry)) {
                alert('Please enter a valid expiry date in MM/YY format.');
                return false;
            } else {
                // Check if expiry is not in the past
                const parts = expiry.split('/');
                const month = parseInt(parts[0], 10);
                const year = 2000 + parseInt(parts[1], 10);
                const now = new Date();
                const expiryDate = new Date(year, month);
                if (expiryDate <= now) {
                    alert('The card expiry date cannot be in the past.');
                    return false;
                }
            }

            // CVV: 3 digits
            if (!/^\d{3}$/.test(cvv)) {
                alert('Please enter a valid 3-digit CVV.');
                return false;
            }

            return true;
        }
    </script>
</head>
<body class="bg-light">

<div class="container mt-5">
    <h3 class="text-center mb-4">
        Payment for 
        Semester <%= semester %>
        <%
            if (subjectCode != null && !subjectCode.trim().isEmpty()) {
        %>
            - Arrear Subject: <%= subjectCode %>
        <%
            }
        %>
    </h3>

    <div class="card p-4 mx-auto" style="max-width: 400px;">
        <form action="payment-success.jsp" method="post" onsubmit="return validatePaymentForm();">
            <input type="hidden" name="studentId" value="<%= studentId %>">
            <input type="hidden" name="semester" value="<%= semester %>">
            <input type="hidden" name="amount" value="<%= amount %>">
            <% if (subjectCode != null && !subjectCode.trim().isEmpty()) { %>
                <input type="hidden" name="subjectCode" value="<%= subjectCode %>">
            <% } %>

            <div class="mb-3">
                <label for="amountDisplay" class="form-label">Amount to Pay (₹)</label>
                <input type="text" class="form-control" id="amountDisplay" value="<%= amount %>" readonly>
            </div>

            <!-- Card details with input masks -->
            <div class="mb-3">
                <label for="cardNumber" class="form-label">Card Number</label>
                <input type="text" class="form-control" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" maxlength="19" autocomplete="off" required>
            </div>

            <div class="mb-3">
                <label for="expiry" class="form-label">Expiry Date</label>
                <input type="text" class="form-control" id="expiry" name="expiry" placeholder="MM/YY" maxlength="5" autocomplete="off" required>
            </div>

            <div class="mb-3">
                <label for="cvv" class="form-label">CVV</label>
                <input type="password" class="form-control" id="cvv" name="cvv" placeholder="123" maxlength="3" autocomplete="off" required>
            </div>

            <button type="submit" class="btn btn-success w-100">Pay Now</button>
            <a href="adminFeesView.jsp" class="btn btn-secondary w-100 mt-2">Cancel</a>
        </form>
    </div>
</div>

<script>
    // Optional: Add input formatting for card number (auto spaces)
    const cardInput = document.getElementById('cardNumber');
    cardInput.addEventListener('input', (e) => {
        let value = e.target.value.replace(/\D/g, '').substring(0,16); // only digits max 16
        let formatted = '';
        for (let i = 0; i < value.length; i++) {
            if (i > 0 && i % 4 === 0) formatted += ' ';
            formatted += value[i];
        }
        e.target.value = formatted;
    });

    // Optional: Add input mask for expiry (MM/YY)
    const expiryInput = document.getElementById('expiry');
    expiryInput.addEventListener('input', (e) => {
        let value = e.target.value.replace(/[^\d]/g, '').substring(0,4);
        if (value.length >= 3) {
            value = value.substring(0,2) + '/' + value.substring(2);
        }
        e.target.value = value;
    });
</script>

</body>
</html>
