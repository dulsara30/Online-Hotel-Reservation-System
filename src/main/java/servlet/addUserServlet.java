package servlet;

import java.io.IOException;
//import java.util.List;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ohrsDbUtil;


@WebServlet("/addUserServlet")
public class addUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String contactnumber = request.getParameter("contactnumber");
		String birthdate = request.getParameter("birthdate");
		String password = request.getParameter("password");
		
		
		
				
				
				
				try {
					
					
		            int emailCount = ohrsDbUtil.checkEmailExists(email); // Call the static method directly

		            if (emailCount > 0) {
		                
		                request.setAttribute("errorMessage", "Email already exists!");
		                RequestDispatcher rd = request.getRequestDispatcher("userRegister.jsp");
		                
		                rd.forward(request, response);
		                
		            } else {

		        		boolean isTrue = ohrsDbUtil.userRegister(name, email, address, contactnumber, birthdate, password);
		        		
		        		if(isTrue == true) {
		        			
		        			
		        			RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
		        			dis.forward(request, response);
		        		}
		        		
		        		else {
		        			RequestDispatcher dis1 = request.getRequestDispatcher("success/unsuccess.jsp");
		        			dis1.forward(request, response);
		        		}
		        		
		            }
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		
		

		
		
	}

}