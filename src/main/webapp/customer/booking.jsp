<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="dao.ServiceDAO" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("customer")) {
        response.sendRedirect("../login.jsp");
        return;
    }


int providerId;
int serviceId;

try {
    providerId = Integer.parseInt(
        request.getParameter("provider")
    );

    serviceId = Integer.parseInt(
        request.getParameter("serviceId")
    );

    if (providerId <= 0 || serviceId <= 0) {
        response.sendRedirect("services.jsp");
        return;
    }

} catch (NumberFormatException e) {
    response.sendRedirect("services.jsp");
    return;
}

ServiceDAO serviceDAO = new ServiceDAO();

ResultSet rs = serviceDAO.getServiceWithProviderById(serviceId);

if (rs == null) {
    response.sendError(500, "Unable to load booking details.");
    return;
}

String providerName;
String serviceCategory;
String serviceName;

Statement stmt = null;
Connection con = null;

try {
    stmt = rs.getStatement();
    con = stmt.getConnection();

    if (!rs.next()) {
        response.sendError(404, "Service not found.");
        return;
    }

    // Check that the service belongs to the selected provider
    if (rs.getInt("provider_id") != providerId) {
        response.sendError(400, "Invalid provider and service combination.");
        return;
    }

    providerName = rs.getString("provider_name");
    serviceCategory = rs.getString("service_category");
    serviceName = rs.getString("service_name");

} finally {
    try { rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (con != null) con.close(); } catch (Exception e) {}
}

%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Book Service - ServiceBook</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="Style/booking.css">
</head>


<body>


<!-- Sidebar -->

<div class="sidebar">

    <div class="brand">

        <img src="../image/logo.jpeg" alt="ServiceBook Logo">

        <h3>ServiceBook</h3>

    </div>


    <div class="sidebar-menu">

        <a href="dashboard.jsp">
            <i class="bi bi-speedometer2"></i>
            Dashboard
        </a>

        <a href="services.jsp">
            <i class="bi bi-grid"></i>
            Services
        </a>

        <a href="myBookings.jsp" class="active">
            <i class="bi bi-calendar-check"></i>
            My Bookings
        </a>

        <a href="notifications.jsp">
            <i class="bi bi-bell"></i>
            Notifications
        </a>

        <a href="profile.jsp">
            <i class="bi bi-person"></i>
            Profile
        </a>

        <a href="../LogoutServlet">
            <i class="bi bi-box-arrow-right"></i>
            Logout
        </a>

    </div>

</div>


<!-- Main Content -->

<div class="main-content">


    <!-- Back -->

    <a href="providerDetails.jsp?provider=<%= providerId %>&amp;serviceId=<%= serviceId %>"
   class="back-link">

        <i class="bi bi-arrow-left"></i>
        Back to Provider

    </a>


    <div class="page-header">

        <h2>Book a Service</h2>

        <p>
            Fill in the details below to book your service.
        </p>

    </div>


    <div class="booking-card">


        <!-- Selected Provider -->

        <h5 class="section-title">
            Selected Provider
        </h5>


        <div class="provider-summary">

            <div class="provider-summary-content">

                <div class="provider-icon">
                    <i class="bi bi-person"></i>
                </div>

                <div>

                    <h5><%= providerName %></h5>

                    <p>
                        <%= serviceCategory %> Specialist
                    </p>

                </div>

            </div>

        </div>


        <!-- Booking Form -->

        <h5 class="section-title">
            Booking Details
        </h5>


        <form action="../BookingServlet" method="post">


            <!-- Service -->
             <input type="hidden"
           name="provider"
           value="<%= providerId %>">
           <input type="hidden"
       name="serviceId"
       value="<%= serviceId %>">

            <div class="mb-3">

                <label for="service" class="form-label">
                    Service
                </label>

                <input type="text"
			       id="service"
			       name="service"
			       class="form-control"
			       value="<%= serviceName %>"
			       readonly>

            </div>


            <!-- Date -->

            <div class="row">


                <div class="col-md-6 mb-3">

                    <label for="bookingDate" class="form-label">
                        Booking Date
                    </label>

                    <input type="date"
                           id="bookingDate"
                           name="bookingDate"
                           class="form-control"
                           required>

                </div>


                <!-- Time -->

                <div class="col-md-6 mb-3">

                    <label for="bookingTime" class="form-label">
                        Preferred Time
                    </label>

                    <select id="bookingTime"
                            name="bookingTime"
                            class="form-select"
                            required>

                        <option value="">
                            Select time
                        </option>

                        <option value="09:00 AM">
                            09:00 AM
                        </option>

                        <option value="11:00 AM">
                            11:00 AM
                        </option>

                        <option value="01:00 PM">
                            01:00 PM
                        </option>

                        <option value="03:00 PM">
                            03:00 PM
                        </option>

                        <option value="05:00 PM">
                            05:00 PM
                        </option>

                        <option value="07:00 PM">
                            07:00 PM
                        </option>

                    </select>

                </div>

            </div>


            <!-- Address -->

            <div class="mb-3">

                <label for="address" class="form-label">
                    Service Address
                </label>

                <textarea id="address"
                          name="address"
                          class="form-control"
                          placeholder="Enter the address where the service is required..."
                          required></textarea>

            </div>


            <!-- Additional Requirements -->

            <div class="mb-3">

                <label for="requirements" class="form-label">
                    Additional Requirements
                </label>

                <textarea id="requirements"
                          name="requirements"
                          class="form-control"
                          placeholder="Describe your problem or any additional requirements..."></textarea>

            </div>


            <!-- Book -->

            <button type="submit"
                    class="btn btn-primary w-100 booking-button">

                <i class="bi bi-calendar-check"></i>
                Book Service

            </button>


        </form>

    </div>

</div>


</body>

</html>