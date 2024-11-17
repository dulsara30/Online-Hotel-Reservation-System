<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/jpg" href="css/logo1.jpg">
    <title>Modify Your Booking</title>
    
    <style>
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
    <script>
        // Function to clear the form fields
        function clearForm() {
            document.getElementById("updateForm").reset();
        }
    </script>
</head>
<body>

	<%
	
	HttpSession session1 = request.getSession(false);
    if (session1 != null && session1.getAttribute("username") != null) {
        String username = (String) session1.getAttribute("username");
        
	 //String bId = request.getParameter("bookId");
	 String bookId = request.getParameter("bookId");
	 String name = request.getParameter("name");
	 String email = request.getParameter("email");
	 String checkin = request.getParameter("checkin");
	 String checkout = request.getParameter("checkout");
	 String roomtype = request.getParameter("roomtype");
	 String guests = request.getParameter("guests");
	 String board = request.getParameter("board");
	 String note = request.getParameter("note");
	 String contact = request.getParameter("contact");
	 String payment = request.getParameter("payment");
	%>

<div class="form-wrapper">
    <div class="form-section">
        <h1>Modify Your Booking</h1>
        <form action="bookingUpdateServlet" method="POST" id="updateForm">
            <div class="form-group">
              
				<input type = "hidden" name="bookId" value="<%= bookId %>" readonly>              
              
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" value ="<%= name %>">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" value = "<%= email %>">
            </div>

            <div class="form-group">
                <label for="checkin">Check-in Date:</label>
                <input type="date" id="checkin" name="checkin" value=<%= checkin %>>
            </div>

            <div class="form-group">
                <label for="checkout">Check-out Date:</label>
                <input type="date" id="checkout" name="checkout" value =<%= checkout %>>
            </div>

            <div class="form-group">
                <label for="roomtype">Room Type:</label>
                <select id="roomtype" name="roomtype" required>
                    <option value="" disabled selected>Select room type</option>
                    <option value="single" <%= "single".equals(roomtype) ? "selected" : "" %>>Single</option>
                    <option value="double" <%= "double".equals(roomtype) ? "selected" : "" %>>Double</option>
                    <option value="suite" <%= "suite".equals(roomtype) ? "selected" : "" %>>Suite</option>
                    <option value="deluxe" <%= "deluxe".equals(roomtype) ? "selected" : "" %>>Deluxe</option>
                </select>
            </div>

            <div class="form-group">
                <label for="guests">Number of Guests:</label>
                <input type="number" id="guests" name="guests" min="1" max="5" value ="<%= guests %>">
            </div>

            <div class="form-group">
                <label for="board">Board Type:</label>
                <select id="board" name="board">
                    <option value="" disabled selected>Select board type</option>
                    <option value="full" <%= "full".equals(board) ? "selected" : "" %>>Full</option>
                    <option value="half" <%= "half".equals(board) ? "selected" : "" %>>Half</option>
                </select>
            </div>

            <div class="form-group">
                <label for="note">Additional Notes:</label>
                <textarea id="note" name="note" rows="4" placeholder=<%= note%>></textarea>
            </div>

            <div class="form-group">
                <label for="contact">Contact Number:</label>
                <input type="tel" id="contact" name="contact" maxlength="10" pattern="[0-9]{1,10}"  value="<%= contact %>">
            </div>

            <div class="form-group">
                <label for="payment">Payment Method:</label>
                <select id="payment" name="payment" required>
                    <option value="creditcard" <%= "creditcard".equals(payment) ? "selected" : "" %>>Credit Card</option>
                    <option value="debitcard" <%= "debitcard".equals(payment) ? "selected" : "" %>>Debit Card</option>
                    <option value="paypal" <%= "paypal".equals(payment) ? "selected" : "" %>>PayPal</option>
                    <option value="cash" <%= "cash".equals(payment) ? "selected" : "" %>>Cash</option>
                </select>
            </div>

            <div class="form-group">
                <button type="submit" class="button-link">Save Changes</button>
                <button type="button" id="clearButton" class="button-link" onclick="clearForm()">Clear</button>
            </div>
        </form>
    </div>

    <div class="image-section">
        
 <img src="https://i.pinimg.com/564x/b1/c9/f1/b1c9f168537c9bb7fd3063bb1bf4d501.jpg" alt="Hotel Image 1">
            <img src="https://i.pinimg.com/564x/3a/ac/07/3aac07ad8fb663787c0429bf163959b8.jpg" alt="Hotel Image 2">
        
    </div>
</div>
<%
    } else {
        response.sendRedirect("login.jsp");
    }

%>
</body>
</html>
