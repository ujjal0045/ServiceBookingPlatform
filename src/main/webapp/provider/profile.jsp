
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="dao.UserDAO" %>

<%!
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
    Integer providerId = (Integer) session.getAttribute("userId");

    // Validate provider session
    if (username == null || !"provider".equals(role)
            || providerId == null) {

        response.sendRedirect("../login.jsp");
        return;
    }

    String name = "";
    String email = "";
    String phone = "";
    String category = "";
    String location = "";
    String skills = "";
    int experience = 0;

    UserDAO userDAO = new UserDAO();
    ResultSet rs = userDAO.getProviderById(providerId);

    if (rs == null) {
        response.sendError(500, "Unable to load provider profile.");
        return;
    }

    try {
        if (rs.next()) {
            name = rs.getString("name");
            username = rs.getString("username");
            email = rs.getString("email");
            phone = rs.getString("phno");
            category = rs.getString("service_category");
            experience = rs.getInt("experience");
            location = rs.getString("location");
            skills = rs.getString("skills");
        } else {
            response.sendError(404, "Provider not found.");
            return;
        }
    } finally {
        Statement stmt = rs.getStatement();
        Connection con = stmt.getConnection();

        rs.close();
        stmt.close();
        con.close();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Provider Profile - ServiceBook</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <!-- External CSS -->
    <link rel="stylesheet" href="styles/profile.css">
</head>

<body>

<div class="container">

    <div class="card profile-card">

        <div class="card-body p-4">
			
<%
    String updateStatus = request.getParameter("update");
%>

<% if ("success".equals(updateStatus)) { %>
    <div class="alert alert-success">
        Provider profile updated successfully!
    </div>
<% } else if ("invalid".equals(updateStatus)) { %>
    <div class="alert alert-danger">
        Please enter valid profile information.
    </div>
<% } else if ("failed".equals(updateStatus)) { %>
    <div class="alert alert-danger">
        Unable to update profile. Please try again.
    </div>
<% } %>
			
            <!-- Profile Header -->
            <div class="text-center mb-4">

                <i class="bi bi-person-badge profile-icon"></i>

                <h3 class="mt-2">Provider Profile</h3>

                <p class="text-muted">
                    Manage Your Professional Information
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

            <!-- Phone -->
            <div class="profile-field">
                <label>Phone Number</label>
                <p><%= escapeHtml(phone) %></p>
            </div>

            <!-- Service Category -->
            <div class="profile-field">
                <label>Service Category</label>
                <p><%= escapeHtml(category) %></p>
            </div>

            <!-- Experience -->
            <div class="profile-field">
                <label>Experience</label>
                <p><%= experience %> Years</p>
            </div>

            <!-- Location -->
            <div class="profile-field">
                <label>Location</label>
                <p><%= escapeHtml(location) %></p>
            </div>

            <!-- Skills -->
            <div class="profile-field">
                <label>Skills</label>
                <p><%= escapeHtml(skills) %></p>
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
            data-bs-target="#editProviderForm"
            aria-expanded="false"
            aria-controls="editProviderForm">
        <i class="bi bi-pencil-square"></i>
        Edit Profile
    </button>

</div>

<!-- Edit Provider Profile Form -->
<div class="collapse mt-4" id="editProviderForm">

    <div class="edit-profile-section">

        <h5 class="mb-4">
            <i class="bi bi-pencil-square"></i>
            Edit Professional Information
        </h5>

        <form action="<%= request.getContextPath() %>/EditProviderProfileServlet"
              method="post">

            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control"
                       id="name" name="name"
                       value="<%= escapeHtml(name) %>"
                       maxlength="100" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control"
                       id="email" name="email"
                       value="<%= escapeHtml(email) %>"
                       maxlength="254" required>
            </div>

            <div class="mb-3">
                <label for="phno" class="form-label">Phone Number</label>
                <input type="tel" class="form-control"
                       id="phno" name="phno"
                       value="<%= escapeHtml(phone) %>"
                       pattern="[0-9]{10}" maxlength="10" required>
            </div>

            <div class="mb-3">
                <label for="category" class="form-label">Service Category</label>
                <input type="text" class="form-control"
                       id="category" name="category"
                       value="<%= escapeHtml(category) %>"
                       required>
            </div>

            <div class="mb-3">
                <label for="experience" class="form-label">
                    Experience (Years)
                </label>
                <input type="number" class="form-control"
                       id="experience" name="experience"
                       value="<%= experience %>"
                       min="0" max="60" required>
            </div>

            <div class="mb-3">
                <label for="location" class="form-label">Location</label>
                <input type="text" class="form-control"
                       id="location" name="location"
                       value="<%= escapeHtml(location) %>"
                       required>
            </div>

            <div class="mb-3">
                <label for="skills" class="form-label">Skills</label>
                <textarea class="form-control"
                          id="skills" name="skills"
                          rows="3" required><%= escapeHtml(skills) %></textarea>
            </div>

            <button type="submit" class="btn btn-success w-100">
                <i class="bi bi-check-circle"></i>
                Save Changes
            </button>

        </form>

    </div>

</div>
<!-- End Edit Provider Profile Form -->


        </div>

    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
