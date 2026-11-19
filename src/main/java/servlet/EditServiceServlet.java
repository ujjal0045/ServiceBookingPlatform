
package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ServiceDAO;

@WebServlet("/EditServiceServlet")
public class EditServiceServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        Integer providerId = (Integer) session.getAttribute("userId");

        if (role == null || !role.equals("provider")
                || providerId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int serviceId = Integer.parseInt(
                    request.getParameter("serviceId"));

            String serviceName = request.getParameter("serviceName");
            String description = request.getParameter("description");

            double price = Double.parseDouble(
                    request.getParameter("price"));

            if (serviceId <= 0 || serviceName == null
                    || serviceName.trim().isEmpty()
                    || !Double.isFinite(price) || price <= 0) {

                response.sendRedirect(
                    request.getContextPath() + "/provider/myServices.jsp?updated=failed");
                return;
            }

            ServiceDAO serviceDAO = new ServiceDAO();

            boolean result = serviceDAO.updateService(
                    serviceId,
                    providerId,
                    serviceName.trim(),
                    description,
                    price
            );

            if (result) {
                response.sendRedirect(
                    request.getContextPath() + "/provider/myServices.jsp?updated=success");
            } else {
                response.sendRedirect(
                    request.getContextPath() + "/provider/myServices.jsp?updated=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("provider/myServices.jsp");
        }
    }
}
