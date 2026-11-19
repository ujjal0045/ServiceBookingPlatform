<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    if (username == null || role == null || !role.equals("provider")) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Add Service - ServiceBook</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="../styles/addService.css">

</head>

<body>

<div class="container py-5">

    <a href="dashboard.jsp"
       class="btn btn-outline-secondary mb-4">

        <i class="bi bi-arrow-left"></i>
        Back to Dashboard

    </a>

    <div class="row justify-content-center">

        <div class="col-md-7">

            <div class="card shadow-sm">

                <div class="card-body p-4">

                    <h2 class="mb-4">
                        <i class="bi bi-plus-circle"></i>
                        Add New Service
                    </h2>

                    <form action="../AddServiceServlet" method="post">

                        <div class="mb-3">

                            <label class="form-label">
                                Service Name
                            </label>

                            <input type="text"
                                   name="serviceName"
                                   class="form-control"
                                   placeholder="Enter service name"
                                   required>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">
                                Description
                            </label>

                            <textarea name="description"
                                      class="form-control"
                                      rows="4"
                                      placeholder="Describe your service"
                                      required></textarea>

                        </div>


                        <div class="mb-4">

                            <label class="form-label">
                                Price
                            </label>

                            <div class="input-group">

                                <span class="input-group-text">
                                    ₹
                                </span>

                                <input type="number"
                                       name="price"
                                       class="form-control"
                                       placeholder="Enter service price"
                                       min="0"
                                       step="0.01"
                                       required>

                            </div>

                        </div>


                        <button type="submit"
                                class="btn btn-primary w-100">

                            <i class="bi bi-plus-circle"></i>
                            Add Service

                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>