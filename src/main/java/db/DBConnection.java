package db;
import java.sql.*;

public class DBConnection {
	private Connection cn=null;
	public Connection getConn() {
		try
		{
		  Class.forName("com.mysql.cj.jdbc.Driver");
		  cn=DriverManager.getConnection("jdbc:mysql://localhost:3306/servicebook","root",System.getenv("DB_PASSWORD"));
		  
		}
		catch(ClassNotFoundException ce)
		{
			ce.printStackTrace();
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
		return cn;
	}
}
