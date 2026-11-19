<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="dao.BookingDAO" %>
    <%@ page import="dao.ServiceDAO" %>
    <%@ page import="java.sql.*" %>
    <%@ page import="dao.NotificationDAO" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("provider")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int providerId = (Integer) session.getAttribute("userId");
    BookingDAO bookingDAO = new BookingDAO();

    int totalBookings = bookingDAO.getBookingCountByProvider(providerId);
    
    int pendingBookings = bookingDAO.getPendingBookingCountByProvider(providerId);
    
    int completedBookings = bookingDAO.getCompletedBookingCountByProvider(providerId);
    
    ResultSet latestBooking = bookingDAO.getLatestBookingByProvider(providerId);
    
    ServiceDAO serviceDAO = new ServiceDAO();

    int activeServices = serviceDAO.getActiveServiceCount(providerId);
    
    NotificationDAO notificationDAO = new NotificationDAO();

    int unreadNotifications =
        notificationDAO.getUnreadNotificationCount(providerId);
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Provider Dashboard - ServiceBook</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

	<link rel="stylesheet" href="styles/dashboard.css">

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
                <a href="myServices.jsp">
                    <i class="bi bi-tools"></i>
                    My Services
                </a>
            </li>

            <li>
                <a href="bookings.jsp">
                    <i class="bi bi-calendar-check"></i>
                    Bookings
                </a>
            </li>

            <li>
                <a href="availability.jsp">
                    <i class="bi bi-clock"></i>
                    Availability
                </a>
            </li>

            <li>
                <a href="earnings.jsp">
                    <i class="bi bi-currency-rupee"></i>
                    Earnings
                </a>
            </li>

            

			<li>
			    <a href="notifications.jsp" class="notification-menu-link">
			
			        <i class="bi bi-bell"></i>
			
			        <span class="notification-label">
			            Notifications
			        </span>
			
			        <% if (unreadNotifications > 0) { %>
			            <span class="notification-count">
			                <%= unreadNotifications > 99 ? "99+" : unreadNotifications %>
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
                <a href="../index.jsp">
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

                <h2>Welcome Back, <%= username %>!</h2>

                <p>Manage your services and bookings.</p>

            </div>

            <div class="profile">

                <span>Service Provider</span>

                <i class="bi bi-person-circle"></i>

            </div>

        </div>


        <!-- Statistics -->

        <div class="row g-4">

            <div class="col-md-6 col-lg">
			    <div class="stat-card">
			        <i class="bi bi-check-circle"></i>
			        <h3><%= completedBookings %></h3>
			        <p>Completed Bookings</p>
			    </div>
			</div>


            <div class="col-md-6 col-lg">

                <div class="stat-card">

                    <i class="bi bi-calendar-check"></i>

                    <h3><%= totalBookings %></h3>

                    <p>Total Bookings</p>

                </div>

            </div>


            <div class="col-md-6 col-lg">

                <div class="stat-card">

                    <i class="bi bi-hourglass-split"></i>

                    <h3><%= pendingBookings %></h3>

                    <p>Pending Bookings</p>

                </div>

            </div>
            
            <div class="col-md-6 col-lg">
			    <div class="stat-card">
			
			        <i class="bi bi-tools"></i>
			
			        <h3><%= activeServices %></h3>
			
			        <p>Active Services</p>
			
			    </div>
			</div>


            <div class="col-md-6 col-lg">

                <div class="stat-card">

                    <i class="bi bi-currency-rupee"></i>

                    <h3>₹8,500</h3>

                    <p>Total Earnings</p>

                </div>

            </div>

        </div>


        <!-- Recent Bookings -->

        <h4 class="mt-5 mb-3">Recent Bookings</h4>

  <%
    if (latestBooking.next()) {
%>

<div class="booking-card">

    <div class="booking-info">

        <div class="booking-icon">
            <i class="bi bi-tools"></i>
        </div>

        <div>

            <h3>
                <%= latestBooking.getString("service") %>
            </h3>

            <p>
                <i class="bi bi-person"></i>
                Customer:
                <strong>
                    <%= latestBooking.getString("customer_username") %>
                </strong>
            </p>

            <p>
                <i class="bi bi-calendar3"></i>
                Booking Date:
                <%= latestBooking.getDate("booking_date") %>
            </p>

        </div>

    </div>

    <div class="booking-status">

        <span class="status-badge">
            <%= latestBooking.getString("status") %>
        </span>

    </div>

</div>

<%
    } else {
%>

<div class="booking-card">

    <div class="booking-info">

        <div class="booking-icon">
            <i class="bi bi-calendar-x"></i>
        </div>

        <div>

            <h3>No Bookings Yet</h3>

            <p>
                No customer booking has been received yet.
            </p>

        </div>

    </div>

</div>

<%
    }
%>


    <!-- Bootstrap JS -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>