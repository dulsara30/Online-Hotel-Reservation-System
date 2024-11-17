<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Hotel" %>
<%@ page import="model.user" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.ohrsDbUtil" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/jpg" href="css/logo1.jpg">
    <title>Customer Room Booking Form</title>
    
    <!-- Updated CSS for improved appearance -->
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #F5F5F5;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .form-wrapper {
            display: flex;
            flex-direction: column;
            background-color: #FFFFFF;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 1000px;
            width: 100%;
            overflow: hidden;
        }

        .form-section {
            padding: 40px;
            background-color: #FAEDD8;
            flex: 1;
        }

        .form-section h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: #1E88E5;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            background-color: #FFFFFF;
            color: #333;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #1E88E5;
        }

        button[type="submit"],
        .button-link {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #1E88E5, #64B5F6);
            color: #FFFFFF;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
            text-align: center;
            text-decoration: none;
            display: block;
        }

        button[type="submit"]:hover,
        .button-link:hover {
            background: linear-gradient(135deg, #1565C0, #3F51B5);
        }

        .image-section {
            display: flex;
            /*gap: 20px;
            padding: 20px;*/
            background-color: #E3F2FD;
            justify-content: center;
            align-items: center;
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .image-section img {
            width: calc(50% - 10px);
            max-width: 100%;
            height: auto;
            object-fit: cover;
            border-radius: 5px;
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
                flex-direction: column;
               /* gap: 20px;*/
                border-radius: 0;
            }

            .image-section img {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <%
        HttpSession session1 = request.getSession(false);
        if (session1 != null && session1.getAttribute("username") != null) {
            String username = (String) session1.getAttribute("username");
            List<user> u = ohrsDbUtil.getUserDetails(username);
            if (u != null && !u.isEmpty()) {
                for (user uD : u) {
                    int userId = uD.getUser_id();
                    String roomid = request.getParameter("roomId");
                    String checkin = request.getParameter("checkin");
                    String checkout = request.getParameter("checkout");
    %>
    <div class="form-wrapper">
        <div class="form-section">
            <h1>Customer Room Booking Form</h1>
            <form action="bookingServlet" method="POST">
                <input type="hidden" name="roomId" value="<%= roomid %>" readonly>
                <input type="hidden" name="userId" value="<%= userId %>" readonly>

                <div class="form-group">
                    <label for="name">Full Name:</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                </div>

                <div class="form-group">
                    <label for="checkin">Check-in Date:</label>
                    <input type="date" id="checkin" name="checkin" value="<%= checkin %>" readonly>
                </div>

                <div class="form-group">
                    <label for="checkout">Check-out Date:</label>
                    <input type="date" id="checkout" name="checkout" value="<%= checkout %>" readonly>
                </div>

                <div class="form-group">
                    <label for="roomtype">Room Type:</label>
                    <select id="roomtype" name="roomtype">
                        <option value="<%= request.getParameter("roomtype") %>" selected>
                            <%= request.getParameter("roomtype") %>
                        </option>
                    </select>
                </div>
         

                <div class="form-group">
                    <label for="guests">Number of Guests:</label>
                    <input type="number" id="guests" name="guests" min="1" max="5" placeholder="Enter the number of guests" required>
                </div>

                <div class="form-group">
                    <label for="board">Board Type:</label>
                    <select id="board" name="board" required>
                        <option value="" disabled selected>Select board type</option>
                        <option value="full">Full Board</option>
                        <option value="half">Half Board</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="note">Additional Notes:</label>
                    <textarea id="note" name="note" rows="4" placeholder="Any special requests or notes"></textarea>
                </div>

                <div class="form-group">
                    <label for="contact">Contact Number:</label>
                    <input type="tel" id="contact" name="contact" maxlength="10" pattern="[0-9]{1,10}" placeholder="Enter your contact number" required>
                </div>

                <div class="form-group">
                    <label for="payment">Payment Method:</label>
                    <select id="payment" name="payment" required>
                        <option value="" disabled selected>Select payment method</option>
                        <option value="creditcard">Credit Card</option>
                        <option value="debitcard">Debit Card</option>
                        <option value="paypal">PayPal</option>
                        <option value="cash">Cash on Arrival</option>
                    </select>
                </div>

                <div class="form-group">
                    <button type="submit">Submit Booking</button>
                </div>
                <div class="form-group">
                    <a href="homePage.jsp" class="button-link">Home Page</a>
                </div>
            </form>
        </div>

        <div class="image-section">
            <img src="https://i.pinimg.com/564x/b1/c9/f1/b1c9f168537c9bb7fd3063bb1bf4d501.jpg" alt="Hotel Image 1">
            <img src="https://i.pinimg.com/564x/3a/ac/07/3aac07ad8fb663787c0429bf163959b8.jpg" alt="Hotel Image 2">
        </div>
    </div>
    <%
                }
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    %>
</body>
</html>
