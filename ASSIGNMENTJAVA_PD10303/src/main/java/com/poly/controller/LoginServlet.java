package com.poly.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.poly.dao.UserDAO;
import com.poly.entity.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("username");
		String password = req.getParameter("password");

		User user = new User();
		user.setEmail(email);
		user.setPassword(password);

		UserDAO userDao = new UserDAO();
		User authenticatedUser = userDao.selectByEmailAndPassword(user);

		if (authenticatedUser != null) {
			HttpSession session = req.getSession();
			session.setAttribute("khachHang", authenticatedUser);
			resp.sendRedirect(req.getContextPath() + "/ass");
		} else {
			req.setAttribute("baoLoi", "Tên đăng nhập hoặc mật khẩu không đúng!");
			RequestDispatcher rd = req.getRequestDispatcher("/html/login.jsp");
			rd.forward(req, resp);
		}
	}
}
