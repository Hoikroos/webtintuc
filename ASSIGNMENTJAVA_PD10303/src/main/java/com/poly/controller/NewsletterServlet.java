package com.poly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import com.poly.dao.NewslettersDAO;
import com.poly.entity.Categories;
import com.poly.entity.Newsletters;

/**
 * Servlet implementation class NewsletterServlet
 */
@WebServlet(urlPatterns = { "/newsletter", "/newsletter/edit/*", "/newsletter/update", "/newsletter/reset" })
public class NewsletterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewsletterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Newsletters form = new Newsletters();
		try {
			BeanUtils.populate(form, req.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		NewslettersDAO dao = new NewslettersDAO();
		String path = req.getServletPath();
		if (path.contains("edit")) {
			String email = req.getPathInfo().substring(1);
			form = dao.selectById(email);

		} else if (path.contains("update")) {
			dao.update(form);
		} else if (path.contains("delete")) {
			dao.deleteById(form.getEmail());
			form = new Newsletters();
		} else {
			form = new Newsletters();
		}
		req.setAttribute("item", form);
		List<Newsletters> list = dao.selectAll();
		req.setAttribute("list", list);
		req.getRequestDispatcher("/html/newsletter.jsp").forward(req, resp);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
