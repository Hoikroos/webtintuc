package com.poly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.poly.dao.UserDAO;
import com.poly.entity.User;

@WebServlet(urlPatterns = { "/user", "/user/edit/*", "/user/insert", "/user/update", "/user/delete/*", "/user/reset" })
public class UsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User form = new User();
		UserDAO dao = new UserDAO();
		String path = req.getServletPath();
		if (path.contains("edit")) {
			String id = req.getPathInfo() != null ? req.getPathInfo().substring(1) : req.getParameter("id");
			if (id != null && !id.isEmpty()) {
				form = dao.selectById(id);
			}
		} else if (path.contains("insert")) {
			try {
				BeanUtils.populate(form, req.getParameterMap());
			} catch (Exception e) {
				e.printStackTrace();
			}
			String birthdayStr = req.getParameter("birthday");
			if (birthdayStr != null && !birthdayStr.isEmpty()) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				try {
					Date birthday = sdf.parse(birthdayStr);
					form.setBirthday(birthday);
				} catch (ParseException e) {
					System.out.println("Lỗi khi chuyển đổi ngày sinh: " + e.getMessage());
				}
			} else {
				form.setBirthday(null);
			}

			String mobile = req.getParameter("mobile");
			if (mobile == null || mobile.isEmpty()) {
				form.setMobile("");
			} else {
				form.setMobile(mobile);
			}

			String email = req.getParameter("email");
			if (email == null || email.isEmpty()) {
				form.setEmail("");
			} else {
				form.setEmail(email);
			}

			String genderStr = req.getParameter("gender");
			if (genderStr != null) {
				form.setGender(Boolean.parseBoolean(genderStr));
			} else {
				form.setGender(false);
			}

			String roleStr = req.getParameter("role");
			if (roleStr != null) {
				form.setRole(Boolean.parseBoolean(roleStr));
			} else {
				form.setRole(false);
			}

			dao.insert(form);
			form = new User();
		} else if (path.contains("update")) {
			try {
				BeanUtils.populate(form, req.getParameterMap());
			} catch (Exception e) {
				e.printStackTrace();
			}

			String id = req.getParameter("id");
			if (id != null && !id.isEmpty()) {
				form.setId(id);
			}

			String birthdayStr = req.getParameter("birthday");
			if (birthdayStr != null && !birthdayStr.isEmpty()) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				try {
					Date birthday = sdf.parse(birthdayStr);
					form.setBirthday(birthday);
				} catch (ParseException e) {
					System.out.println("Lỗi khi chuyển đổi ngày sinh: " + e.getMessage());
				}
			} else {
				form.setBirthday(null);
			}

			String mobile = req.getParameter("mobile");
			if (mobile == null || mobile.isEmpty()) {
				form.setMobile("");
			} else {
				form.setMobile(mobile);
			}
			String email = req.getParameter("email");
			if (email == null || email.isEmpty()) {
				form.setEmail("");
			} else {
				form.setEmail(email);
			}

			String genderStr = req.getParameter("gender");
			if (genderStr != null) {
				form.setGender(Boolean.parseBoolean(genderStr));
			} else {
				form.setGender(false);
			}

			String roleStr = req.getParameter("role");
			if (roleStr != null) {
				form.setRole(Boolean.parseBoolean(roleStr));
			} else {
				form.setRole(false);
			}

			System.out.println("ID: " + form.getId());
			System.out.println("Birthday: " + form.getBirthday());
			System.out.println("Mobile: " + form.getMobile());
			System.out.println("Email: " + form.getEmail());

			dao.update(form);
		} else if (path.contains("delete")) {
			String id = req.getParameter("id");
			System.out.println("Xác nhận ID User cần xóa: " + id);
			if (id != null && !id.trim().isEmpty()) {
				int deleteResult = dao.deleteById(id);
				if (deleteResult > 0) {
					System.out.println("ID: " + id + "Xóa thành công.");
				} else {
					System.out.println("ID: " + id + " Xóa thất bại");
				}
			} else {
				System.out.println("No ID provided for deletion.");
			}
			form = new User();
		}
		req.setAttribute("item", form);
		List<User> list = dao.selectAll();
		req.setAttribute("list", list);
		req.getRequestDispatcher("/html/User.jsp").forward(req, resp);
	}

}
