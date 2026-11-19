package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnection;

public class BookingDAO {


public int createBooking(
        String customerUsername,
        int providerId,
        String service,
        String bookingDate,
        String bookingTime,
        String address,
        String requirements) {

    int bookingId = -1;

    String sql = "INSERT INTO bookings "
            + "(customer_username, provider_id, service, booking_date, "
            + "booking_time, address, requirements) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?)";

    try (Connection con = new DBConnection().getConn();
         PreparedStatement ps = con.prepareStatement(
                 sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {

        ps.setString(1, customerUsername);
        ps.setInt(2, providerId);
        ps.setString(3, service);
        ps.setString(4, bookingDate);
        ps.setString(5, bookingTime);
        ps.setString(6, address);
        ps.setString(7, requirements);

        int rows = ps.executeUpdate();

        if (rows > 0) {

            try (ResultSet rs = ps.getGeneratedKeys()) {

                if (rs.next()) {
                    bookingId = rs.getInt(1);
                }
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return bookingId;
}

    public ResultSet getBookingsByCustomer(String username) {

        ResultSet rs = null;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT * FROM bookings "
                       + "WHERE customer_username = ? "
                       + "ORDER BY created_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);

            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
    public boolean cancelBooking(int bookingId, String username) {

        boolean result = false;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "UPDATE bookings "
                       + "SET status = 'Cancelled' "
                       + "WHERE id = ? "
                       + "AND customer_username = ? "
                       + "AND status = 'Pending'";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, bookingId);
            ps.setString(2, username);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    public ResultSet getBookingsByProvider(int providerId) {

        ResultSet rs = null;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT * FROM bookings "
                       + "WHERE provider_id = ? "
                       + "ORDER BY created_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, providerId);

            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
    

public boolean updateBookingStatus(int bookingId, int providerId, String status) {

    String currentStatus;

    if ("Accepted".equals(status) || "Rejected".equals(status)) {
        currentStatus = "Pending";
    } else if ("Completed".equals(status)) {
        currentStatus = "Accepted";
    } else {
        return false;
    }

    String sql = "UPDATE bookings "
               + "SET status = ? "
               + "WHERE id = ? "
               + "AND provider_id = ? "
               + "AND status = ?";

    try {

        DBConnection db = new DBConnection();
        Connection con = db.getConn();

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, status);
        ps.setInt(2, bookingId);
        ps.setInt(3, providerId);
        ps.setString(4, currentStatus);

        int rows = ps.executeUpdate();

        ps.close();
        con.close();

        return rows > 0;

    } catch (Exception e) {
        e.printStackTrace();
    }

    return false;
}

    
    public int getBookingCountByProvider(int providerId) {

        int count = 0;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT COUNT(*) FROM bookings WHERE provider_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, providerId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    public int getCompletedBookingCountByProvider(int providerId) {

        int count = 0;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT COUNT(*) FROM bookings "
                       + "WHERE provider_id = ? AND status = 'Completed'";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, providerId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    public int getPendingBookingCountByProvider(int providerId) {
        int count = 0;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT COUNT(*) FROM bookings "
                       + "WHERE provider_id = ? AND status = 'Pending'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, providerId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public ResultSet getLatestBookingByProvider(int providerId) {

        ResultSet rs = null;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT * FROM bookings "
                       + "WHERE provider_id = ? "
                       + "ORDER BY created_at DESC "
                       + "LIMIT 1";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, providerId);

            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }

public Integer getCustomerIdByBookingId(int bookingId, int providerId) {

    String sql = "SELECT u.id "
               + "FROM bookings b "
               + "JOIN users u ON b.customer_username = u.username "
               + "WHERE b.id = ? AND b.provider_id = ?";

    try (Connection con = new DBConnection().getConn();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, bookingId);
        ps.setInt(2, providerId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("id");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}

public String getActiveServiceName(int serviceId, int providerId) {

    String sql = "SELECT service_name FROM provider_services "
               + "WHERE id = ? AND provider_id = ? "
               + "AND status = 'Active'";

    try (Connection con = new DBConnection().getConn();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, serviceId);
        ps.setInt(2, providerId);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getString("service_name");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}

}