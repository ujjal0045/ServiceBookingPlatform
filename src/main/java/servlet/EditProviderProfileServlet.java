
package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.UserDAO;

@WebServlet("/EditProviderProfileServlet")
public class EditProviderProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Check provider login session
        HttpSession session = request.getSession(false);

        if (session == null ||
            !"provider".equals(session.getAttribute("role")) ||
            !(session.getAttribute("userId") instanceof Integer)) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int providerId = (Integer) session.getAttribute("userId");

        // Get updated provider information
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phno = request.getParameter("phno");
        String category = request.getParameter("category");
        String experienceStr = request.getParameter("experience");
        String location = request.getParameter("location");
        String skills = request.getParameter("skills");

        String profileUrl = request.getContextPath()
                          + "/provider/profile.jsp?update=";

        // Validate required fields
        if (name == null || name.trim().isEmpty() ||
            name.trim().length() > 100 ||
            email == null || email.trim().isEmpty() ||
            email.trim().length() > 254 ||
            !email.trim().matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$") ||
            phno == null || !phno.trim().matches("[0-9]{10}") ||
            category == null || category.trim().isEmpty() ||
            location == null || location.trim().isEmpty() ||
            skills == null || skills.trim().isEmpty()) {

            response.sendRedirect(profileUrl + "invalid");
            return;
        }

        // Validate experience
        int experience;

        try {
            experience = Integer.parseInt(experienceStr);

            if (experience < 0 || experience > 60) {
                response.sendRedirect(profileUrl + "invalid");
                return;
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(profileUrl + "invalid");
            return;
        }

        // Update provider profile
        UserDAO userDAO = new UserDAO();

        boolean result = userDAO.updateProviderProfile(
            providerId,
            name.trim(),
            email.trim(),
            phno.trim(),
            category.trim(),
            experience,
            location.trim(),
            skills.trim()
        );

        // Redirect with update status
        if (result) {
            response.sendRedirect(profileUrl + "success");
        } else {
            response.sendRedirect(profileUrl + "failed");
        }
    }
}
