
package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookingDAO;

@WebServlet("/CancelBookingServlet")
public class CancelBookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (username == null || !"customer".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {

            int bookingId = Integer.parseInt(request.getParameter("id"));

            if (bookingId <= 0) {
                throw new NumberFormatException();
            }

            BookingDAO bookingDAO = new BookingDAO();

            boolean result = bookingDAO.cancelBooking(bookingId, username);

            if (result) {
                response.sendRedirect(request.getContextPath()
                        + "/customer/myBookings.jsp?cancel=success");
            } else {
                response.sendRedirect(request.getContextPath()
                        + "/customer/myBookings.jsp?cancel=failed");
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(request.getContextPath()
                    + "/customer/myBookings.jsp?cancel=failed");
        }
    }
}
