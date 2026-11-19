
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="dao.ServiceDAO" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer providerId = (Integer) session.getAttribute("userId");

    if (username == null || !"provider".equals(role) || providerId == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    int serviceId;

    try {
        serviceId = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect("myServices.jsp");
        return;
    }

    ServiceDAO serviceDAO = new ServiceDAO();
    ResultSet rs = serviceDAO.getServiceById(serviceId, providerId);

    if (rs == null || !rs.next()) {
        response.sendRedirect("myServices.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Service - ServiceBook</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
          
    <link rel="stylesheet" href="styles/editService.css">
</head>

<body class="bg-light">

<div class="container py-5">

    <div class="card shadow-sm mx-auto" style="max-width: 650px;">

        <div class="card-body p-4">

            <h3 class="mb-4">
                <i class="bi bi-pencil-square"></i>
                Edit Service
            </h3>

            <form action="../EditServiceServlet" method="post">

                <input type="hidden" name="serviceId"
                       value="<%= rs.getInt("id") %>">

                <div class="mb-3">
                    <label class="form-label">Service Name</label>
                    <input type="text" name="serviceName"
                           class="form-control"
                           value="<%= rs.getString("service_name") %>"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control"
                              rows="4"><%= rs.getString("description") == null ? "" : rs.getString("description") %></textarea>
                </div>

                <div class="mb-4">
                    <label class="form-label">Price (₹)</label>
                    <input type="number" name="price"
                           class="form-control"
                           value="<%= rs.getDouble("price") %>"
                           min="1" step="0.01" required>
                </div>

                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-check-circle"></i>
                    Update Service
                </button>

                <a href="myServices.jsp" class="btn btn-outline-secondary">
                    Cancel
                </a>

            </form>

        </div>
    </div>

</div>

</body>
</html>
