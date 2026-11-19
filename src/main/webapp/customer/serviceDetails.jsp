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
    // Read the selected service ID
    int serviceId = -1;

    try {
        serviceId = Integer.parseInt(request.getParameter("id"));
    } catch (NumberFormatException e) {
        response.sendRedirect("services.jsp");
        return;
    }

    if (serviceId <= 0) {
        response.sendRedirect("services.jsp");
        return;
    }

    ServiceDAO serviceDAO = new ServiceDAO();
    ResultSet rs = serviceDAO.getServiceWithProviderById(serviceId);

    if (rs == null) {
        response.sendError(500, "Unable to load service details.");
        return;
    }

    if (!rs.next()) {
        Statement stmt = rs.getStatement();
        Connection con = stmt.getConnection();
        rs.close();
        stmt.close();
        con.close();

        response.sendError(404, "Service not found.");
        return;
    }

    String category = rs.getString("service_name");
    String description = rs.getString("description");
    double price = rs.getDouble("price");

    int providerId = rs.getInt("provider_id");
    String providerName = rs.getString("provider_name");
    int experience = rs.getInt("experience");
    String location = rs.getString("location");
    String skills = rs.getString("skills");
    String serviceCategory = rs.getString("service_category");

    // Close database resources after retrieving values
    Statement stmt = rs.getStatement();
    Connection con = stmt.getConnection();

    rs.close();
    stmt.close();
    con.close();
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title><%= category %> - ServiceBook</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="Style/serviceDetails.css">

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


    <!-- Back -->

    <a href="services.jsp" class="back-link">
        <i class="bi bi-arrow-left"></i>
        Back to Services
    </a>


    <!-- Header -->

    <div class="page-header">

        <h2><%= category %> Services</h2>

        <p>
            Choose a service provider according to your requirements.
        </p>

    </div>
	
<!-- Dynamic Provider -->

<div class="row g-4">

    <div class="col-md-6 col-lg-4">

        <div class="provider-card">

            <div class="provider-top">

                <div class="provider-icon">
                    <i class="bi bi-person"></i>
                </div>

                <div class="provider-name">

                    <h5>
                        <%= providerName %>
                    </h5>

                    <p>
                        <%= serviceCategory %> Specialist
                    </p>

                </div>

            </div>

            <div class="provider-info">

                <div>
                    <i class="bi bi-briefcase"></i>
                    <%= experience %> Years Experience
                </div>

                <div>
                    <i class="bi bi-geo-alt"></i>
                    <%= location %>
                </div>

                <div>
                    <i class="bi bi-tools"></i>
                    <%= skills %>
                </div>

                <div>
                    <i class="bi bi-currency-rupee"></i>
                    Starting at ₹<%= price %>
                </div>

            </div>

			<a href="providerDetails.jsp?provider=<%= providerId %>&serviceId=<%= serviceId %>"
			   class="btn btn-primary w-100">
			    <i class="bi bi-eye"></i>
			    View Provider
			</a>

        </div>

    </div>

</div>
	

    

</div>


</body>

</html>