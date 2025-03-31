package com.poly.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.poly.dao.NewsDAO;
import com.poly.entity.News;

/**
 * Servlet implementation class index
 */
@WebServlet("/ass")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NewsDAO newsDAO = new NewsDAO();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public index() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ServletContext application = request.getServletContext();

		// Lấy danh sách tin tức thuộc category C01 (văn hóa)
		List<News> cultureNews = (List<News>) application.getAttribute("cultureNews");
		if (cultureNews == null) {
			cultureNews = newsDAO.getNewsByCategory("C01");
			System.out.println("Số lượng của tin tức văn hóa: " + cultureNews.size());
			application.setAttribute("cultureNews", cultureNews != null ? cultureNews : new ArrayList<News>());
		}

		// Lấy danh sách tin tức thuộc category C02 (pháp luật)
		List<News> lawsNews = (List<News>) application.getAttribute("lawsNews");
		if (lawsNews == null) {
			lawsNews = newsDAO.getNewsByCategory("C02");
			System.out.println("Số lượng của tin tức pháp luật: " + lawsNews.size());
			application.setAttribute("lawsNews", lawsNews != null ? lawsNews : new ArrayList<News>());
		}

		// Lấy danh sách tin tức thuộc category C03 (thể thao)
		List<News> sportsNews = (List<News>) application.getAttribute("sportsNews");
		if (sportsNews == null) {
			sportsNews = newsDAO.getNewsByCategory("C03");
			System.out.println("Số lượng của tin tức thể thao: " + sportsNews.size());
			application.setAttribute("sportsNews", sportsNews != null ? sportsNews : new ArrayList<News>());
		}

		// Lấy danh sách tin tức thuộc category C04 (Giáo dục)
		List<News> educationsNews = (List<News>) application.getAttribute("educationsNews");
		if (educationsNews == null) {
			educationsNews = newsDAO.getNewsByCategory("C04");
			System.out.println("Số lượng của tin tức giáo dục: " + educationsNews.size());
			application.setAttribute("educationsNews", educationsNews != null ? educationsNews : new ArrayList<News>());
		}

		// Lấy danh sách tin tức thuộc category C05 (Chính trị)
		List<News> politicsNews = (List<News>) application.getAttribute("politicsNews");
		if (politicsNews == null) {
			politicsNews = newsDAO.getNewsByCategory("C05");
			System.out.println("Số lượng của tin tức chính trị: " + politicsNews.size());
			application.setAttribute("politicsNews", politicsNews != null ? politicsNews : new ArrayList<News>());
		}

		// Lấy toàn bộ danh sách tin tức từ cơ sở dữ liệu
		ArrayList<News> newsList = (ArrayList<News>) application.getAttribute("newsList");

		if (newsList == null) {
			// Lấy tất cả tin tức từ cơ sở dữ liệu
			newsList = newsDAO.selectAll();

			// Tạo danh sách tạm để lưu các tin tức có home = true
			ArrayList<News> filteredNewsList = new ArrayList<>();

			// Lọc danh sách để chỉ lấy những bản tin có home = true
			for (News news : newsList) {
				if (news.isHome()) {
					System.out.println("News: " + news.getTitle() + " - Home: " + news.isHome());
					filteredNewsList.add(news);
				}
			}

//			filteredNewsList.sort((news1, news2) -> news2.getPostedDate().compareTo(news1.getPostedDate()));
			int limit = 15;
			if (filteredNewsList.size() > limit) {
				filteredNewsList = new ArrayList<>(filteredNewsList.subList(0, limit));
			}
			application.setAttribute("newsList", filteredNewsList);
		}

		// Lấy 5 bản tin mới nhất
		ArrayList<News> latestNews = (ArrayList<News>) application.getAttribute("latestNews");
		if (latestNews == null) {
			latestNews = newsDAO.getLatestNews();
			System.out.println("Số lượng của tin tức mới nhất: " + latestNews.size());
			application.setAttribute("latestNews", latestNews);
		}

		// Lấy 5 bản tin có lượt xem cao nhất
		ArrayList<News> topViewedNews = (ArrayList<News>) application.getAttribute("topViewedNews");
		if (topViewedNews == null) {
			topViewedNews = newsDAO.getTopViewedNews();
			System.out.println("Số lượng của tin tức nhiều lượt xem: " + topViewedNews.size());
			application.setAttribute("topViewedNews", topViewedNews);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher("/html/ass.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		request.getRequestDispatcher("/html/ass.jsp").forward(request, response);
	}
}
