<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "model.user" %>
<%@ page import = "model.Customer" %>
<%@ page import = "DAO.ohrsDbUtil" %>
<%@ page import = "model.Payment" %>
<%@ page import = "java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details</title>
    <style>
 * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Roboto', sans-serif;
    background-color: #F5F5F5;
    color: #333333;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    padding: 20px;
}

.form-wrapper {
    display: flex;
    flex-direction: column;
    background-color: #FFFFFF;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    max-width: 800px;
    width: 100%;
    overflow: hidden;
    height: 700px;
}

.form-section {
    padding: 30px;
    background-color: #FAEDD8;
}

.form-section h1 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 28px;
    color: #1E88E5;
}

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    margin-bottom: 10px;
    font-weight: bold;
    color: #333333;
}

.form-group input[type="text"],
.form-group input[type="email"],
.form-group input[type="number"],
.form-group input[type="tel"],
.form-group input[type="date"],
.form-group select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    color: #333;
    background-color: #FAEDD8;
}

button[type="submit"], button[type="button"] {
    width: 200px;
    height: 50px;
    padding: 14px;
    background: linear-gradient(135deg, #1E88E5, #64B5F6);
    color: #FFFFFF;
    font-size: 18px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    margin-bottom: 10px;
}

button[type="submit"]:hover, button[type="button"]:hover {
    background: linear-gradient(135deg, #1565C0, #3F51B5);
}

.image-section {
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #e8dcc6; 
    overflow: hidden;
}

.image-section img {
    width: 100%;
    max-width: 400px;
    height: 750px;
    object-fit: cover;
    border-top-right-radius: 10px;
    border-bottom-right-radius: 10px;
}

@media (min-width: 768px) {
    .form-wrapper {
        flex-direction: row;
    }

    .form-section {
        width: 60%;
    }

    .image-section {
        width: 40%;
    }
}
    </style>
    
    <script>
        // Function to clear the form fields
        function clearForm() {
            document.getElementById("updateForm").reset();
        }
    </script>
       
</head>
<body>
    <%
        HttpSession session1 = request.getSession(false); // Ensure correct session handling
        if (session1 != null && session1.getAttribute("username") != null) {
            String username = (String) session1.getAttribute("username");
            List<user> uD = ohrsDbUtil.getUserDetails(username);
            
            if (uD != null && !uD.isEmpty()) {
                String paymentIdParam = request.getParameter("paymentId");
                
                if (paymentIdParam != null && !paymentIdParam.isEmpty()) {
                    try {
                        int paymentId = Integer.parseInt(paymentIdParam);
                        List<Payment> PD = ohrsDbUtil.readPaymentUpdate(paymentId);

                        if (PD != null && !PD.isEmpty()) {
                            Payment p = PD.get(0); // Get the first payment object from the list
                            user u = uD.get(0); // Get the first user object from the list
    %>

    <div class="form-wrapper">
        <div class="form-section">
            <h1>Payment Details</h1>
            <form action="paymentUpdateServlet" id="updateForm" method="POST">
                <input type="hidden" name="paymentId" value="<%= p.getPaymentId() %>" readonly>
                <input type="hidden" name="userId" value="<%= u.getUser_id() %>" readonly>

                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" value="<%= p.getFullName() %>" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="email" value="<%= p.getEmail() %>" required>
                </div>

                <div class="form-group">
                    <label for="card-type">Card Type:</label>
                    <select id="card-type" name="cardtype" required>
                        <option value="" disabled>Select card type</option>
                        <option value="visa" <%= "visa".equalsIgnoreCase(p.getCardType()) ? "selected" : "" %>>Visa</option>
                        <option value="mastercard" <%= "mastercard".equalsIgnoreCase(p.getCardType()) ? "selected" : "" %>>MasterCard</option>
                        <option value="paypal" <%= "paypal".equalsIgnoreCase(p.getCardType()) ? "selected" : "" %>>PayPal</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="card-number">Card Number:</label>
                    <input type="text" id="card-number" name="cardnumber" value="<%= p.getCardNumber() %>" required>
                </div>

                <div class="form-group">
                    <label for="expiry-date">Expiry Date (MM/YY):</label>
                    <input type="text" id="expiry-date" name="expirydate" value="<%= p.getExpiryDate() %>" required>
                </div>

                <div class="form-group">
                    <label for="cvc">CVV:</label>
                    <input type="text" id="cvc" name="cvv" maxlength="3" pattern="\d{3}" value="<%= p.getcvv() %>" required>
                </div>

                <!-- Submit and Clear Buttons -->
                <div class="form-group">
                    <button type="submit">Save Changes</button>
                    <button type="button" onclick="clearForm()">Clear</button>
                </div>
            </form>
        </div>

        <div class="image-section">
            <img src="https://i.pinimg.com/564x/e7/30/71/e73071bb73dfd0d748545538130638e5.jpg" alt="Payment Image">
        </div>
    </div>

    <%
                        } else {
                            // Redirect to login if no payment details found
                            response.sendRedirect("login.jsp");
                        }
                    } catch (NumberFormatException e) {
                        // Handle invalid paymentId parameter
                        response.sendRedirect("error.jsp?message=Invalid payment ID");
                    }
                } else {
                    // Redirect if paymentId is missing
                    response.sendRedirect("error.jsp?message=Payment ID is required");
                }
            } else {
                // Redirect if no user details found
                response.sendRedirect("login.jsp");
            }
        } else {
            // Redirect if session is invalid or user is not logged in
            response.sendRedirect("login.jsp");
        }
    %>
</body>
</html>