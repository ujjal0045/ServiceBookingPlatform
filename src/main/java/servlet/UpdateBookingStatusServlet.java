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

@WebServlet("/UpdateBookingStatusServlet")
public class UpdateBookingStatusServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);

    if (session == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String role = (String) session.getAttribute("role");
    Integer providerId = (Integer) session.getAttribute("userId");

    if (!"provider".equals(role) || providerId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String bookingIdString = request.getParameter("id");
    String status = request.getParameter("status");

    int bookingId;

    try {
        bookingId = Integer.parseInt(bookingIdString);

        if (bookingId <= 0) {
            throw new NumberFormatException();
        }

    } catch (NumberFormatException e) {
        response.sendRedirect(request.getContextPath()
                + "/provider/bookings.jsp?update=failed");
        return;
    }

    BookingDAO bookingDAO = new BookingDAO();

    boolean result = bookingDAO.updateBookingStatus(
            bookingId, providerId, status
    );


if (result) {

    // Find the customer who made this booking
    Integer customerId = bookingDAO.getCustomerIdByBookingId(
            bookingId, providerId
    );

    if (customerId != null) {

        String message = "";

        if ("Accepted".equals(status)) {
            message = "Your booking #" + bookingId
                    + " has been accepted by the provider.";

        } else if ("Rejected".equals(status)) {
            message = "Your booking #" + bookingId
                    + " has been rejected by the provider.";

        } else if ("Completed".equals(status)) {
            message = "Your booking #" + bookingId
                    + " has been marked as completed.";
        }

        if (!message.isEmpty()) {

            NotificationDAO notificationDAO = new NotificationDAO();

            notificationDAO.addNotification(
                    customerId,
                    message,
                    bookingId
            );
        }
    }

    response.sendRedirect(request.getContextPath()
            + "/provider/bookingDetails.jsp?id=" + bookingId
            + "&update=success");

} else {

    response.sendRedirect(request.getContextPath()
            + "/provider/bookingDetails.jsp?id=" + bookingId
            + "&update=failed");
}

}
}
