
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.sql.*" %>
<%@ page import="dao.NotificationDAO" %>

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
    if (username == null ||
        !"provider".equals(role) ||
        providerId == null) {

        response.sendRedirect("../login.jsp");
        return;
    }

    NotificationDAO notificationDAO = new NotificationDAO();

    ResultSet rs = notificationDAO.getNotificationsByUser(providerId);

    if (rs == null) {
        response.sendError(500, "Unable to load notifications.");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Provider Notifications - ServiceBook</title>

    <!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">

    <!-- External CSS -->
    <link rel="stylesheet" href="styles/notifications.css">
</head>

<body>

<div class="container notification-container">

<%
    String readStatus = request.getParameter("read");

    if ("success".equals(readStatus)) {
%>
    <div class="alert alert-success">
        <i class="bi bi-check-circle"></i>
        Notification marked as read successfully!
    </div>
<%
    } else if ("failed".equals(readStatus)) {
%>
    <div class="alert alert-danger">
        <i class="bi bi-exclamation-circle"></i>
        Failed to mark notification as read.
    </div>
<%
    }
%>

    <div class="notification-header">
        <h2>
            <i class="bi bi-bell"></i>
            Provider Notifications
        </h2>

        <p class="text-muted">
            Stay updated with your latest bookings.
        </p>
    </div>

    <%
        boolean hasNotifications = false;

        try {
            while (rs.next()) {

                hasNotifications = true;

                int notificationId = rs.getInt("id");
                int bookingId = rs.getInt("booking_id");

                String message = rs.getString("message");
                Timestamp createdAt = rs.getTimestamp("created_at");

                boolean isRead = rs.getBoolean("is_read");
    %>

        <div class="notification-card <%= isRead ? "read" : "unread" %>">

            <div class="notification-content">

                <div class="notification-icon">
                    <i class="bi bi-calendar-check"></i>
                </div>

                <div class="notification-details">

                    <div class="notification-top">

                        <h5>Booking Notification</h5>

                        <% if (!isRead) { %>
                            <span class="badge bg-primary">
                                New
                            </span>
                        <% } else { %>
                            <span class="badge bg-secondary">
                                Read
                            </span>
                        <% } %>

                    </div>

                    <p><%= escapeHtml(message) %></p>

                    <small class="text-muted">
                        <i class="bi bi-clock"></i>
                        <%= createdAt %>
                    </small>


<div class="notification-actions">

    <a href="bookingDetails.jsp?bookingId=<%= bookingId %>"
       class="btn btn-sm btn-outline-primary">

        <i class="bi bi-eye"></i>
        View Booking

    </a>

    <% if (!isRead) { %>

        <form action="<%= request.getContextPath() %>/MarkNotificationReadServlet"
              method="post"
              class="d-inline">

            <input type="hidden"
                   name="id"
                   value="<%= notificationId %>">

            <button type="submit"
                    class="btn btn-sm btn-success">

                <i class="bi bi-check-circle"></i>
                Mark as Read

            </button>

        </form>

    <% } %>

</div>


                </div>

            </div>

        </div>

    <%
            }
        } finally {
            Statement stmt = rs.getStatement();
            Connection con = stmt.getConnection();

            rs.close();
            stmt.close();
            con.close();
        }

        if (!hasNotifications) {
    %>

        <div class="empty-notifications">
            <i class="bi bi-bell-slash"></i>
            <h5>No Notifications Yet</h5>
            <p>
                New booking notifications will appear here.
            </p>
        </div>

    <% } %>

    <div class="text-center mt-4">
        <a href="dashboard.jsp"
           class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i>
            Back to Dashboard
        </a>
    </div>

</div>

</body>
</html>
