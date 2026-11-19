
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dao.NotificationDAO" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    Integer userId = (Integer) session.getAttribute("userId");

    if (username == null || !"customer".equals(role) || userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    NotificationDAO notificationDAO = new NotificationDAO();
    ResultSet rs = notificationDAO.getNotificationsByUser(userId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notifications - ServiceBook</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css"
          rel="stylesheet">
          
    <link rel="stylesheet" href="Style/notifications.css">
</head>

<body class="bg-light">

<div class="container py-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2><i class="bi bi-bell"></i> Notifications</h2>
            <p class="text-muted">
                View updates about your service bookings.
            </p>
        </div>

        <a href="dashboard.jsp" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Dashboard
        </a>
    </div>

    <%
        boolean hasNotifications = false;

        if (rs != null) {
            while (rs.next()) {
                hasNotifications = true;

                boolean isRead = rs.getBoolean("is_read");
    %>

    <div class="card shadow-sm mb-3">
        <div class="card-body">

            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <p class="mb-2">
                        <%= rs.getString("message") %>
                    </p>

                    <small class="text-muted">
                        <i class="bi bi-clock"></i>
                        <%= rs.getTimestamp("created_at") %>
                    </small>
                </div>

                
<% if (!isRead) { %>

    <div class="text-end">
        <span class="badge bg-primary mb-2">New</span>

        <form action="<%= request.getContextPath() %>/MarkNotificationReadServlet"
              method="post">

            <input type="hidden"
                   name="id"
                   value="<%= rs.getInt("id") %>">

            <button type="submit"
                    class="btn btn-sm btn-outline-primary">
                <i class="bi bi-check-circle"></i>
                Mark as Read
            </button>

        </form>
    </div>

<% } else { %>

    <span class="badge bg-secondary">Read</span>

<% } %>

            </div>

        </div>
    </div>

    <%
            }
            rs.close();
        }

        if (!hasNotifications) {
    %>

    <div class="text-center py-5">
        <i class="bi bi-bell-slash text-muted"
           style="font-size: 60px;"></i>

        <h4 class="mt-3">No Notifications Yet</h4>

        <p class="text-muted">
            You'll see booking updates here when they become available.
        </p>
    </div>

    <%
        }
    %>

</div>

</body>
</html>
