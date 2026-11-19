
package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.BookingDAO;
import dao.NotificationDAO;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Check logged-in customer
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("username") == null ||
            !"customer".equals(session.getAttribute("role"))) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        String username =
            (String) session.getAttribute("username");

        // Get booking form data
        String providerIdString = request.getParameter("provider");
        String serviceIdString = request.getParameter("serviceId");
        String bookingDate = request.getParameter("bookingDate");
        String bookingTime = request.getParameter("bookingTime");
        String address = request.getParameter("address");
        String requirements = request.getParameter("requirements");

        int providerId;
        int serviceId;

        // Validate IDs
        try {
            providerId = Integer.parseInt(providerIdString);
            serviceId = Integer.parseInt(serviceIdString);

            if (providerId <= 0 || serviceId <= 0) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid provider or service ID");
                return;
            }

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid provider or service ID");
            return;
        }

        // Validate required booking fields
        if (bookingDate == null || bookingDate.trim().isEmpty()
                || bookingTime == null || bookingTime.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Please fill in all required booking details.");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();

        // Get actual active service from MySQL
        String service = bookingDAO.getActiveServiceName(
            serviceId,
            providerId
        );

        if (service == null) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "This service is unavailable or does not belong "
                + "to the selected provider.");
            return;
        }

        // Create booking and get generated booking ID
        int bookingId = bookingDAO.createBooking(
            username,
            providerId,
            service,
            bookingDate,
            bookingTime,
            address,
            requirements
        );

        if (bookingId > 0) {

            // Create notification for the provider
            NotificationDAO notificationDAO = new NotificationDAO();

            String message =
                "You have received a new booking (#"
                + bookingId
                + ") for "
                + service
                + ". Please review the booking.";

            boolean notificationSent =
                notificationDAO.addNotification(
                    providerId,
                    message,
                    bookingId
                );

            if (!notificationSent) {
                System.err.println(
                    "Failed to create provider notification for booking #"
                    + bookingId);
            }

            // Redirect customer to success page
            response.sendRedirect(
                request.getContextPath()
                + "/customer/bookingSuccess.jsp"
            );

        } else {

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Booking failed. Please try again."
            );
        }
    }
}
