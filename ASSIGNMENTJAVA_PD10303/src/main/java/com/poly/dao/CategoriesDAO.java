package com.poly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.poly.entity.Categories;
import com.poly.utils.Jdbc;

public class CategoriesDAO {
	public List<Categories> selectAll() {
		List<Categories> categoriesList = new ArrayList<>();
		String sql = "SELECT * FROM CATEGORIES";

		try (Connection con = Jdbc.getConnection();
				PreparedStatement st = con.prepareStatement(sql);
				ResultSet rs = st.executeQuery()) {

			while (rs.next()) {
				String id = rs.getString("Id");
				String name = rs.getString("Name");
				Categories category = new Categories(id, name);
				categoriesList.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return categoriesList;
	}

	public Categories selectById(String id) {
		Categories result = null;
		String sql = "SELECT * FROM CATEGORIES WHERE Id=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			try (ResultSet rs = st.executeQuery()) {
				if (rs.next()) {
					String cateid = rs.getString("Id");
					String name = rs.getString("Name");
					result = new Categories(cateid, name);
				}
			}
		} catch (SQLException e) {
			System.err.println("Error in selectById: " + e.getMessage());
		}
		return result;
	}

	public int insert(Categories cate) {
		int result = 0;
		String sql = "INSERT INTO CATEGORIES (Id, Name) VALUES (?, ?)";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			System.out.println("Id: " + cate.getId());
			System.out.println("Name: " + cate.getName());
			if (cate.getId() == null || cate.getName() == null) {
				System.err.println("Error: Id or Name is null!");
				return result;
			}
			st.setString(1, cate.getId());
			st.setString(2, cate.getName());
			result = st.executeUpdate();
			System.out.println("Inserted: " + result + " rows.");
		} catch (SQLException e) {
			System.err.println("Error in insert: " + e.getMessage());
		}
		return result;
	}

	public int deleteById(String id) {
		int result = 0;
		String sql = "DELETE FROM CATEGORIES WHERE Id=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			result = st.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Error in deleteById: " + e.getMessage());
		}
		return result;
	}

	public int update(Categories cate) {
		int result = 0;
		String sql = "UPDATE CATEGORIES SET Name=? WHERE Id=?";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, cate.getName());
			st.setString(2, cate.getId());
			result = st.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Error in update: " + e.getMessage());
		}
		return result;
	}
}
