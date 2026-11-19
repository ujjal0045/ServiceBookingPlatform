package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnection;

public class NotificationDAO {

    // Create a new notification
    public boolean addNotification(int userId, String message, int bookingId) {

        String sql = "INSERT INTO notifications "
                   + "(user_id, message, booking_id) "
                   + "VALUES (?, ?, ?)";

        try (Connection con = new DBConnection().getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, message);
            ps.setInt(3, bookingId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Get notifications for a specific user
    public ResultSet getNotificationsByUser(int userId) {

        try {
            Connection con = new DBConnection().getConn();

            String sql = "SELECT * FROM notifications "
                       + "WHERE user_id = ? "
                       + "ORDER BY created_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            return ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Mark a notification as read
    public boolean markAsRead(int notificationId, int userId) {

        String sql = "UPDATE notifications "
                   + "SET is_read = TRUE "
                   + "WHERE id = ? AND user_id = ?";

        try (Connection con = new DBConnection().getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, notificationId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Count unread notifications for a customer
    public int getUnreadNotificationCount(int userId) {

        String sql = "SELECT COUNT(*) FROM notifications "
                   + "WHERE user_id = ? AND is_read = FALSE";

        try (Connection con = new DBConnection().getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

}