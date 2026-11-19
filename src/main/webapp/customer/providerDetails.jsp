
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="dao.UserDAO" %>

<%!
    private String escapeHtml(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || !"customer".equals(role)) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int providerId;
    int serviceId = -1;

    try {
        providerId = Integer.parseInt(request.getParameter("provider"));

        if (providerId <= 0) {
            response.sendRedirect("services.jsp");
            return;
        }

        String serviceParam = request.getParameter("serviceId");

        if (serviceParam != null && !serviceParam.trim().isEmpty()) {
            serviceId = Integer.parseInt(serviceParam);
            if (serviceId <= 0) {
                response.sendRedirect("services.jsp");
                return;
            }
        }

    } catch (NumberFormatException e) {
        response.sendRedirect("services.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    ResultSet rs = userDAO.getProviderById(providerId);

    if (rs == null) {
        response.sendError(500, "Unable to load provider details.");
        return;
    }

    String providerName;
    String serviceCategory;
    String location;
    int experience;
    String phone;
    String skills;

    Statement stmt = null;
    Connection con = null;

    try {
        stmt = rs.getStatement();
        con = stmt.getConnection();

        if (!rs.next()) {
            response.sendError(404, "Provider not found.");
            return;
        }

        providerName = rs.getString("name");
        serviceCategory = rs.getString("service_category");
        location = rs.getString("location");
        experience = rs.getInt("experience");
        phone = rs.getString("phno");
        skills = rs.getString("skills");

    } finally {
        try { rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }

    String backUrl = serviceId > 0
        ? "serviceDetails.jsp?id=" + serviceId
        : "services.jsp";

    String bookingUrl = "booking.jsp?provider=" + providerId;

    if (serviceId > 0) {
        bookingUrl += "&serviceId=" + serviceId;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Provider Details - ServiceBook</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="Style/providerDetails.css">
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

        <a href="services.jsp" class="active">
            <i class="bi bi-grid"></i>
            Services
        </a>

        <a href="myBookings.jsp">
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

    <a href="<%= backUrl %>" class="back-link">
        <i class="bi bi-arrow-left"></i>
        Back to Providers
    </a>

    <div class="row g-4">

        <!-- Provider Details -->
        <div class="col-lg-8">

            <div class="provider-profile">

                <!-- Profile Header -->
                <div class="profile-header">

                    <div class="profile-icon">
                        <i class="bi bi-person"></i>
                    </div>

                    <div>
                        <h2><%= escapeHtml(providerName) %></h2>

                        <p>
                            <%= escapeHtml(serviceCategory) %> Specialist
                        </p>
                    </div>

                </div>

                <!-- Provider Information -->
                <h5 class="info-title">
                    Provider Information
                </h5>

                <div class="row">

                    <!-- Experience -->
                    <div class="col-md-6">
                        <div class="info-item">

                            <div class="info-icon">
                                <i class="bi bi-briefcase"></i>
                            </div>

                            <div>
                                <h6>Experience</h6>
                                <p><%= experience %> Years</p>
                            </div>

                        </div>
                    </div>

                    <!-- Location -->
                    <div class="col-md-6">
                        <div class="info-item">

                            <div class="info-icon">
                                <i class="bi bi-geo-alt"></i>
                            </div>

                            <div>
                                <h6>Location</h6>
                                <p><%= escapeHtml(location) %></p>
                            </div>

                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="col-md-6">
                        <div class="info-item">

                            <div class="info-icon">
                                <i class="bi bi-telephone"></i>
                            </div>

                            <div>
                                <h6>Phone</h6>
                                <p><%= escapeHtml(phone) %></p>
                            </div>

                        </div>
                    </div>

                    <!-- Service Category -->
                    <div class="col-md-6">
                        <div class="info-item">

                            <div class="info-icon">
                                <i class="bi bi-tools"></i>
                            </div>

                            <div>
                                <h6>Service Category</h6>
                                <p><%= escapeHtml(serviceCategory) %></p>
                            </div>

                        </div>
                    </div>

                </div>

                <!-- Skills -->
                <h5 class="mt-3 mb-3">Skills</h5>

                <div>
                    <%
                        if (skills != null && !skills.trim().isEmpty()) {

                            String[] skillList = skills.split(",");

                            for (String skill : skillList) {
                                if (!skill.trim().isEmpty()) {
                    %>

                        <span class="skill-badge">
                            <%= escapeHtml(skill.trim()) %>
                        </span>

                    <%
                                }
                            }

                        } else {
                    %>

                        <p class="text-muted">
                            No skills added yet.
                        </p>

                    <%
                        }
                    %>
                </div>

            </div>
        </div>

        <!-- Booking Box -->
        <div class="col-lg-4">

            <div class="booking-box">

                <h4 class="mb-3">
                    Book This Provider
                </h4>

                <p class="text-muted">
                    Need a service? Book this provider and
                    get your work done easily.
                </p>

                <hr>

                <div class="d-flex justify-content-between mb-3">
                    <span>Provider</span>
                    <strong><%= escapeHtml(providerName) %></strong>
                </div>

                <div class="d-flex justify-content-between mb-3">
                    <span>Specialization</span>
                    <strong><%= escapeHtml(serviceCategory) %></strong>
                </div>

                <div class="d-flex justify-content-between mb-4">
                    <span>Experience</span>
                    <strong><%= experience %> Years</strong>
                </div>

                <a href="<%= bookingUrl %>"
                   class="btn btn-primary w-100">

                    <i class="bi bi-calendar-check"></i>
                    Book Now
                </a>

            </div>
        </div>

    </div>
</div>

</body>
</html>
