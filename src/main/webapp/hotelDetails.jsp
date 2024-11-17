<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="DAO.ohrsDbUtil" %>
<%@ page import="model.Room" %>
<%@ page import="model.Hotel" %>
<%@ page import="model.DisplayMoreDetails" %>
<%@ page import="model.user" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/jpg" href="css/logo1.jpg">
    <title>Room Details - StayMaster</title>
    
    
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #FEFBF6;
            color: #2F3645;
        }

        .header {
            background-color: #2F3645;
            color: #FFFFFF;
            padding: 10px 20px;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .header-content img {
            width: 90px;
            height: 90px;
        }

        .header-nav {
            display: flex;
            gap: 20px;
        }

        .header-nav a {
            color: #FEFBF6;
            text-decoration: none;
        }

        .main-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .room-details {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .room-images {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .room-image {
            flex: 1;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
        }

        .room-info h2 {
            font-size: 28px;
            color: #2F3645;
            margin-bottom: 15px;
        }

        .room-info p {
            font-size: 16px;
            color: #B67352;
            margin-bottom: 10px;
            line-height: 1.6;
        }

        .price-info {
            margin-top: 20px;
            font-size: 18px;
        }

        .price-label {
            font-weight: bold;
            color: #2F3645;
        }

        .price-value {
            color: #ECB159;
            font-weight: bold;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-book {
            background-color: #98DED9;
            color: #2F3645;
        }

        .btn-back {
            background-color: #ECB159;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
        }

        .btn-book:hover {
            background-color: #7AC7C2;
        }

        .btn-back:hover {
            background-color: #D9A14D;
        }
        
        
            a {
    		text-decoration: none;
    		color: white;
			}
    </style>
</head>
<body>
    <%
        HttpSession session1 = request.getSession(false);
        if (session1 != null && session1.getAttribute("username") != null) {
            String username = (String) session1.getAttribute("username");
            List<user> uD = ohrsDbUtil.getUserDetails(username);
            pageContext.setAttribute("userDetails", uD);

            String roomIdParam = request.getParameter("roomId");
			String checkin =request.getParameter("checkin");
			String checkout = request.getParameter("checkout");
			String roomtype = request.getParameter("roomtype");
            
            if (roomIdParam != null && !roomIdParam.isEmpty()) {
                try {
                    int roomId = Integer.parseInt(roomIdParam);
                    List<DisplayMoreDetails> DMD = ohrsDbUtil.getMoreDetails(roomId);
                    
                    pageContext.setAttribute("roomDetails", DMD);
                    pageContext.setAttribute("roomId", roomId);
                    pageContext.setAttribute("checkin", checkin);
                    pageContext.setAttribute("checkout", checkout);
                    pageContext.setAttribute("roomtype", roomtype);
                } catch (NumberFormatException e) {
                    pageContext.setAttribute("error", "Invalid room ID provided.");
                }
            } else {
                pageContext.setAttribute("error", "No room ID provided.");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    %>

    <c:if test="${not empty userDetails}">
        <c:forEach var="u" items="${userDetails}">
            <header class="header">
                <div class="header-content">
                    <div class="imageContainer">
                        <img src="css/logo1.jpg" alt="StayMaster Logo">
                    </div>
                    <nav class="header-nav">
                        <a href="homePage.jsp">Home Page</a>
                        <a href="user.jsp">User Profile</a>
                        <a href="#">About Us</a>
                        <a href="#">FAQ</a>
                    </nav>
                    <div class="header-actions">
                        <h3>Welcome <a href="user.jsp">${u.name}</a>!</h3>
                    </div>
                </div>
            </header>

            <main class="main-content">
                <c:choose>
                    <c:when test="${not empty error}">
                        <p>${error}</p>
                    </c:when>
                    <c:when test="${not empty roomDetails}">
                        <c:forEach var="dm" items="${roomDetails}">
                            <div class="room-details">
                                <div class="room-images">
                                    <img src="${dm.hotelImage}" alt="Hotel Image" class="room-image">
                                    <img src="${dm.roomImage}" alt="Room Image" class="room-image">
                                </div>
                                <div class="room-info">
                                    <h2>${dm.hotelName}</h2>
                                    <p><strong>Location:</strong> ${dm.location}</p>
                                    <p><strong>Room Type:</strong> ${dm.roomType}</p>
                                    <p><strong>Facilities:</strong> ${dm.facilities}</p>
                                    <div class="price-info">
                                        <p><span class="price-label">Full Board:</span> <span class="price-value">LKR ${dm.fullBR}</span></p>
                                        <p><span class="price-label">Half Board:</span> <span class="price-value">LKR ${dm.halfBR}</span></p>
                                    </div>
                                </div>
                                <div class="button-group">
                                
                                
											    <c:url value="bookingInsert.jsp" var="booking">
											        <c:param name="roomId" value="${roomId}"/>
											        <c:param name="checkin" value="${checkin}"/>
											        <c:param name="checkout" value="${checkout}"/>
											        <c:param name="roomtype" value="${roomtype}"/>
											    </c:url>
							                
							                
                                    <a href="${booking }">
                                        <input type="button" class="btn btn-book" value="Book Now">
                                    </a>
                                    <a href="javascript:history.back()">
                                        <button class="btn btn-back">Go Back</button>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>No details found for this room.</p>
                    </c:otherwise>
                </c:choose>
            </main>
        </c:forEach>
    </c:if>
</body>
</html>