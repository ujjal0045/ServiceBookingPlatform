package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String name = request.getParameter("name");
    	String username = request.getParameter("username");
    	String email = request.getParameter("email");
    	String phno = request.getParameter("phone");
    	String role = request.getParameter("role");
    	String serviceCategory = request.getParameter("serviceCategory");
    	String experience = request.getParameter("experience");
    	String location = request.getParameter("location");
    	String skills = request.getParameter("skills");
    	String password = request.getParameter("password");
    	
    	UserDAO userDAO = new UserDAO();
    	
    	int exp = 0;

    	if (experience != null && !experience.isEmpty()) {
    	    exp = Integer.parseInt(experience);
    	}

    	boolean result = userDAO.registerUser(
    	        name,
    	        username,
    	        email,
    	        phno,
    	        role,
    	        serviceCategory,
    	        exp,
    	        location,
    	        skills,
    	        password
    	);
    	
    	if (result) {
    	    response.getWriter().println("Registration successful!");
    	} else {
    	    response.getWriter().println("Registration failed!");
    	}
    	
    }
}