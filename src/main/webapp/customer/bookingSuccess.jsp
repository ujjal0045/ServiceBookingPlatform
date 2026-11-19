<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("customer")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Booking Successful - ServiceBook</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

</head>

<body>

<div class="container d-flex justify-content-center align-items-center"
     style="min-height: 100vh;">

    <div class="text-center">

        <i class="bi bi-check-circle-fill text-success"
           style="font-size: 70px;"></i>

        <h2 class="mt-3">Booking Successful!</h2>

        <p class="text-muted">
            Your service booking has been placed successfully.
        </p>

        <a href="myBookings.jsp" class="btn btn-primary">
            <i class="bi bi-calendar-check"></i>
            View My Bookings
        </a>

        <a href="services.jsp" class="btn btn-outline-secondary ms-2">
            Book Another Service
        </a>

    </div>

</div>

</body>
</html>