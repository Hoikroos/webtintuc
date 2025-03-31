<%@page import="com.poly.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang tin tức</title>
<link rel="icon" href="/ASSIGNMENTJAVA_PD10303/image/newspaper.png">
<link rel="stylesheet" href="/ASSIGNMENTJAVA_PD10303/CSS/new.css">
<style>
/* Base Styles */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
	background-color: #fff;
	line-height: 1.6;
	color: #333;
}

.container {
	width: 1200px;
	max-width: 100%;
	margin: 0 auto;
	padding: 0 15px;
}

/* Header */
header {
	margin-bottom: 15px;
	overflow: hidden;
}

.anhnen img {
	width: 100%;
	height: auto;
	display: block;
}

/* Navigation */
nav {
	background: linear-gradient(135deg, #0062cc, #007bff);
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 25px;
	height: 65px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	border-radius: 10px;
	position: sticky;
	top: 10px;
	z-index: 100;
	margin-bottom: 20px;
}

nav a {
	color: white;
	text-decoration: none;
	font-weight: 600;
	font-size: 16px;
	padding: 12px 18px;
	border-radius: 8px;
	transition: all 0.3s ease;
	position: relative;
}

nav a:hover {
	background-color: rgba(255, 255, 255, 0.15);
	transform: translateY(-3px);
	color: #fff;
	text-shadow: 0 0 5px rgba(255, 255, 255, 0.5);
}

nav a:after {
	content: '';
	position: absolute;
	width: 0;
	height: 3px;
	bottom: 0;
	left: 50%;
	background-color: #ffd700;
	transition: all 0.3s ease;
}

nav a:hover:after {
	width: 80%;
	left: 10%;
}

nav a.active {
	background-color: rgba(255, 255, 255, 0.2);
	color: #ffd700;
}

nav a img {
	height: 24px;
	width: auto;
	vertical-align: middle;
	margin-right: 5px;
	filter: drop-shadow(0 0 2px rgba(0, 0, 0, 0.3));
}

/* Dropdown Menu - Updated to match the previous design */
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
	background: #0066cc; /* Matches the blue color in previous design */
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
	color: white !important; /* White text */
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

.btn.btn-primary {
	background-color: #0056b3;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 8px;
	font-weight: 600;
	transition: all 0.3s ease;
	text-decoration: none;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.btn.btn-primary:hover {
	background-color: #004494;
	transform: translateY(-2px);
	box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
}

/* Main Content Layout */
.content-wrapper {
	display: flex;
	gap: 20px;
	margin-bottom: 30px;
}

article {
	flex: 1;
	width: 100%;
	background-color: white;
	margin-bottom: 30px;
}

aside {
	width: 300px;
	flex-shrink: 0;
}

/* News Grid */
.main-content {
	width: 100%;
}

.news-container {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
	margin-bottom: 30px;
}

.new {
	border: 1px solid #eee;
	border-radius: 0;
	overflow: hidden;
	background-color: white;
	transition: box-shadow 0.3s;
	height: 100%;
	display: flex;
	flex-direction: column;
}

.new:hover {
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.image {
	height: 180px;
	overflow: hidden;
}

.image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.3s;
}

.new:hover .image img {
	transform: scale(1.05);
}

.namenew {
	padding: 15px;
	flex-grow: 1;
	display: flex;
	flex-direction: column;
}

.namenew h4 {
	font-size: 16px;
	color: #222;
	margin: 0 0 10px 0;
	line-height: 1.4;
	font-weight: 600;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
}

.namenew a {
	text-decoration: none;
	color: #222;
}

.namenew h4:hover {
	color: #007bff;
}

.namenew p {
	font-size: 13px !important;
	color: #666;
	line-height: 1.5;
	margin-bottom: 15px;
	display: -webkit-box;
	-webkit-line-clamp: 3;
	-webkit-box-orient: vertical;
	overflow: hidden;
	text-overflow: ellipsis;
	flex-grow: 1;
}

.info-container {
	padding: 0 15px 15px;
}

.date-author {
	display: flex;
	justify-content: space-between;
	font-size: 11px;
	color: #888;
}

.date, .author {
	display: flex;
	align-items: center;
}

.date::before {
	content: "📅";
	margin-right: 5px;
	font-size: 10px;
}

.author::before {
	content: "✍️";
	margin-right: 5px;
	font-size: 10px;
}

/* Sidebar */
.sidebar .box {
	border: none;
	padding: 0;
	margin-bottom: 20px;
	background-color: white;
}

.section-title {
	font-size: 14px;
	font-weight: 700;
	text-transform: uppercase;
	margin: 0 0 15px 0;
	padding-bottom: 5px;
	border-bottom: 2px solid #e74c3c;
}

.boxnlx, .boxtmn, .boxtdx {
	display: flex;
	align-items: flex-start;
	margin-bottom: 10px;
	padding-bottom: 10px;
	border-bottom: 1px solid #eee;
}

.boxnlx:last-child, .boxtmn:last-child, .boxtdx:last-child {
	border-bottom: none;
	margin-bottom: 0;
	padding-bottom: 0;
}

.imgnlx, .imgtmn, .imgtdx {
	flex: 0 0 60px;
	overflow: hidden;
	margin-right: 10px;
}

.imgnlx img, .imgtmn img, .imgtdx img {
	width: 100%;
	height: 60px;
	object-fit: cover;
}

.namenlx, .nametmn, .nametdx {
	flex: 1;
}

.namenlx h5, .nametmn h5, .nametdx h5 {
	font-size: 12px;
	line-height: 1.3;
	margin: 0;
	font-weight: 600;
}

.namenlx a, .nametmn a, .nametdx a {
	color: #333;
	text-decoration: none;
}

.namenlx a:hover, .nametmn a:hover, .nametdx a:hover {
	color: #0056b3;
}

/* Footer */
footer {
	background-color: #f8f9fa;
	padding: 30px 0;
	border-top: 1px solid #eee;
	margin-top: 30px;
	clear: both;
}

.phancuoi {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 25px;
}

.khung, .khung1, .khung2, .khung3 {
	background-color: white;
	padding: 20px;
	border-radius: 4px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.khung h3, .khung1 h3, .khung2 h3, .khung3 h3 {
	font-size: 18px;
	color: #333;
	margin-bottom: 15px;
	position: relative;
	padding-bottom: 10px;
	border-bottom: 1px solid #eee;
}

.khung a, .khung1 a, .khung3 a {
	color: #555;
	text-decoration: none;
	display: block;
	font-size: 14px;
	padding: 5px 0;
}

.khung a:hover, .khung1 a:hover, .khung3 a:hover {
	color: #007bff;
}

.khung2 {
	text-align: center;
}

.khung2 a {
	display: inline-block;
	margin: 5px;
}

.khung2 a img {
	width: 24px;
	height: 24px;
	transition: transform 0.3s;
}

.khung2 a:hover img {
	transform: scale(1.2);
}

/* Responsive Design */
@media ( max-width : 1200px) {
	.container {
		width: 100%;
	}
	.content-wrapper {
		flex-direction: column;
	}
	aside {
		width: 100%;
	}
}

@media ( max-width : 992px) {
	.news-container {
		grid-template-columns: repeat(2, 1fr);
	}
	.phancuoi {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width : 768px) {
	nav {
		flex-direction: column;
		height: auto;
		padding: 15px;
	}
	nav a {
		margin: 5px 0;
	}
	.dropdown-container {
		width: 100%;
		margin-top: 10px;
	}
	.dropdown-toggle {
		width: 100%;
		justify-content: center;
	}
	.dropdown-menu {
		position: static;
		width: 100%;
		box-shadow: none;
	}
	.news-container {
		grid-template-columns: 1fr;
	}
}

@media ( max-width : 576px) {
	.phancuoi {
		grid-template-columns: 1fr;
	}
	.boxnlx, .boxtmn, .boxtdx {
		flex-direction: column;
	}
	.imgnlx, .imgtmn, .imgtdx {
		width: 100%;
		margin-bottom: 10px;
	}
	.namenlx, .nametmn, .nametdx {
		margin-left: 0;
	}
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

		<div class="content-wrapper">
			<article>
				<div class="main-content">
					<div class="news-container">
						<c:forEach var="news" items="${newsList}">
							<div class="new">
								<div class="image">
									<a
										href="${pageContext.request.contextPath}/news-display?id=${news.id}">
										<img src="/ASSIGNMENTJAVA_PD10303/${news.image}"
										alt="${news.title}" width="400" height="180">
									</a>
								</div>
								<div class="namenew">
									<a
										href="${pageContext.request.contextPath}/news-display?id=${news.id}">
										<h4>${news.title}</h4>
									</a> <a
										href="${pageContext.request.contextPath}/news-display?id=${news.id}">
										<p>${fn:substring(news.content, 0, 130)}...</p>
									</a>
								</div>
								<div class="info-container">
									<div class="date-author">
										<p class="date">
											<fmt:formatDate value="${news.postedDate}"
												pattern="dd/MM/yyyy" />
										</p>
										<p class="author">${news.authorName}</p>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</article>

			<aside>
				<div class="sidebar">
					<!-- Most Viewed News -->
					<div class="box">
						<h4 class="section-title">BẢN TIN NHIỀU LƯỢT XEM NHẤT</h4>
						<c:if test="${not empty topViewedNews}">
							<c:forEach var="news" items="${topViewedNews}">
								<div class="boxnlx">
									<div class="imgnlx">
										<a
											href="${pageContext.request.contextPath}/news-display?id=${news.id}">
											<img src="/ASSIGNMENTJAVA_PD10303/${news.image}"
											alt="${news.title}">
										</a>
									</div>
									<div class="namenlx">
										<a
											href="${pageContext.request.contextPath}/news-display?id=${news.id}">
											<h5>${news.title}</h5>
										</a>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>

					<!-- Latest News -->
					<div class="box">
						<h4 class="section-title">BẢN TIN MỚI NHẤT</h4>
						<c:if test="${not empty latestNews}">
							<c:forEach var="news" items="${latestNews}">
								<div class="boxtmn">
									<div class="imgtmn">
										<a
											href="${pageContext.request.contextPath}/news-display?id=${news.id}">
											<img src="/ASSIGNMENTJAVA_PD10303/${news.image}"
											alt="${news.title}">
										</a>
									</div>
									<div class="nametmn">
										<a
											href="${pageContext.request.contextPath}/news-display?id=${news.id}">
											<h5>${news.title}</h5>
										</a>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>

					<!-- Recently Viewed News -->
					<div class="box">
						<h4 class="section-title">BẢN TIN BẠN ĐÃ XEM</h4>
						<c:if test="${not empty recentlyViewedNews}">
							<c:forEach var="news" items="${recentlyViewedNews}">
								<div class="boxtdx">
									<div class="imgtdx">
										<a
											href="${pageContext.request.contextPath}/news-display?id=${news.id}">
											<img
											src="${pageContext.request.contextPath}/image/${news.image}"
											alt="${news.title}">
										</a>
									</div>
									<div class="nametdx">
										<a
											href="${pageContext.request.contextPath}/news-display?id=${news.id}">
											<h5>${news.title}</h5>
										</a>
									</div>
								</div>
							</c:forEach>
						</c:if>
						<c:if test="${empty recentlyViewedNews}">
							<p>Không có bản tin đã xem gần đây.</p>
						</c:if>
					</div>
				</div>
			</aside>
		</div>
		<footer>
			<div class="phancuoi">
				<div class="khung">
					<h3>Thông tin về tổng biên tập</h3>
					<a> - Hải Hưng, Hải Lăng, Quảng Trị <br> - Hotline:
						0969231454 <br> - FB: Võ Đình Hội <br> - Email: <span
						class="__cf_email__"
						data-cfemail="d4a2bbb0bdbabcbcbbbde594b3b9b5bdb8fab7bbb9">[email protected]</span></a>
				</div>
				<div class="khung1">
					<h3>Chăm sóc khách hàng</h3>
					<a href="#">- Tổng đài tư vấn</a><a href="#">- Liên hệ</a><a
						href="#">- Hỗ trợ</a>
				</div>
				<div class="khung2">
					<h3>Kết nối với VDH New</h3>
					<a href="https://www.facebook.com/profile.php?id=100014716925138"><img
						src="/ASSIGNMENTJAVA_PD10303/image/social-media.png"
						alt="Facebook"></a> <a
						href="https://mail.google.com/mail/u/0/?hl=vi#inbox"><img
						src="/ASSIGNMENTJAVA_PD10303/image/email.png" alt="Email"></a> <a
						href="https://www.instagram.com/"><img
						src="/ASSIGNMENTJAVA_PD10303/image/instagram.png" alt="Instagram"></a>
					<a href="https://www.tiktok.com/"><img
						src="/ASSIGNMENTJAVA_PD10303/image/tik-tok.png" alt="TikTok"></a>
				</div>
				<div class="khung3">
					<h3>Trụ Sở</h3>
					<a href="#">- Giới thiệu</a><a href="#">- Tin tức</a><a href="#">-
						Tuyển dụng</a><a href="#">- Hệ thống công ty</a>
				</div>
			</div>
		</footer>
	</div>
	<script data-cfasync="false"
		src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
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