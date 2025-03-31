package com.poly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.poly.dao.NewsDAO;
import com.poly.entity.News;

/**
 * Servlet implementation class NewView
 */
@WebServlet("/news-display")
public class NewView extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewView() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	private NewsDAO newsService;
	private static final Logger logger = Logger.getLogger(NewsDAO.class.getName());

	@Override
	public void init() throws ServletException {
		newsService = new NewsDAO(); // Khởi tạo lớp dịch vụ
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String newsId = request.getParameter("id");
		News news = newsService.getNewsById(newsId).orElse(null); // Truy xuất bài viết theo ID
		if (news != null) {
			// Kiểm tra xem categoryid có null không
			if (news.getCategoryid() == null || news.getCategoryid().getId() == null) {
				logger.warning("ID tin tức trống: " + newsId);
				// Có thể thêm logic xử lý tại đây, chẳng hạn như thông báo cho người dùng
				response.sendError(HttpServletResponse.SC_NOT_FOUND); // Không tìm thấy bài viết
				return;
			}
			// Lấy tin cùng loại dựa trên danh mục của tin tức hiện tại
			List<News> relatedNews = newsService.getRelatedNews(news.getCategoryid());
			request.setAttribute("relatedNews", relatedNews); // Gán tin cùng loại vào request

			request.setAttribute("news", news); // Gán đối tượng news cho JSP
			request.getRequestDispatcher("/html/hienthibao.jsp").forward(request, response); // Chuyển hướng đến JSP
		} else {
			response.sendError(HttpServletResponse.SC_NOT_FOUND); // Không tìm thấy bài viết
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
