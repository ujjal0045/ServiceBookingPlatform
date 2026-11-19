<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="dao.ServiceDAO" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("provider")) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Integer providerId = (Integer) session.getAttribute("userId");

    if (providerId == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    ServiceDAO serviceDAO = new ServiceDAO();

    ResultSet rs = serviceDAO.getServicesByProvider(providerId);
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>My Services - ServiceBook</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <link rel="stylesheet"
          href="../Styles/addService.css">
    <link rel="stylesheet" href="../styles/myServices.css">

</head>

<body>

<div class="container py-5">

	<%
    String updated = request.getParameter("updated");

    if ("success".equals(updated)) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill"></i>
        Service updated successfully!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
    } else if ("failed".equals(updated)) {
%>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-circle-fill"></i>
        Failed to update service. Please try again.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
    }
%>

    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

            <h2>
                <i class="bi bi-tools"></i>
                My Services
            </h2>

            <p class="text-muted mb-0">
                Manage the services you provide.
            </p>

        </div>

        <a href="addService.jsp"
           class="btn btn-primary">

            <i class="bi bi-plus-circle"></i>
            Add Service

        </a>

    </div>


    <div class="row g-4">

        <%
            boolean hasServices = false;

            while (rs.next()) {

                hasServices = true;
        %>

        <div class="col-md-6 col-lg-4">

            <div class="card shadow-sm h-100">

                <div class="card-body">

                    <div class="d-flex justify-content-between align-items-start">

                        <h5 class="card-title">
                            <%= rs.getString("service_name") %>
                        </h5>

                        <span class="badge bg-success">
                            <%= rs.getString("status") %>
                        </span>

                    </div>

                    <p class="card-text text-muted mt-3">
                        <%= rs.getString("description") %>
                    </p>

                    <h5 class="text-primary">
                        ₹<%= rs.getDouble("price") %>
                    </h5>
					<div class="mt-3">
    <a href="editService.jsp?id=<%= rs.getInt("id") %>"
       class="btn btn-primary">
        <i class="bi bi-pencil-square"></i> Edit
    </a>
</div>

                </div>

            </div>

        </div>

        <%
            }

            if (!hasServices) {
        %>

        <div class="col-12">

            <div class="text-center py-5">

                <i class="bi bi-tools"
                   style="font-size: 50px;"></i>

                <h4 class="mt-3">
                    No Services Added Yet
                </h4>

                <p class="text-muted">
                    Add your first service to start offering your services.
                </p>

                <a href="addService.jsp"
                   class="btn btn-primary">

                    <i class="bi bi-plus-circle"></i>
                    Add Your First Service

                </a>

            </div>

        </div>

        <%
            }
        %>

    </div>


    <div class="mt-4">

        <a href="dashboard.jsp"
           class="btn btn-outline-secondary">

            <i class="bi bi-arrow-left"></i>
            Back to Dashboard

        </a>

    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>