package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnection;

public class UserDAO {

    // =========================
    // REGISTER USER
    // =========================
    public boolean registerUser(
            String name,
            String username,
            String email,
            String phno,
            String role,
            String serviceCategory,
            int experience,
            String location,
            String skills,
            String password) {

        boolean result = false;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "INSERT INTO users "
                    + "(name, username, email, phno, role, service_category, "
                    + "experience, location, skills, password) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, username);
            ps.setString(3, email);
            ps.setString(4, phno);
            ps.setString(5, role);
            ps.setString(6, serviceCategory);
            ps.setInt(7, experience);
            ps.setString(8, location);
            ps.setString(9, skills);
            ps.setString(10, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }


    // =========================
    // LOGIN USER
    // =========================
    public String loginUser(String username, String password) {

        String role = null;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT role FROM users WHERE username = ? AND password = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                role = rs.getString("role");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return role;
    }

    public int getUserId(String username) {

        int userId = 0;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT id FROM users WHERE username = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return userId;
    }

    // =========================
    // GET CUSTOMER PROFILE
    // =========================
    public ResultSet getCustomerById(int userId) {

        try {
            Connection con = new DBConnection().getConn();

            String sql = "SELECT id, name, username, email, phno "
                       + "FROM users "
                       + "WHERE id = ? AND role = 'customer'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            return ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // UPDATE CUSTOMER PROFILE
    // =========================
    public boolean updateCustomerProfile(
            int userId,
            String name,
            String email,
            String phno) {

        String sql = "UPDATE users "
                   + "SET name = ?, email = ?, phno = ? "
                   + "WHERE id = ? AND role = 'customer'";

        try (Connection con = new DBConnection().getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phno);
            ps.setInt(4, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // GET PROVIDER PROFILE
    // =========================
    public ResultSet getProviderById(int providerId) {

        try {
            Connection con = new DBConnection().getConn();

            String sql = "SELECT id, name, username, email, phno, "
                       + "service_category, experience, location, skills "
                       + "FROM users "
                       + "WHERE id = ? AND role = 'provider'";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, providerId);

            return ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // UPDATE PROVIDER PROFILE
    // =========================
    public boolean updateProviderProfile(
            int providerId,
            String name,
            String email,
            String phno,
            String category,
            int experience,
            String location,
            String skills) {

        String sql = "UPDATE users SET "
                   + "name = ?, email = ?, phno = ?, "
                   + "service_category = ?, experience = ?, "
                   + "location = ?, skills = ? "
                   + "WHERE id = ? AND role = 'provider'";

        try (Connection con = new DBConnection().getConn();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phno);
            ps.setString(4, category);
            ps.setInt(5, experience);
            ps.setString(6, location);
            ps.setString(7, skills);
            ps.setInt(8, providerId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

public ResultSet getProvidersByCategory(String category) {

    String sql =
        "SELECT DISTINCT u.id, u.name, u.service_category, "
        + "u.experience, u.location, u.skills "
        + "FROM users u "
        + "INNER JOIN provider_services ps "
        + "ON u.id = ps.provider_id "
        + "WHERE u.role = 'provider' "
        + "AND ps.status = 'Active' "
        + "AND (LOWER(u.service_category) = LOWER(?) "
        + "OR LOWER(ps.title) = LOWER(?)) "
        + "ORDER BY u.name ASC";

    try {
        DBConnection db = new DBConnection();
        Connection con = db.getConn();

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setString(1, category);
        ps.setString(2, category);

        return ps.executeQuery();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}

}