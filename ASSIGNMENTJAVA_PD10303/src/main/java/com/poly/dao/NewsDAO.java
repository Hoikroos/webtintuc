package com.poly.dao;

import java.util.logging.Logger;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.poly.entity.Categories;
import com.poly.entity.News;
import com.poly.utils.Jdbc;

public class NewsDAO {
	public ArrayList<News> selectAll() {
		ArrayList<News> results = new ArrayList<>();
		String sql = "SELECT n.*, u.FullName AS AuthorName, c.Id AS CategoryId, c.Name AS CategoryName "
				+ "FROM NEWS n " + "JOIN USERS u ON n.Author = u.Id " + "JOIN CATEGORIES c ON n.CategoryId = c.Id";

		try (Connection con = Jdbc.getConnection();
				PreparedStatement st = con.prepareStatement(sql);
				ResultSet rs = st.executeQuery()) {
			while (rs.next()) {
				String id = rs.getString("Id");
				String title = rs.getString("Title");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				Date postedDate = rs.getDate("PostedDate");
				String authorId = rs.getString("Author");
				String authorName = rs.getString("AuthorName");
				int viewCount = rs.getInt("ViewCount");
				String categoryId = rs.getString("CategoryId");
				String categoryName = rs.getString("CategoryName");
				boolean home = rs.getBoolean("Home");
				Categories category = new Categories(categoryId, categoryName);
				News news = new News(id, title, content, image, postedDate, authorId, authorName, viewCount, category,
						home);
				results.add(news);
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong selectAll: " + e.getMessage());
		}

		return results;
	}

	public News selectById(String id) {
		News result = null;
		String sql = "SELECT n.*, u.FullName as AuthorName, c.Id as categoryId, c.Name as categoryName "
				+ "FROM NEWS n " + "JOIN CATEGORIES c ON n.CategoryId = c.Id "
				+ "JOIN USERS u ON n.Author = u.Id WHERE n.Id = ?";

		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			try (ResultSet rs = st.executeQuery()) {
				if (rs.next()) {
					String newId = rs.getString("Id");
					String title = rs.getString("Title");
					String content = rs.getString("Content");
					String image = rs.getString("Image");
					Date postedDate = rs.getDate("PostedDate");
					String authorId = rs.getString("Author");
					String authorName = rs.getString("AuthorName");
					Integer viewCount = rs.getInt("ViewCount");
					String categoryId = rs.getString("categoryId");
					String categoryName = rs.getString("categoryName");
					Categories category = new Categories(categoryId, categoryName);
					Boolean home = rs.getBoolean("Home");
					result = new News(newId, title, content, image, postedDate, authorId, authorName, viewCount,
							category, home);
				}
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong selectById: " + e.getMessage());
		}
		return result;
	}

	public int insert(News news) {
		int result = 0;
		String sql = "INSERT INTO NEWS (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, news.getId());
			st.setString(2, news.getTitle());
			st.setString(3, news.getContent());
			st.setString(4, news.getImage());

			if (news.getPostedDate() != null) {
				st.setDate(5, new java.sql.Date(news.getPostedDate().getTime()));
			} else {
				st.setNull(5, java.sql.Types.DATE);
			}
			st.setString(6, news.getAuthor());
			st.setInt(7, news.getViewCount());

			if (news.getCategoryid() != null) {
				st.setString(8, news.getCategoryid().getId());
			} else {
				System.err.println("CategoryId trống!");
				return 0;
			}
			st.setInt(9, news.isHome() ? 1 : 0);

			result = st.executeUpdate();
			System.out.println("Inserted: " + result + " rows.");
		} catch (SQLException e) {
			System.err.println("lỗi ở insert: " + e.getMessage());
			e.printStackTrace();
		}

		return result;
	}

	public int deleteById(String id) {
		int result = 0;
		String sql = "DELETE FROM NEWS WHERE Id=?";
		System.out.println("Thực hiện SQL: " + sql + " with ID: " + id);

		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, id);
			result = st.executeUpdate();
			System.out.println("Delete result: " + result);

