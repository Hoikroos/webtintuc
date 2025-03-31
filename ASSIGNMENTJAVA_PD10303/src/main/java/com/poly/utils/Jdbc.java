package com.poly.utils;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Jdbc {
	static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	static String dburl = "jdbc:sqlserver://localhost:1433;databaseName=ASSJAVA31;encrypt=true;trustServerCertificate=true";
	static String username = "hoivd";
	static String password = "23022005";
	static {
		try { // nạp driver
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}

	public static Connection getConnection() throws SQLException {
		return DriverManager.getConnection(dburl, username, password);
	}

	public static int executeUpdate(String sql, Object... values) throws SQLException {
		PreparedStatement stmt = Jdbc.createPreStmt(sql, values);
		return stmt.executeUpdate();
	}

	public static ResultSet executeQuery(String sql, Object... values) throws SQLException {
		PreparedStatement stmt = Jdbc.createPreStmt(sql, values);
		return stmt.executeQuery();
	}

	private static PreparedStatement createPreStmt(String sql, Object... values) throws SQLException {

		Connection connection = Jdbc.getConnection();
		PreparedStatement stmt = null;
		if (sql.trim().startsWith("{")) {
			stmt = connection.prepareCall(sql);
		}
		stmt = connection.prepareStatement(sql);
		for (int i = 0; i < values.length; i++) {
			stmt.setObject(i + 1, values[i]);
		}
		return stmt;
	}
}
