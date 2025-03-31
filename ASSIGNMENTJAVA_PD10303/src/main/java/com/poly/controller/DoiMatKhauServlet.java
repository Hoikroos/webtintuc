package com.poly.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.poly.dao.UserDAO;
import com.poly.entity.User;

/**
 * Servlet implementation class DoiMatKhauServlet
 */
@WebServlet("/doimatkhau")
public class DoiMatKhauServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DoiMatKhauServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String matkhaucu = req.getParameter("matkhaucu");
		String matkhaumoi = req.getParameter("matkhaumoi");
		String nhaplaimatkhau = req.getParameter("nhaplaimatkhau");

		UserDAO userDAO = new UserDAO();
		User user = userDAO.findByEmail(email);

		if (user != null) {
			if (user.getPassword().equals(matkhaucu)) {
				if (matkhaumoi.equals(nhaplaimatkhau)) {
					user.setPassword(matkhaumoi);
					boolean result = userDAO.changePassword(user);

					if (result) {
						req.setAttribute("message", "Mật khẩu đã được thay đổi thành công.");
						resp.sendRedirect(req.getContextPath() + "/ass");
					} else {
						req.setAttribute("error", "Không thể đổi mật khẩu. Vui lòng thử lại.");
						forwardToChangePasswordPage(req, resp);
					}
				} else {
					req.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
					forwardToChangePasswordPage(req, resp);
				}
			} else {
				req.setAttribute("error", "Mật khẩu cũ không chính xác.");
				forwardToChangePasswordPage(req, resp);
			}
		} else {
			req.setAttribute("error", "Email không tồn tại.");
			forwardToChangePasswordPage(req, resp);
		}
	}

	private void forwardToChangePasswordPage(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/html/doimatkhau.jsp");
		rd.forward(req, resp);
	}

}