			if (result == 1) {
				System.out.println("News với ID " + id + " xóa thành công.");
			} else {
				System.out.println("News với ID " + id + " thất bại.");
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong deleteById: " + e.getMessage());
		}
		return result;
	}

	public int update(News news) {
		int result = 0;
		String sql = "UPDATE NEWS SET Title=?, Content=?, Image=?, PostedDate=?, Author=?, ViewCount=?, CategoryId=?, Home=? WHERE Id=?";

		try (Connection con = Jdbc.getConnection(); PreparedStatement st = con.prepareStatement(sql)) {
			st.setString(1, news.getTitle());
			st.setString(2, news.getContent());
			st.setString(3, news.getImage());

			if (news.getPostedDate() != null) {
				st.setDate(4, new java.sql.Date(news.getPostedDate().getTime()));
			} else {
				st.setNull(4, java.sql.Types.DATE);
			}

			st.setString(5, news.getAuthor());
			st.setInt(6, news.getViewCount());

			if (news.getCategoryid() != null && news.getCategoryid().getId() != null) {
				st.setString(7, news.getCategoryid().getId());
			} else {
				st.setNull(7, java.sql.Types.VARCHAR);
			}

			st.setInt(8, news.isHome() ? 1 : 0);
			st.setString(9, news.getId());

			result = st.executeUpdate();
			System.out.println("Cập nhật thành công: " + result + " row(s) affected.");
		} catch (SQLException e) {
			System.err.println("Lỗi cập nhật: " + e.getMessage());
			e.printStackTrace();
		}

		return result;
	}

	public ArrayList<News> getLatestNews() {
		ArrayList<News> results = new ArrayList<>();
		String sql = "{CALL GetLatestNews()}"; // Call stored procedure

		try (Connection con = Jdbc.getConnection()) {
			CallableStatement st = con.prepareCall(sql);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				String id = rs.getString("Id");
				String title = rs.getString("Title");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				Date postedDate = rs.getDate("PostedDate");
				String authorId = rs.getString("Author");
				int viewCount = rs.getInt("ViewCount");
				String categoryId = rs.getString("CategoryId");
				String categoryName = rs.getString("CategoryName");
				boolean home = rs.getBoolean("Home");
				Categories category = new Categories(categoryId, categoryName);
				News news = new News(id, title, content, image, postedDate, authorId, null, viewCount, category, home);
				results.add(news);
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong getLatestNews: " + e.getMessage());
		}

		return results;
	}

	public ArrayList<News> getTopViewedNews() {
		ArrayList<News> results = new ArrayList<>();
		String sql = "{CALL GetTopViewedNews()}"; // Call stored procedure

		try (Connection con = Jdbc.getConnection();
				CallableStatement st = con.prepareCall(sql);
				ResultSet rs = st.executeQuery()) {

			while (rs.next()) {
				String id = rs.getString("Id");
				String title = rs.getString("Title");
				String content = rs.getString("Content");
				String image = rs.getString("Image");
				Date postedDate = rs.getDate("PostedDate");
				String authorId = rs.getString("Author");
				String authorName = "";
				int viewCount = rs.getInt("ViewCount");
				String categoryId = rs.getString("CategoryId");
				String categoryName = rs.getString("CategoryName");
				boolean home = rs.getBoolean("Home");
				Categories category = new Categories(categoryId, categoryName);
				News news = new News(id, title, content, image, postedDate, authorId, authorName, viewCount, category,
						home);
				results.add(news);
			}
		} catch (SQLException e) {
			System.err.println("Lỗi trong getTopViewedNews: " + e.getMessage());
		}

		return results;
	}

	public ArrayList<News> getRecentlyViewedNewsByUser(int userId) {
		ArrayList<News> results = new ArrayList<>();
		String sql = "{CALL GetRecentlyViewedNewsByUser(?)}"; // Call stored procedure

		try (Connection con = Jdbc.getConnection(); CallableStatement st = con.prepareCall(sql)) {

			st.setInt(1, userId);
			try (ResultSet rs = st.executeQuery()) {
				while (rs.next()) {
					String id = rs.getString("Id");
					String title = rs.getString("Title");
					String content = rs.getString("Content");
					String image = rs.getString("Image");
					Date postedDate = rs.getDate("PostedDate");
					String authorId = rs.getString("Author");
					String authorName = rs.getString("AuthorName");
					int viewCount = rs.getInt("ViewCount");
					String categoryId = rs.getString("CategoryId");
					String categoryName = rs.getString("CategoryName");
					boolean home = rs.getBoolean("Home");
					Categories category = new Categories(categoryId, categoryName);
					News news = new News(id, title, content, image, postedDate, authorId, authorName, viewCount,
							category, home);
					results.add(news);
				}
			}
		} catch (SQLException e) {
			System.err.println("Lỗi SQL trong getRecentlyViewedNewsByUser: " + e.getMessage());
		} catch (Exception e) {
			System.err.println("Lỗi chung trong getRecentlyViewedNewsByUser: " + e.getMessage());
		}

		return results;
	}

	private static final Logger logger = Logger.getLogger(NewsDAO.class.getName());

	public Optional<News> getNewsById(String id) {
		String sql = "SELECT Id, Title, Content, Image, CategoryId FROM NEWS WHERE Id = ?";

		try (Connection connection = Jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {

			stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				News news = new News();
				news.setId(rs.getString("Id"));
				news.setTitle(rs.getString("Title"));
				news.setContent(rs.getString("Content"));
				news.setImage(rs.getString("Image"));
				Categories category = new Categories();
				category.setId(rs.getString("CategoryId"));
				news.setCategoryid(category);
				return Optional.of(news);
			}
		} catch (SQLException e) {
			logger.severe("SQL Exception: " + e.getMessage());
		}

		return Optional.empty();
	}

	public List<News> getRelatedNews(Categories categoryid) {
		List<News> relatedNews = new ArrayList<>();
		String sql = "SELECT Id, Title, Content, Image FROM NEWS WHERE CategoryId = ?";

		try (Connection connection = Jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, categoryid.getId());
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				News news = new News();
				news.setId(rs.getString("Id"));
				news.setTitle(rs.getString("Title"));
				news.setContent(rs.getString("Content"));
				news.setImage(rs.getString("Image"));
				relatedNews.add(news);
			}

		} catch (SQLException e) {
			logger.severe("SQL Exception: " + e.getMessage());
		}

		return relatedNews;
	}

	public List<News> getNewsByCategory(String categoryId) {
		List<News> newsList = new ArrayList<>();
		String sql = "SELECT * FROM NEWS WHERE CategoryId = ?";
		try (Connection connection = Jdbc.getConnection(); PreparedStatement stmt = connection.prepareStatement(sql)) {
			stmt.setString(1, categoryId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				News news = new News();
				news.setId(rs.getString("Id"));
				news.setTitle(rs.getString("Title"));
				news.setContent(rs.getString("Content"));
				news.setImage(rs.getString("Image"));
				news.setPostedDate(rs.getDate("PostedDate"));
				news.setAuthor(rs.getString("Author"));
				newsList.add(news);
			}
			logger.info("Số lượng danh sách tin tức: " + newsList.size());
		} catch (SQLException e) {
			logger.severe("SQL Exception: " + e.getMessage());
		}

		return newsList;
	}

}