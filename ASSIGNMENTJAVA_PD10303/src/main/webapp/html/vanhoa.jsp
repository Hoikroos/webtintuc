<%@page import="com.poly.entity.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Báo Văn Hóa</title>
<link rel="icon" href="/ASSIGNMENTJAVA_PD10303/image/newspaper.png">
<link rel="stylesheet" href="/ASSIGNMENTJAVA_PD10303/CSS/trangthai.css">
<style>
/* Dropdown Menu - Updated to match the image */
.dropdown-container {
	position: relative;
	height: 100%;
	margin-left: auto;
}

.dropdown-toggle {
	color: white;
	background: none;
	border: none;
	cursor: pointer;
	font-weight: 500;
	font-size: 16px;
	padding: 0 20px;
	height: 100%;
	display: flex;
	align-items: center;
}

.dropdown-toggle:hover {
	background-color: rgba(255, 255, 255, 0.1);
}

.dropdown-menu {
	display: none;
	position: absolute;
	top: 100%;
	right: 0;
	background: #0066cc; /* Màu xanh dương giống như trong hình */
	border: none;
	border-radius: 4px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
	min-width: 180px;
	z-index: 1000;
	margin-top: 0;
	overflow: hidden;
}

.dropdown-menu.show {
	display: block;
}

.dropdown-item {
	display: block;
	padding: 12px 15px;
	color: white !important; /* Chữ màu trắng */
	text-decoration: none;
	font-size: 14px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	transition: background-color 0.2s;
}

.dropdown-item:hover {
	background-color: rgba(255, 255, 255, 0.1);
}

