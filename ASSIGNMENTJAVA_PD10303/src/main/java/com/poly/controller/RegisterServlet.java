package com.poly.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.Random;

import com.poly.dao.UserDAO;
import com.poly.entity.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public RegisterServlet() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher("/html/register.jsp");
		rd.forward(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Get form parameters
		String id = req.getParameter("id");
		String password = req.getParameter("password");
		String cpassword = req.getParameter("cpassword");
		String fullname = req.getParameter("fullname");
		String birthday = req.getParameter("birthday");
		String genderStr = req.getParameter("gender");
		String mobile = req.getParameter("mobile");
		String email = req.getParameter("email");
		boolean gender = "male".equalsIgnoreCase(genderStr);

		String url = "";
		String baoLoi = "";
		UserDAO userDAO = new UserDAO();

		if (userDAO.existsById(id)) {
			baoLoi += "ID đã tồn tại, vui lòng chọn ID khác.";
		}

		if (userDAO.checkUsernameExists(email)) {
			baoLoi += "Email đã được sử dụng, vui lòng chọn email khác.";
		}

		if (!password.equals(cpassword)) {
			baoLoi += "Mật khẩu không khớp.<br/>";
		}

		req.setAttribute("baoLoi", baoLoi);

		if (baoLoi.length() > 0) {
			url = "/html/register.jsp";
		} else {
			User user = new User();
			user.setId(id);
			user.setPassword(password);
			user.setFullname(fullname);
			user.setBirthday(Date.valueOf(birthday));
			user.setGender(gender);
			user.setMobile(mobile);
			user.setEmail(email);
			user.setRole(false);
			int result = userDAO.insert(user);
			if (result > 0) {
				url = "/html/login.jsp";
			} else {
				baoLoi = "Đăng ký thất bại, vui lòng thử lại.";
				req.setAttribute("baoLoi", baoLoi);
				url = "/html/register.jsp";
			}
		}

		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}
}