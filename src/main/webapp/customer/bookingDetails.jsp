<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("customer")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    String bookingId = request.getParameter("id");

    if (bookingId == null) {
        response.sendRedirect("myBookings.jsp");
        return;
    }

    DBConnection db = new DBConnection();
    Connection con = db.getConn();

    String sql = "SELECT * FROM bookings "
               + "WHERE id = ? AND customer_username = ?";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setInt(1, Integer.parseInt(bookingId));
    ps.setString(2, username);

    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
        response.sendRedirect("myBookings.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Booking Details - ServiceBook</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

</head>

<body>

<div class="container py-5">

    <a href="myBookings.jsp" class="btn btn-outline-secondary mb-4">
        <i class="bi bi-arrow-left"></i>
        Back to My Bookings
    </a>

    <div class="card shadow-sm">

        <div class="card-body">

            <h2 class="mb-4">Booking Details</h2>

            <div class="row">

                <div class="col-md-6">

                    <p>
                        <strong>Booking ID:</strong>
                        #<%= rs.getInt("id") %>
                    </p>

                    <p>
                        <strong>Service:</strong>
                        <%= rs.getString("service") %>
                    </p>

                    <p>
                        <strong>Booking Date:</strong>
                        <%= rs.getDate("booking_date") %>
                    </p>

                    <p>
                        <strong>Booking Time:</strong>
                        <%= rs.getString("booking_time") %>
                    </p>

                </div>

                <div class="col-md-6">

                    <p>
                        <strong>Status:</strong>

                        <span class="badge bg-warning text-dark">
                            <%= rs.getString("status") %>
                        </span>
                    </p>

                    <p>
                        <strong>Provider ID:</strong>
                        <%= rs.getInt("provider_id") %>
                    </p>

                    <p>
                        <strong>Address:</strong><br>
                        <%= rs.getString("address") %>
                    </p>

                </div>

            </div>

            <hr>

            <h5>Requirements</h5>

            <p class="text-muted">

    <%
        String requirements = rs.getString("requirements");

        if (requirements != null && !requirements.trim().isEmpty()) {

            out.print(requirements);

        } else {

            out.print("No additional requirements provided.");

        }

    %>

</p>


<%
    String status = rs.getString("status");

    if (status.equals("Pending")) {
%>

    <hr>

    <form action="<%= request.getContextPath() %>/CancelBookingServlet"
      method="post"
      onsubmit="return confirm('Are you sure you want to cancel this booking?');">

    <input type="hidden" name="id" value="<%= bookingId %>">

    <button type="submit" class="btn btn-danger">
        <i class="bi bi-x-circle"></i> Cancel Booking
    </button>

</form>

<%
    }
%>

        </div>

    </div>

</div>

</body>
</html>