.dropdown-divider {
	height: 1px;
	background-color: rgba(255, 255, 255, 0.1);
	margin: 0;
}
</style>
</head>
<body>
	<div class="container">
		<header>
			<div class="anhnen">
				<img src="/ASSIGNMENTJAVA_PD10303/image/bao.png" alt="" width="1200"
					height="335">
			</div>
		</header>
		<nav>
			<a href="/ASSIGNMENTJAVA_PD10303/ass"><img
				src="/ASSIGNMENTJAVA_PD10303/image/home.png" alt="Home"></a> <a
				href="/ASSIGNMENTJAVA_PD10303/html/vanhoa.jsp">Văn hóa</a> <a
				href="/ASSIGNMENTJAVA_PD10303/html/phapluat.jsp">Pháp luật</a> <a
				href="/ASSIGNMENTJAVA_PD10303/html/thethao.jsp">Thể thao</a> <a
				href="/ASSIGNMENTJAVA_PD10303/html/giaoduc.jsp">Giáo dục</a> <a
				href="/ASSIGNMENTJAVA_PD10303/html/chinhtri.jsp">Chính trị</a>

			<%
			User user = null;
			if (session != null) {
				user = (User) session.getAttribute("khachHang");
			}
			if (user != null) {
			%>
			<div class="dropdown-container">
				<button class="dropdown-toggle"><%=user.getFullname()%>
					▼
				</button>
				<div class="dropdown-menu">
					<a class="dropdown-item"
						href="/ASSIGNMENTJAVA_PD10303/html/doimatkhau.jsp">Đổi mật
						khẩu</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item"
						href="/ASSIGNMENTJAVA_PD10303/new">Công cụ quản
						trị</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item"
						href="${pageContext.request.contextPath}/out">Đăng Xuất</a>
				</div>
			</div>
			<%
			} else {
			%>
			<a class="btn btn-primary"
				href="/ASSIGNMENTJAVA_PD10303/html/login.jsp">Đăng nhập</a>
			<%
			}
			%>
		</nav>
		<article>
			<div class="pl">
				<c:forEach var="newsItem" items="${cultureNews}">
					<div class="trang">
						<div class="title">
							<a
								href="${pageContext.request.contextPath}/news-display?id=${newsItem.id}">
								<p style="font-size: 16px;">${newsItem.title}</p>
							</a>
						</div>
						<div class="imagevh">
							<a
								href="${pageContext.request.contextPath}/news-display?id=${newsItem.id}">
								<img src="/ASSIGNMENTJAVA_PD10303/${newsItem.image}" alt=""
								width="300" height="170">
							</a>
						</div>
						<div class="content">
							<a
								href="${pageContext.request.contextPath}/news-display?id=${newsItem.id}">
								<p style="font-size: 10px;">${fn:substring(newsItem.content, 0, 200)}</p>
							</a>
						</div>
						<div class="date">
							Ngày đăng:
							<fmt:formatDate value="${newsItem.postedDate}"
								pattern="dd/MM/yyyy" />
						</div>
						<div class="author">Tác giả: ${newsItem.author}</div>
					</div>
				</c:forEach>

				<!-- Thông báo nếu không có tin tức nào -->
				<c:if test="${empty cultureNews}">
					<p>Không có tin tức văn hóa nào để hiển thị.</p>
				</c:if>
			</div>
		</article>
		<footer>
			<div class="phancuoi">
				<div class="khung">
					<h3>Thông tin về tổng biên tập</h3>
					<a> - Hải Hưng, Hải Lăng, Quảng Trị <br> - Hotline:
						0969231454 <br> - FB: Võ Đình Hội <br> - Email:
						vodinhhoi1@gmail.com
					</a>
				</div>
				<div class="khung1">
					<h3>Chăm sóc khách hàng</h3>
					<a href="#">- Tổng đài tư vấn</a><a href="#">- Liên hệ</a><a
						href="#">- Hỗ trợ</a>
				</div>
				<div class="khung2">
					<h3>Kết nối với VDH New</h3>
					<a href="https://www.facebook.com/profile.php?id=100014716925138"><img
						src="/ASSIGNMENTJAVA_PD10303/image/social-media.png" alt=""></a>
					<a href="https://mail.google.com/mail/u/0/?hl=vi#inbox"><img
						src="/ASSIGNMENTJAVA_PD10303/image/email.png" alt=""></a> <a
						href="https://www.instagram.com/"><img
						src="/ASSIGNMENTJAVA_PD10303/image/instagram.png" alt=""></a> <a
						href="https://www.tiktok.com/"><img
						src="/ASSIGNMENTJAVA_PD10303/image/tik-tok.png" alt=""></a>
				</div>
				<div class="khung3">
					<h3>Trụ Sở</h3>
					<a href="#">- Giới thiệu</a><a href="#">- Tin tức</a><a href="#">-
						Tuyển dụng</a><a href="#">- Hệ thống công ty</a>
				</div>
			</div>
		</footer>
	</div>
	<!-- JavaScript for dropdown functionality -->
	<script>
	document.addEventListener("DOMContentLoaded", function() {
		// Dropdown functionality
		const dropdownToggles = document.querySelectorAll(".dropdown-toggle");

		dropdownToggles.forEach((toggle) => {
			toggle.addEventListener("click", function(event) {
				event.preventDefault();
				event.stopPropagation();

				const dropdownMenu = this.nextElementSibling;

				// Toggle dropdown
				if (dropdownMenu.classList.contains("show")) {
					dropdownMenu.classList.remove("show");
				} else {
					// Close all other dropdowns
					document.querySelectorAll(".dropdown-menu").forEach((menu) => {
						menu.classList.remove("show");
					});

					// Open this dropdown
					dropdownMenu.classList.add("show");
				}
			});
		});

		// Close dropdowns when clicking outside
		document.addEventListener("click", (event) => {
			if (!event.target.closest(".dropdown-container")) {
				document.querySelectorAll(".dropdown-menu").forEach((menu) => {
					menu.classList.remove("show");
				});
			}
		});
		
		// Close dropdowns when window is resized
		window.addEventListener("resize", function() {
			document.querySelectorAll(".dropdown-menu").forEach((menu) => {
				menu.classList.remove("show");
			});
		});
	});
	</script>
</body>
</html>