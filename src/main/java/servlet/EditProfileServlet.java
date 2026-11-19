
package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check logged-in customer
        HttpSession session = request.getSession(false);

        if (session == null ||
            !"customer".equals(session.getAttribute("role")) ||
            !(session.getAttribute("userId") instanceof Integer)) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int customerId = (Integer) session.getAttribute("userId");

        // Get updated profile details
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phno = request.getParameter("phno");

        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phno == null || !phno.matches("[0-9]{10}")) {

            response.sendRedirect(
                request.getContextPath()
                + "/customer/profile.jsp?update=invalid");
            return;
        }

        // Update customer profile
        UserDAO userDAO = new UserDAO();

        boolean result = userDAO.updateCustomerProfile(
            customerId,
            name.trim(),
            email.trim(),
            phno
        );

        if (result) {
            response.sendRedirect(
                request.getContextPath()
                + "/customer/profile.jsp?update=success");
        } else {
            response.sendRedirect(
                request.getContextPath()
                + "/customer/profile.jsp?update=failed");
        }
    }
}
