package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ServiceDAO;

@WebServlet("/AddServiceServlet")
public class AddServiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        Integer providerId = (Integer) session.getAttribute("userId");

        // Check provider
        if (role == null || !role.equals("provider") || providerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form data
        String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        String priceString = request.getParameter("price");

        // Convert price
        double price = Double.parseDouble(priceString);

        // Save service
        ServiceDAO serviceDAO = new ServiceDAO();

        boolean result = serviceDAO.addService(
                providerId,
                serviceName,
                description,
                price
        );

        // Redirect
        if (result) {
            response.sendRedirect("provider/dashboard.jsp");
        } else {
            response.getWriter().println("Failed to add service.");
        }
    }
}