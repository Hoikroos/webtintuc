package com.poly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.poly.entity.Newsletters;
import com.poly.utils.Jdbc;

public class NewslettersDAO {
	public ArrayList<Newsletters> selectAll() {
		ArrayList<Newsletters> results = new ArrayList<>();
		String sql = "SELECT * FROM NEWSLETTERS";
		try (Connection con = Jdbc.getConnection();
				PreparedStatement st = con.prepareStatement(sql);
				ResultSet rs = st.executeQuery()) {
			while (rs.next()) {
				String email = rs.getString("Email");
				boolean enabled = rs.getBoolean("Enabled");
				Newsletters user = new Newsletters(email, enabled);
				results.add(user);
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong selectAll: " + e.getMessage());
		}
		return results;
	}

	public Newsletters selectById(String id) {
		Newsletters result = null;
		String sql = "SELECT * FROM NEWSLETTERS WHERE Email=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			try (ResultSet rs = st.executeQuery()) {
				if (rs.next()) {
					String newemail = rs.getString("Email");
					Boolean enabled = rs.getBoolean("Enabled");
					if (rs.wasNull()) {
						enabled = null;
					}
					result = new Newsletters(newemail, enabled);
				}
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong selectById: " + e.getMessage());
		}
		return result;
	}

	public int insert(Newsletters newlet) {
		int result = 0;
		String sql = "INSERT INTO NEWSLETTERS (Email,Enabled) VALUES(?,?)";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			System.out.println("Email: " + newlet.getEmail());
			System.out.println("Enabled: " + newlet.isEnabled());
			st.setString(1, newlet.getEmail());
			st.setInt(5, newlet.isEnabled() ? 1 : 0);
			result = st.executeUpdate();
			System.out.println("Inserted: " + result + " hàng.");
		} catch (SQLException e) {
			System.err.println("Lỗi trong insert: " + e.getMessage());
		}
		return result;
	}

	public int deleteById(String id) {
		int result = 0;
		String sql = "DELETE FROM NEWSLETTER WHERE Email=?";
		System.out.println("Thực hiện SQL: " + sql + " với Email: " + id);
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			result = st.executeUpdate();
			System.out.println("Delete result: " + result);
			if (result == 1) {
				System.out.println("User với Email " + id + " xóa thành công.");
			} else {
				System.out.println("User với Email " + id + " not found.");
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong deleteById: " + e.getMessage());
		}
		return result;
	}

	public int update(Newsletters newlet) {
		int result = 0;
		String sql = "UPDATE NEWSLETTERS SET Enabled=? WHERE Email=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setByte(1, (byte) (newlet.isEnabled() ? 1 : 0));
			st.setString(2, newlet.getEmail());
			result = st.executeUpdate();
			if (result == 1) {
				System.out.println("User with ID " + newlet.getEmail() + " updated successfully.");
			} else if (result == 0) {
				System.out.println("User with ID " + newlet.getEmail() + " not found.");
			} else {
				System.out.println("Updated: " + result + " rows.");
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong update: " + e.getMessage());
		}
		return result;
	}
}
