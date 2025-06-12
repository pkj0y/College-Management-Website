package collegeproj;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	private static final String URL = "jdbc:mysql://localhost:3306/collegemgdb"; // Database URL
	private static final String USER = "root"; // Database username
	private static final String PASSWORD = ""; // Database password

	// Database connection method
	public static Connection getConnection() throws SQLException {
	    return DriverManager.getConnection(URL, USER, PASSWORD);
	}

    }

