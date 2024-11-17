<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "DAO.ohrsDbUtil" %>
<%@ page import = "java.util.List" %>
<%@ page import = "model.user" %>
<%@ page import = "model.Customer" %>
<%@ page import = "model.Payment" %> 
<!DOCTYPE html>  
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/jpg" href="css/logo1.jpg"> 
    <title>Payment Details</title>
    <style>
       /* Global Reset */
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
</head>
<body>
    <% 
        HttpSession session1 = request.getSession(false);
        if (session1 != null && session1.getAttribute("username") != null) {
            String username = (String) session1.getAttribute("username");
            List<user> uid = ohrsDbUtil.getUserDetails(username);
            if(uid != null && !uid.isEmpty()) {
                user u = uid.get(0); // Assuming you want the first user
                int uuid = u.getUser_id();
                pageContext.setAttribute("uuid", uuid);
    %>

    <div class="form-wrapper">
        <div class="form-section">
            <h1>Payment Details</h1>
            <form action="paymentInsertionServlet" method="post">
                <input type="hidden" name="user_id" value="${uuid}" readonly>
                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" placeholder="Enter your name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <label for="card-type">Card Type:</label>
                    <select id="card-type" name="cardtype" required>
                        <option value="" disabled selected>Select card type</option>
                        <option value="visa">Visa</option>
                        <option value="mastercard">MasterCard</option>
                        <option value="paypal">PayPal</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="card-number">Card Number:</label>
                    <input type="text" id="card-number" name="cardnumber" maxlength="16" pattern="\d{16}" placeholder="Enter Your Card Number" required>
                </div>
                <div class="form-group">
                    <label for="expiry-date">Expiry Date:</label>
                    <input type="date" id="expiry-date" name="expirydate" min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                </div>
                <div class="form-group">
                    <label for="cvc">CVV:</label>
                    <input type="text" id="cvc" name="cvv" maxlength="3" pattern="\d{3}" placeholder="Enter CVV" required>
                </div>
                <input type="hidden" id="amount" name="amount">
                <div class="form-group">
                    <button type="submit">Save Details</button>
                    <a href="user.jsp"><button type="button">Go Back</button></a>
                </div>
            </form>
        </div>
        <div class="image-section">
            <img src="https://i.pinimg.com/564x/e7/30/71/e73071bb73dfd0d748545538130638e5.jpg" alt="Payment Image">
        </div>
    </div>

    <%
            } else {
                response.sendRedirect("success/unsuccess.jsp");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    %>
</body>
</html>
