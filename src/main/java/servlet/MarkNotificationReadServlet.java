
package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.NotificationDAO;

@WebServlet("/MarkNotificationReadServlet")
public class MarkNotificationReadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String role = (String) session.getAttribute("role");
        Integer userId = (Integer) session.getAttribute("userId");

        // Allow both customer and provider
        if (userId == null ||
            (!"customer".equals(role) &&
             !"provider".equals(role))) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // Redirect to the correct role's notification page
        String redirectPath = "provider".equals(role)
                ? "/provider/notifications.jsp"
                : "/customer/notifications.jsp";

        try {

            int notificationId = Integer.parseInt(
                request.getParameter("id")
            );

            if (notificationId <= 0) {
                throw new NumberFormatException();
            }

            NotificationDAO notificationDAO = new NotificationDAO();

            boolean result = notificationDAO.markAsRead(
                notificationId,
                userId
            );

            String message = result ? "success" : "failed";

            response.sendRedirect(
                request.getContextPath()
                + redirectPath
                + "?read=" + message
            );

        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath()
                + redirectPath
                + "?read=failed"
            );
        }
    }
}
