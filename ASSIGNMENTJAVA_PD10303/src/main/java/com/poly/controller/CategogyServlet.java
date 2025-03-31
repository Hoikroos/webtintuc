package com.poly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.poly.dao.CategoriesDAO;
import com.poly.entity.Categories;
import com.poly.entity.User;

/**
 * Servlet implementation class CategogyServlet
 */
@WebServlet(urlPatterns = { "/catego", "/catego/edit/*", "/catego/insert", "/catego/update", "/catego/delete/*",
		"/catego/reset" })
public class CategogyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CategogyServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Categories form = new Categories();
		CategoriesDAO dao = new CategoriesDAO();
		String path = req.getServletPath();
		try {
			BeanUtils.populate(form, req.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (path.contains("edit")) {
			String pathInfo = req.getPathInfo();
			if (pathInfo != null && pathInfo.length() > 1) {
				String id = pathInfo.substring(1);
				form = dao.selectById(id);
				if (form == null) {
					System.out.println("Không tìm thấy danh mục nào có ID: " + id);
					req.setAttribute("errorMessage", "Không tìm thấy danh mục nào có ID: " + id);
				}
			} else {
				System.out.println("PathInfo là null hoặc không hợp lệ");
				req.setAttribute("errorMessage", "ID không hợp lệ");
			}
		} else if (path.contains("insert")) {
			String id = req.getParameter("id");
			String name = req.getParameter("name");
			form.setId(id);
			form.setName(name);
			dao.insert(form);
			form = new Categories();
		} else if (path.contains("update")) {
			int updatedRows = dao.update(form);
			if (updatedRows > 0) {
				System.out.println("Cập nhật thành công");
			} else {
				System.out.println("Cập nhật thất bại");
			}
			form = new Categories();
		} else if (path.contains("delete")) {
			dao.deleteById(form.getId());
			form = new Categories();
		}
		req.setAttribute("item", form);
		List<Categories> list = dao.selectAll();
		req.setAttribute("list", list);
		req.getRequestDispatcher("/html/Caretory.jsp").forward(req, resp);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
