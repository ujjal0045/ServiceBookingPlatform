package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        String role = userDAO.loginUser(username, password);

        if (role != null) {
        	
        		HttpSession session = request.getSession();

            int userId = userDAO.getUserId(username);

            session.setAttribute("username", username);
            session.setAttribute("role", role);
            session.setAttribute("userId", userId);

            if (role.equals("customer")) {

                response.sendRedirect("customer/dashboard.jsp");

            } else if (role.equals("provider")) {

            		response.sendRedirect("provider/dashboard.jsp");

            }

        } else {

            response.getWriter().println("Invalid username or password!");

        }
    }
}