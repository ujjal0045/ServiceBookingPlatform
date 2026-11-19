<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="dao.BookingDAO" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("customer")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    BookingDAO bookingDAO = new BookingDAO();
    ResultSet rs = bookingDAO.getBookingsByCustomer(username);
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>My Bookings - ServiceBook</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

</head>

<body>

<div class="container py-5">
	<%
    String cancel = request.getParameter("cancel");

    if ("success".equals(cancel)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill"></i>
        Booking cancelled successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
    } else if ("failed".equals(cancel)) {
%>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-circle-fill"></i>
        Unable to cancel booking. It may already be cancelled or cannot be cancelled.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
    }
%>

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>
            <h2>My Bookings</h2>
            <p class="text-muted">
                View all your service bookings
            </p>
        </div>

        <a href="services.jsp" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i>
            Book New Service
        </a>

    </div>


    <%
        boolean hasBooking = false;

        while (rs.next()) {

            hasBooking = true;
    %>

        <div class="card mb-3 shadow-sm">

            <div class="card-body">

                <div class="row align-items-center">

                    <div class="col-md-4">

                        <h5>
                            <%= rs.getString("service") %>
                        </h5>

                        <p class="text-muted mb-0">
                            Booking ID:
                            #<%= rs.getInt("id") %>
                        </p>

                    </div>


                    <div class="col-md-3">

                        <p class="mb-1">
                            <i class="bi bi-calendar"></i>
                            <%= rs.getDate("booking_date") %>
                        </p>

                        <p class="mb-0">
                            <i class="bi bi-clock"></i>
                            <%= rs.getString("booking_time") %>
                        </p>

                    </div>


                    <div class="col-md-3">

                        <span class="badge bg-warning text-dark">
                            <%= rs.getString("status") %>
                        </span>

                    </div>


                    <div class="col-md-2 text-md-end">

                        <a href="bookingDetails.jsp?id=<%= rs.getInt("id") %>"
                           class="btn btn-outline-primary btn-sm">
                            View Details
                        </a>

                    </div>

                </div>

            </div>

        </div>

    <%
        }

        if (!hasBooking) {
    %>

        <div class="text-center py-5">

            <i class="bi bi-calendar-x"
               style="font-size: 60px;"></i>

            <h4 class="mt-3">No Bookings Yet</h4>

            <p class="text-muted">
                You haven't booked any service yet.
            </p>

            <a href="services.jsp" class="btn btn-primary">
                Explore Services
            </a>

        </div>

    <%
        }
    %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</div>

</body>
</html>