package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnection;

public class ServiceDAO {
	
	public ResultSet getServicesByProvider(int providerId) {

	    ResultSet rs = null;

	    try {

	        DBConnection db = new DBConnection();
	        Connection con = db.getConn();

	        String sql = "SELECT * FROM provider_services "
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
	public ResultSet getAllActiveServices() {

	    ResultSet rs = null;

	    try {

	        DBConnection db = new DBConnection();
	        Connection con = db.getConn();

	        String sql = "SELECT * FROM provider_services "
	                   + "WHERE status = 'Active' "
	                   + "ORDER BY created_at DESC";

	        PreparedStatement ps = con.prepareStatement(sql);

	        rs = ps.executeQuery();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return rs;
	}

public ResultSet getServiceWithProviderById(int serviceId) {

    String sql =
        "SELECT ps.id, ps.provider_id, "
        	+ "ps.service_name, "
        + "ps.description, ps.price, "
        + "u.name AS provider_name, "
        + "u.experience, u.location, "
        + "u.skills, u.service_category "
        + "FROM provider_services ps "
        + "INNER JOIN users u "
        + "ON ps.provider_id = u.id "
        + "WHERE ps.id = ? "
        + "AND ps.status = 'Active' "
        + "AND u.role = 'provider'";

    try {

        DBConnection db = new DBConnection();
        Connection con = db.getConn();

        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1, serviceId);

        return ps.executeQuery();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return null;
}

	public int getActiveServiceCount(int providerId) {

	    int count = 0;

	    try {

	        DBConnection db = new DBConnection();
	        Connection con = db.getConn();

	        String sql = "SELECT COUNT(*) FROM provider_services "
	                   + "WHERE provider_id = ? "
	                   + "AND status = 'Active'";

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

    public boolean addService(
            int providerId,
            String serviceName,
            String description,
            double price) {

        boolean result = false;

        try {

            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "INSERT INTO provider_services "
                    + "(provider_id, service_name, description, price) "
                    + "VALUES (?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, providerId);
            ps.setString(2, serviceName);
            ps.setString(3, description);
            ps.setDouble(4, price);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    public boolean updateService(
            int serviceId,
            int providerId,
            String serviceName,
            String description,
            double price) {

        boolean result = false;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "UPDATE provider_services "
                       + "SET service_name = ?, description = ?, price = ? "
                       + "WHERE id = ? AND provider_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, serviceName);
            ps.setString(2, description);
            ps.setDouble(3, price);
            ps.setInt(4, serviceId);
            ps.setInt(5, providerId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    public boolean deleteService(int serviceId, int providerId) {

        boolean result = false;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "DELETE FROM provider_services "
                       + "WHERE id = ? AND provider_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, serviceId);
            ps.setInt(2, providerId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    public ResultSet getServiceById(int serviceId, int providerId) {

        ResultSet rs = null;

        try {
            DBConnection db = new DBConnection();
            Connection con = db.getConn();

            String sql = "SELECT * FROM provider_services "
                       + "WHERE id = ? AND provider_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, serviceId);
            ps.setInt(2, providerId);

            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
}