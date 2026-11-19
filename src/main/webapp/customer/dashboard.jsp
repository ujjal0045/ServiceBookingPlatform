<%@ page import="dao.NotificationDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("customer")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Get logged-in customer ID
    Integer customerId = (Integer) session.getAttribute("userId");

    if (customerId == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Get unread notification count
    NotificationDAO notificationDAO = new NotificationDAO();

    int unreadCount = notificationDAO.getUnreadNotificationCount(customerId);
%>


<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Customer Dashboard - ServiceBook</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

	<link rel="stylesheet" href="Style/dashboard.css">
</head>

<body>

    <!-- Sidebar -->

    <div class="sidebar">

        <div class="brand">

            <img src="../image/logo.jpeg" alt="ServiceBook Logo">

            <h3>ServiceBook</h3>

        </div>


        <ul class="sidebar-menu">

            <li>
                <a href="dashboard.jsp" class="active">
                    <i class="bi bi-grid"></i>
                    Dashboard
                </a>
            </li>

            <li>
                <a href="services.jsp">
                    <i class="bi bi-tools"></i>
                    Services
                </a>
            </li>

            <li>
                <a href="myBookings.jsp">
                    <i class="bi bi-calendar-check"></i>
                    My Bookings
                </a>
            </li>

            <li>  
				<a href="notifications.jsp" class="notification-link">
				    <i class="bi bi-bell"></i>
				    Notifications
				
				    <% if (unreadCount > 0) { %>
				        <span class="notification-count">
				            <%= unreadCount %>
				        </span>
				    <% } %>
				</a>
            </li>

            <li>
                <a href="profile.jsp">
                    <i class="bi bi-person"></i>
                    Profile
                </a>
            </li>

            <li>
                <a href="../LogoutServlet">
                    <i class="bi bi-box-arrow-right"></i>
                    Logout
                </a>
            </li>

        </ul>

    </div>


    <!-- Main Content -->

    <div class="main-content">

        <!-- Topbar -->

        <div class="topbar">

            <div class="welcome">

                <h2>Welcome Back- <%= username %>!</h2>

                <p>Find the best services near you.</p>

            </div>

            <div class="profile">

                <span>Customer</span>

                <i class="bi bi-person-circle"></i>

            </div>

        </div>


        <!-- Search -->

        <div class="search-box">

            <h4>What service do you need?</h4>

            <div class="input-group">

                <input type="text"
                       class="form-control"
                       placeholder="Search for a service...">

                <button class="btn btn-primary">

                    <i class="bi bi-search"></i>
                    Search

                </button>

            </div>

        </div>


        <!-- Popular Services -->

        <h4 class="mb-3">Popular Services</h4>

        <div class="row g-4">

            <div class="col-md-3">

                <div class="service-card">

                    <i class="bi bi-house"></i>

                    <h5>Home Cleaning</h5>

                    <p>Professional home cleaning services</p>

                </div>

            </div>


            <div class="col-md-3">

                <div class="service-card">

                    <i class="bi bi-lightning"></i>

                    <h5>Electrician</h5>

                    <p>Find trusted electricians</p>

                </div>

            </div>


            <div class="col-md-3">

                <div class="service-card">

                    <i class="bi bi-droplet"></i>

                    <h5>Plumber</h5>

                    <p>Reliable plumbing services</p>

                </div>

            </div>


            <div class="col-md-3">

                <div class="service-card">

                    <i class="bi bi-wrench"></i>

                    <h5>AC Repair</h5>

                    <p>Professional AC repair</p>

                </div>

            </div>

        </div>


        <!-- Recent Booking -->

        <h4 class="mt-5 mb-3">Recent Booking</h4>

        <div class="booking-card">

            <div class="d-flex justify-content-between align-items-center">

                <div>

                    <h5>Home Cleaning</h5>

                    <p class="mb-1">
                        Service Provider: Rahul Sharma
                    </p>

                    <small class="text-muted">
                        Booking Date: 10 September 2026
                    </small>

                </div>

                <span class="booking-status">
                    Confirmed
                </span>

            </div>

        </div>

    </div>


    <!-- Bootstrap JS -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>