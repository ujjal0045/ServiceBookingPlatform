<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dao.ServiceDAO" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("customer")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<%
    ServiceDAO serviceDAO = new ServiceDAO();
    ResultSet rs = serviceDAO.getAllActiveServices();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Services - ServiceBook</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="Style/services.css">

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

    <div class="page-header">

        <h2>Services</h2>

        <p>
            Find the right service for your needs.
        </p>

    </div>


    <!-- Search -->

    <div class="search-box">

        <div class="input-group">

            <span class="input-group-text">
                <i class="bi bi-search"></i>
            </span>

            <input type="text"
                   class="form-control"
                   placeholder="Search for a service...">

            <button class="btn btn-primary">
                Search
            </button>

        </div>

    </div>


    <!-- Services -->
<div class="row g-4">

    <%
        boolean hasServices = false;

        while (rs.next()) {
            hasServices = true;
    %>

    <div class="col-md-6 col-lg-4">

        <div class="service-card">

            <div class="service-icon">
                <i class="bi bi-tools"></i>
            </div>

            <h5>
                <%= rs.getString("service_name") %>
            </h5>

            <p>
                <%= rs.getString("description") %>
            </p>

            <h5 class="text-primary">
                ₹<%= rs.getDouble("price") %>
            </h5>

            <a href="serviceDetails.jsp?id=<%= rs.getInt("id") %>"
               class="btn btn-outline-primary">

                <i class="bi bi-eye"></i>
                View Details

            </a>

        </div>

    </div>

    <%
        }

        if (!hasServices) {
    %>

        <div class="col-12 text-center py-5">

            <i class="bi bi-tools" style="font-size: 50px;"></i>

            <h4 class="mt-3">No Services Available</h4>

            <p class="text-muted">
                Currently, no active services are available.
            </p>

        </div>

    <%
        }

        if (rs != null) {
            rs.close();
        }
    %>

</div>

</div>

</body>
</html>