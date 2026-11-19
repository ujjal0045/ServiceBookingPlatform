<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("provider")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int providerId = (Integer) session.getAttribute("userId");

    String bookingId = request.getParameter("id");

    if (bookingId == null) {
        response.sendRedirect("bookings.jsp");
        return;
    }

    DBConnection db = new DBConnection();
    Connection con = db.getConn();

    String sql = "SELECT * FROM bookings "
               + "WHERE id = ? AND provider_id = ?";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setInt(1, Integer.parseInt(bookingId));
    ps.setInt(2, providerId);

    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
        response.sendRedirect("bookings.jsp");
        return;
    }

    String status = rs.getString("status");
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
	<%
    String update = request.getParameter("update");

    if ("success".equals(update)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill"></i>
        Booking status updated successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
    } else if ("failed".equals(update)) {
%>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-circle-fill"></i>
        Failed to update booking status.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
    }
%>
    <a href="bookings.jsp"
       class="btn btn-outline-secondary mb-4">

        <i class="bi bi-arrow-left"></i>
        Back to Bookings

    </a>


    <div class="card shadow-sm">

        <div class="card-body">

           
            <h2 class="mb-4">Booking Details</h2>


            <div class="row">

                <!-- Left Side -->

                <div class="col-md-6">

                    <p>
                        <strong>Booking ID:</strong>
                        #<%= rs.getInt("id") %>
                    </p>

                    <p>
                        <strong>Customer:</strong>
                        <%= rs.getString("customer_username") %>
                    </p>

                    <p>
                        <strong>Service:</strong>
                        <%= rs.getString("service") %>
                    </p>

                    <p>
                        <strong>Booking Date:</strong>
                        <%= rs.getDate("booking_date") %>
                    </p>

                </div>


                <!-- Right Side -->

                <div class="col-md-6">

                    <p>
                        <strong>Booking Time:</strong>
                        <%= rs.getString("booking_time") %>
                    </p>

                    <p>
                        <strong>Address:</strong><br>
                        <%= rs.getString("address") %>
                    </p>

                    <p>
                        <strong>Status:</strong>

                        <%
                            if (status.equals("Pending")) {
                        %>

                            <span class="badge bg-warning text-dark">
                                Pending
                            </span>

                        <%
                            } else if (status.equals("Accepted")) {
                        %>

                            <span class="badge bg-primary">
                                Accepted
                            </span>

                        <%
                            } else if (status.equals("Rejected")) {
                        %>

                            <span class="badge bg-danger">
                                Rejected
                            </span>

                        <%
                            } else if (status.equals("Completed")) {
                        %>

                            <span class="badge bg-success">
                                Completed
                            </span>

                        <%
                            } else if (status.equals("Cancelled")) {
                        %>

                            <span class="badge bg-secondary">
                                Cancelled
                            </span>

                        <%
                            }
                        %>

                    </p>


                    <!-- Pending Booking Actions -->

                    <%
                        if (status.equals("Pending")) {
                    %>

                        <div class="mt-4">

                            <!-- Accept -->

                            <form action="../UpdateBookingStatusServlet"
                                  method="post"
                                  class="d-inline">

                                <input type="hidden"
                                       name="id"
                                       value="<%= rs.getInt("id") %>">

                                <input type="hidden"
                                       name="status"
                                       value="Accepted">

                                <button type="submit"
                                        class="btn btn-success">

                                    <i class="bi bi-check-circle"></i>
                                    Accept Booking

                                </button>

                            </form>


                            <!-- Reject -->

                            <form action="../UpdateBookingStatusServlet"
                                  method="post"
                                  class="d-inline ms-2">

                                <input type="hidden"
                                       name="id"
                                       value="<%= rs.getInt("id") %>">

                                <input type="hidden"
                                       name="status"
                                       value="Rejected">

                                <button type="submit"
                                        class="btn btn-danger">

                                    <i class="bi bi-x-circle"></i>
                                    Reject Booking

                                </button>

                            </form>

                        </div>

                    <%
                        }
                    %>


                    <!-- Accepted Booking Action -->

                    <%
                        if (status.equals("Accepted")) {
                    %>

                        <div class="mt-4">

                            <form action="../UpdateBookingStatusServlet"
                                  method="post">

                                <input type="hidden"
                                       name="id"
                                       value="<%= rs.getInt("id") %>">

                                <input type="hidden"
                                       name="status"
                                       value="Completed">

                                <button type="submit"
                                        class="btn btn-success">

                                    <i class="bi bi-check-circle"></i>
                                    Mark as Completed

                                </button>

                            </form>

                        </div>

                    <%
                        }
                    %>

                </div>

            </div>


            <hr>


            <!-- Customer Requirements -->

            <h5>Customer Requirements</h5>

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

        </div>

    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>