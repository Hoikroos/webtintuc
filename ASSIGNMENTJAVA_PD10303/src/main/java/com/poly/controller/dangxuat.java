package com.poly.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.poly.dao.NewsDAO;
import com.poly.entity.News;

/**
 * Servlet implementation class dangxuat
 */
@WebServlet("/out")
public class dangxuat extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public dangxuat() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<News> newsList = new ArrayList<>();
		// Khởi tạo đối tượng DAO nếu chưa có
		NewsDAO newsDAO = new NewsDAO();
		// Đăng xuất người dùng và hủy session (chỉ xóa dữ liệu người dùng)
		HttpSession session = request.getSession();
		session.invalidate(); // Xóa toàn bộ session liên quan đến người dùng
		// Truy vấn lại dữ liệu không liên quan đến người dùng (ví dụ danh sách tin tức)
		ArrayList<News> newsListt = newsDAO.selectAll();
		ArrayList<News> latestNews = newsDAO.getLatestNews();
		ArrayList<News> topViewedNews = newsDAO.getTopViewedNews();
		// Lưu dữ liệu vào request để chuyển tiếp đến trang chính
		request.setAttribute("newsList", newsListt);
		request.setAttribute("latestNews", latestNews);
		request.setAttribute("topViewedNews", topViewedNews);
		// Chuyển hướng người dùng về trang chính sau khi đăng xuất
		RequestDispatcher dispatcher = request.getRequestDispatcher("/html/ass.jsp");
		dispatcher.forward(request, response);
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
