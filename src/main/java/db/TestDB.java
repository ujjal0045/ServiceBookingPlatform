package db;

import java.sql.*;

public class TestDB {

    public static void main(String[] args) {

        DBConnection db = new DBConnection();
        Connection con = db.getConn();

        if (con != null) {
            System.out.println("Database connected successfully!");
        } else {
            System.out.println("Database connection failed!");
        }
    }
}