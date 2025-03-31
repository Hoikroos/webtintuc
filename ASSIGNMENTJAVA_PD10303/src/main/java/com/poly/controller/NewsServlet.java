package com.poly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.poly.dao.CategoriesDAO;
import com.poly.dao.NewsDAO;
import com.poly.entity.Categories;
import com.poly.entity.News;

/**
 * Servlet implementation class NewsServlet
 */
@WebServlet({ "/new", "/new/edit/*", "/new/insert", "/new/update", "/new/delete/*", "/new/reset" })
@MultipartConfig
public class NewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		NewsDAO newsDao = new NewsDAO();
		CategoriesDAO categoriesDao = new CategoriesDAO();
		String path = req.getServletPath();
		List<Categories> categoriesList = categoriesDao.selectAll();
		req.setAttribute("categoriesList", categoriesList);

		try {
			if (path.contains("edit")) {
				handleEdit(req, newsDao);
			} else if (path.contains("insert")) {
				handleInsert(req, newsDao);
			} else if (path.contains("update")) {
				handleUpdate(req, newsDao);
			} else if (path.contains("delete")) {
				handleDelete(req, newsDao);
			}
		} catch (Exception e) {
			handleError(req, resp, e);
			return;
		}

		List<News> list = newsDao.selectAll();
		req.setAttribute("list", list);

		req.getRequestDispatcher("/html/New.jsp").forward(req, resp);
	}

	private static final String SAVE_DIR = "/uploads";

	private String handleImageUpload(HttpServletRequest req, Part filePart) throws IOException {
		if (filePart != null && filePart.getSize() > 0) {
			String fileName = filePart.getSubmittedFileName();
			String appPath = req.getServletContext().getRealPath("");
			String savePath = appPath + File.separator + SAVE_DIR;
			File fileSaveDir = new File(savePath);
			if (!fileSaveDir.exists()) {
				fileSaveDir.mkdirs();
			}
			filePart.write(savePath + File.separator + fileName);
			return SAVE_DIR + File.separator + fileName;
		}
		return null;
	}

	private void handleEdit(HttpServletRequest req, NewsDAO newsDao) throws Exception {
		String id = req.getParameter("id");
		if (id != null && !id.isEmpty()) {
			News form = newsDao.selectById(id);
			if (form != null) {
				req.setAttribute("item", form);
			} else {
				req.setAttribute("errorMessage", "Không tìm thấy ID tin tức");
			}
		} else {
			req.setAttribute("errorMessage", "Cần phải có ID tin tức để chỉnh sửa.");
		}
	}

	private void handleInsert(HttpServletRequest req, NewsDAO newsDao) throws Exception {
		News form = populateForm(req);
		if (validateForm(req, form)) {
			Part filePart = req.getPart("image");
			String fileName = handleImageUpload(req, filePart);
			if (fileName != null) {
				form.setImage(fileName);
			}
			int insertResult = newsDao.insert(form);
			if (insertResult > 0) {
				req.setAttribute("successMessage", "Thêm mới thành công!");
			} else {
				req.setAttribute("errorMessage", "Thêm mới thất bại.");
			}
		}
	}

	private void handleUpdate(HttpServletRequest req, NewsDAO newsDao) throws Exception {
		News form = populateForm(req);
		String id = req.getParameter("id");

		if (id != null && !id.isEmpty()) {
			form.setId(id);
			Part filePart = req.getPart("image");
			String fileName = handleImageUpload(req, filePart);
			if (fileName != null) {
				form.setImage(fileName);
			}
			int updateResult = newsDao.update(form);
			if (updateResult > 0) {
				req.setAttribute("successMessage", "Cập nhật thành công!");
			} else {
				req.setAttribute("errorMessage", "Cập nhật thất bại");
			}
		} else {
			req.setAttribute("errorMessage", "Cần có ID để cập nhật.");
		}
	}

	private void handleDelete(HttpServletRequest req, NewsDAO newsDao) throws Exception {
		String id = req.getParameter("id");
		if (id != null && !id.trim().isEmpty()) {
			newsDao.deleteById(id);
			req.setAttribute("successMessage", "Xóa thành công");
		} else {
			req.setAttribute("errorMessage", "ID không rỗng hoặc trống để xóa.");
		}
	}

	private News populateForm(HttpServletRequest req) throws ParseException {
		News form = new News();

		try {
			BeanUtils.populate(form, req.getParameterMap());
			String postedDateStr = req.getParameter("posted");
			if (postedDateStr != null && !postedDateStr.isEmpty()) {
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				form.setPostedDate(new Date(dateFormat.parse(postedDateStr).getTime()));
			} else {
				form.setPostedDate(new Date());
			}
			String categoryIdStr = req.getParameter("categoryId");
			if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
				Categories category = new Categories();
				category.setId(categoryIdStr);
				form.setCategoryid(category);
			}
			String authorIdStr = req.getParameter("authorId");
			if (authorIdStr != null && !authorIdStr.isEmpty()) {
				form.setAuthor(authorIdStr);
			}
		} catch (Exception e) {
			throw new RuntimeException("Error populating form: " + e.getMessage(), e);
		}
		return form;
	}

	private boolean validateForm(HttpServletRequest req, News form) throws ServletException, IOException {
		boolean isValid = true;
		if (form.getCategoryid() == null || form.getCategoryid().getId() == null) {
			req.setAttribute("errorMessage", "Vui lòng chọn danh mục");
			isValid = false;
		}
		if (form.getAuthor() == null || form.getAuthor().isEmpty()) {
			req.setAttribute("errorMessage", "Cần phải có ID tác giả");
			isValid = false;
		}
		req.setAttribute("item", form);
		return isValid;
	}

	private void handleError(HttpServletRequest req, HttpServletResponse resp, Exception e)
			throws ServletException, IOException {
		req.setAttribute("errorMessage", "Đã xảy ra lỗi khi xử lý yêu cầu của bạn:" + e.getMessage());
		req.getRequestDispatcher("/html/New.jsp").forward(req, resp);
	}
}
