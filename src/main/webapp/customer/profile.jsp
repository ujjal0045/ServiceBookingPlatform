
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="dao.UserDAO" %>

<%!
    // Escape database values before displaying them in HTML
    private String escapeHtml(String value) {
        if (value == null) return "";

        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer customerId = (Integer) session.getAttribute("userId");

    // Check customer session
    if (username == null || role == null ||
        !"customer".equals(role) || customerId == null) {

        response.sendRedirect("../login.jsp");
        return;
    }

    String name = "";
    String email = "";
    String phone = "";

    // Fetch customer information
    UserDAO userDAO = new UserDAO();
    ResultSet rs = userDAO.getCustomerById(customerId);

    if (rs == null) {
        response.sendError(500, "Unable to load profile.");
        return;
    }

    try {
        if (rs.next()) {
            name = rs.getString("name");
            username = rs.getString("username");
            email = rs.getString("email");
            phone = rs.getString("phno");
        } else {
            response.sendError(404, "Customer not found.");
            return;
        }
    } finally {
        Statement stmt = rs.getStatement();
        Connection con = stmt.getConnection();

        rs.close();
        stmt.close();
        con.close();
    }

    String updateStatus = request.getParameter("update");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>My Profile - ServiceBook</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <!-- External CSS -->
    <link rel="stylesheet" href="Style/profile.css">
</head>

<body>

<div class="container">

    <div class="card profile-card">

        <div class="card-body p-4">

            <!-- Success and Error Messages -->
            <% if ("success".equals(updateStatus)) { %>

                <div class="alert alert-success">
                    Profile updated successfully!
                </div>

            <% } else if ("invalid".equals(updateStatus)) { %>

                <div class="alert alert-danger">
                    Please enter valid profile details.
                </div>

            <% } else if ("failed".equals(updateStatus)) { %>

                <div class="alert alert-danger">
                    Unable to update profile. Please try again.
                </div>

            <% } %>

            <!-- Profile Header -->
            <div class="text-center mb-4">

                <i class="bi bi-person-circle profile-icon"></i>

                <h3 class="mt-2">My Profile</h3>

                <p class="text-muted">
                    Customer Information
                </p>

            </div>

            <!-- Full Name -->
            <div class="profile-field">
                <label>Full Name</label>
                <p><%= escapeHtml(name) %></p>
            </div>

            <!-- Username -->
            <div class="profile-field">
                <label>Username</label>
                <p><%= escapeHtml(username) %></p>
            </div>

            <!-- Email -->
            <div class="profile-field">
                <label>Email Address</label>
                <p><%= escapeHtml(email) %></p>
            </div>

            <!-- Phone Number -->
            <div class="profile-field">
                <label>Phone Number</label>
                <p><%= escapeHtml(phone) %></p>
            </div>

            <!-- Back and Edit Profile Buttons -->
            <div class="d-flex gap-2 mt-4">

                <a href="dashboard.jsp"
                   class="btn btn-outline-secondary w-50">

                    <i class="bi bi-arrow-left"></i>
                    Back

                </a>

                <button type="button"
                        class="btn btn-primary w-50"
                        data-bs-toggle="collapse"
                        data-bs-target="#editProfileForm"
                        aria-expanded="false"
                        aria-controls="editProfileForm">

                    <i class="bi bi-pencil-square"></i>
                    Edit Profile

                </button>

            </div>

            <!-- Edit Profile Form -->
            <div class="collapse mt-4" id="editProfileForm">

                <div class="edit-profile-section">

                    <h5 class="mb-3">
                        <i class="bi bi-pencil-square"></i>
                        Edit Personal Information
                    </h5>

                    <form action="<%= request.getContextPath() %>/EditProfileServlet"
                          method="post">

                        <!-- Full Name -->
                        <div class="mb-3">

                            <label for="name" class="form-label">
                                Full Name
                            </label>

                            <input type="text"
                                   class="form-control"
                                   id="name"
                                   name="name"
                                   value="<%= escapeHtml(name) %>"
                                   maxlength="100"
                                   required>

                        </div>

                        <!-- Email Address -->
                        <div class="mb-3">

                            <label for="email" class="form-label">
                                Email Address
                            </label>

                            <input type="email"
                                   class="form-control"
                                   id="email"
                                   name="email"
                                   value="<%= escapeHtml(email) %>"
                                   maxlength="254"
                                   required>

                        </div>

                        <!-- Phone Number -->
                        <div class="mb-3">

                            <label for="phno" class="form-label">
                                Phone Number
                            </label>

                            <input type="tel"
                                   class="form-control"
                                   id="phno"
                                   name="phno"
                                   value="<%= escapeHtml(phone) %>"
                                   pattern="[0-9]{10}"
                                   maxlength="10"
                                   required>

                        </div>

                        <!-- Save Changes -->
                        <button type="submit"
                                class="btn btn-success w-100">

                            <i class="bi bi-check-circle"></i>
                            Save Changes

                        </button>

                    </form>

                </div>

            </div>
            <!-- End Edit Profile Form -->

        </div>
        <!-- End Card Body -->

    </div>
    <!-- End Profile Card -->

</div>
<!-- End Container -->

<!-- Bootstrap JavaScript -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>
