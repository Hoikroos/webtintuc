package com.poly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import com.poly.entity.User;
import com.poly.utils.Jdbc;

public class UserDAO {
	public ArrayList<User> selectAll() {
		ArrayList<User> results = new ArrayList<>();
		String sql = "SELECT * FROM USERS";
		try (Connection con = Jdbc.getConnection();
				PreparedStatement st = con.prepareStatement(sql);
				ResultSet rs = st.executeQuery()) {
			while (rs.next()) {
				String id = rs.getString("Id");
				String password = rs.getString("Password");
				String fullname = rs.getString("Fullname");
				Date birthday = rs.getDate("Birthday");
				boolean gender = rs.getBoolean("Gender");
				String mobile = rs.getString("Mobile");
				String email = rs.getString("Email");
				boolean role = rs.getBoolean("Role");
				User user = new User(id, password, fullname, birthday, gender, mobile, email, role);
				results.add(user);
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong selectAll: " + e.getMessage());
		}
		return results;
	}

	public User selectById(String id) {
		User result = null;
		String sql = "SELECT * FROM USERS WHERE Id=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			try (ResultSet rs = st.executeQuery()) {
				if (rs.next()) {
					String userId = rs.getString("Id");
					String password = rs.getString("Password");
					String fullname = rs.getString("Fullname");
					Date birthday = rs.getDate("Birthday");
					Boolean gender = rs.getBoolean("Gender");
					if (rs.wasNull()) {
						gender = null;
					}
					String mobile = rs.getString("Mobile");
					String email = rs.getString("Email");
					Boolean role = rs.getBoolean("Role");
					if (rs.wasNull()) {
						role = null;
					}
					result = new User(userId, password, fullname, birthday, gender, mobile, email, role);
				}
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong selectById: " + e.getMessage());
		}
		return result;
	}

	public User selectByEmailAndPassword(User user) {
		User result = null;
		String sql = "SELECT * FROM Users WHERE Email=? AND password=?";

		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {

			st.setString(1, user.getEmail());
			st.setString(2, user.getPassword());

			try (ResultSet rs = st.executeQuery()) {
				if (rs.next()) {
					String id = rs.getString("Id");
					String password = rs.getString("password");
					String fullname = rs.getString("Fullname");
					Date birthday = rs.getDate("Birthday");
					boolean gender = rs.getBoolean("Gender");
					String mobile = rs.getString("Mobile");
					String email = rs.getString("Email");
					boolean role = rs.getBoolean("Role");

					result = new User(id, password, fullname, birthday, gender, mobile, email, role);
				}
			}

		} catch (SQLException e) {
			System.err.println("Lỗi trong selectByEmailAndPassword: " + e.getMessage());
		}

		return result;
	}

	public int insert(User user) {
		int result = 0;
		String sql = "INSERT INTO USERS (Id,Password, Fullname, Birthday, Gender, Mobile,Email,Role) VALUES(?,?,?,?,?,?,?,?)";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			System.out.println("Id: " + user.getId());
			System.out.println("Password: " + user.getPassword());
			System.out.println("Fullname: " + user.getFullname());
			System.out.println("Birthday: " + user.getBirthday());
			System.out.println("Gender: " + user.isGender());
			System.out.println("Mobile: " + user.getMobile());
			System.out.println("Email: " + user.getEmail());
			System.out.println("Role: " + user.isRole());
			st.setString(1, user.getId());
			st.setString(2, user.getPassword());
			st.setString(3, user.getFullname());
			if (user.getBirthday() != null) {
				st.setDate(4, new java.sql.Date(user.getBirthday().getTime()));
			} else {
				st.setDate(4, null);
			}
			st.setInt(5, user.isGender() ? 1 : 0);
			st.setString(6, user.getMobile());
			st.setString(7, user.getEmail());
			st.setInt(8, user.isRole() ? 1 : 0);
			result = st.executeUpdate();
			System.out.println("Inserted: " + result + " hàng.");
		} catch (SQLException e) {
			System.err.println("Lỗi trong: " + e.getMessage());
		}
		return result;
	}

	public int deleteById(String id) {
		int result = 0;
		String sql = "DELETE FROM USERS WHERE Id=?";
		System.out.println("Thực hiện SQL: " + sql + " với ID: " + id);
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			result = st.executeUpdate();
			System.out.println("Delete result: " + result);
			if (result == 1) {
				System.out.println("User với ID " + id + " xóa thành công.");
			} else {
				System.out.println("User với ID " + id + " không thành công.");
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong deleteById: " + e.getMessage());
		}
		return result;
	}

	public int update(User user) {
		int result = 0;
		String sql = "UPDATE USERS SET Password=?, Fullname=?, Birthday=?, Gender=?, Mobile=?, Email=?, Role=? WHERE Id=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, user.getPassword());
			st.setString(2, user.getFullname());
			if (user.getBirthday() != null) {
				st.setDate(3, new java.sql.Date(user.getBirthday().getTime()));
			} else {
				st.setNull(3, java.sql.Types.DATE);
			}
			st.setByte(4, (byte) (user.isGender() ? 1 : 0));
			st.setString(5, user.getMobile());
			st.setString(6, user.getEmail());
			st.setByte(7, (byte) (user.isRole() ? 1 : 0));
			st.setString(8, user.getId());
			result = st.executeUpdate();
			if (result == 1) {
				System.out.println("User với ID " + user.getId() + " cập nhật thành công.");
			} else if (result == 0) {
				System.out.println("User với ID " + user.getId() + " thất bại.");
			} else {
				System.out.println("Updated: " + result + " hàng.");
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong update: " + e.getMessage());
		}
		return result;
	}

	public boolean changePassword(User user) {
		int result = 0;
		String sql = "UPDATE USERS SET Password=? WHERE Id=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, user.getPassword());
			st.setString(2, user.getId());
			result = st.executeUpdate();
			System.out.println("Password changed for: " + user.getId());
		} catch (SQLException e) {
			System.err.println("Lỗi trongchangePassword: " + e.getMessage());
		}
		return result > 0;
	}

	public boolean checkUsernameExists(String email) {
		boolean exists = false;
		String sql = "SELECT * FROM USERS WHERE Email=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, email);
			try (ResultSet rs = st.executeQuery()) {
				exists = rs.next();
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong checkUsernameExists: " + e.getMessage());
		}
		return exists;
	}

	public boolean existsById(String id) {
		String sql = "SELECT COUNT(*) FROM USERS WHERE Id = ?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong existsById: " + e.getMessage());
		}
		return false;
	}

	public String getFullNameById(String id) {
		String sql = "SELECT Fullname FROM USERS WHERE Id = ?";
		String fullName = null;
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				fullName = rs.getString("Fullname");
			}
		} catch (SQLException e) {
			System.err.println("Error in getFullNameById: " + e.getMessage());
		}
		return fullName;
	}

	public User findByEmail(String Email) {
		User users = null;
		String sql = "SELECT * from USERS  WHERE Email = ? ";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, Email);
			ResultSet rs = st.executeQuery();
			if (rs.next()) {
				users = new User();
				users.setId(rs.getString("Id")); // Lấy ID của người dùng

				users.setEmail(Email);
				users.setPassword(rs.getString("Password")); // Lấy mật khẩu hiện tại của người dùng

			}
		} catch (Exception e) {
			System.err.println("Error in findByEmail: " + e.getMessage());
		}

		return users;
	}
}
