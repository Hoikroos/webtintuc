<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.poly.entity.User"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản Lí Tin Tức</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f8f9fa;
	line-height: 1.6;
	color: #333;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 20px auto;
}

header {
	text-align: center;
	padding: 0;
	margin-bottom: 20px;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

header img {
	max-width: 100%;
	height: auto;
	display: block;
}

nav {
	background: linear-gradient(to right, #3498db, #2980b9);
	padding: 0;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	margin-bottom: 25px;
}

nav ul {
	list-style-type: none;
	display: flex;
	justify-content: center;
	padding: 0;
	margin: 0;
}

nav li {
	margin: 0;
}

nav a {
	color: white;
	text-decoration: none;
	font-weight: bold;
	font-size: 16px;
	transition: all 0.3s;
	padding: 15px 25px;
	display: flex;
	align-items: center;
	border-radius: 0;
}

nav a:hover {
	background-color: rgba(255, 255, 255, 0.1);
	color: #fff;
	transform: translateY(-2px);
}

.disabled-link {
	color: rgba(255, 255, 255, 0.5);
	padding: 15px 25px;
	display: flex;
	align-items: center;
	cursor: not-allowed;
}

nav a i, .disabled-link i {
	margin-right: 8px;
	font-size: 18px;
}

article {
	background-color: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	margin-bottom: 25px;
}

.card-header {
	background: linear-gradient(to right, #4CAF50, #2E7D32);
	color: white;
	padding: 15px 20px;
	border-radius: 8px 8px 0 0;
	margin: -30px -30px 20px;
}

.card-header h2 {
	margin: 0;
	font-size: 24px;
	font-weight: 600;
}

.tabs {
	display: flex;
	margin-bottom: 20px;
	border-bottom: 1px solid #e0e0e0;
}

.tab {
	padding: 12px 24px;
	cursor: pointer;
	font-weight: 600;
	color: #666;
	border-bottom: 3px solid transparent;
	transition: all 0.3s;
}

.tab.active {
	color: #4CAF50;
	border-bottom-color: #4CAF50;
}

.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

.form-container {
	background-color: #f9f9f9;
	border-radius: 8px;
	padding: 25px;
	margin-bottom: 20px;
	border: 1px solid #e0e0e0;
}

.form-title {
	color: #2E7D32;
	margin-bottom: 20px;
	font-size: 20px;
	font-weight: 600;
	padding-bottom: 10px;
	border-bottom: 1px solid #e0e0e0;
}

.form-row {
	display: flex;
	flex-wrap: wrap;
	margin: 0 -10px;
}

.form-group {
	padding: 0 10px;
	margin-bottom: 20px;
}

.form-group-half {
	width: 100%;
}

.form-group-full {
	width: 100%;
}

.form-label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: #555;
}

.form-control {
	width: 100%;
	padding: 12px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-size: 15px;
	transition: all 0.3s;
}

.form-control:focus {
	border-color: #4CAF50;
	box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
	outline: none;
}

textarea.form-control {
	min-height: 120px;
	resize: vertical;
}

.form-check {
	display: flex;
	align-items: center;
	margin-right: 20px;
}

.form-check-input {
	margin-right: 8px;
	width: 18px;
	height: 18px;
}

.form-check-label {
	font-weight: normal;
}

.radio-group {
	display: flex;
	margin-top: 8px;
}

.btn {
	padding: 12px 24px;
	font-weight: 600;
	border-radius: 6px;
	cursor: pointer;
	transition: all 0.3s;
	border: none;
	font-size: 15px;
	margin-right: 10px;
}

.btn-primary {
	background-color: #4CAF50;
	color: white;
}

.btn-primary:hover {
	background-color: #388E3C;
	transform: translateY(-2px);
}

.btn-secondary {
	background-color: #f1f1f1;
	color: #333;
}

.btn-secondary:hover {
	background-color: #e0e0e0;
	transform: translateY(-2px);
}

.btn-danger {
	background-color: #f44336;
	color: white;
}

.btn-danger:hover {
	background-color: #d32f2f;
	transform: translateY(-2px);
}

.btn-group {
	display: flex;
	margin-top: 25px;
}

.image-preview {
	width: 100px;
	height: auto;
	border-radius: 4px;
	margin-top: 10px;
	border: 1px solid #ddd;
	padding: 3px;
	background-color: #fff;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	font-size: 15px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	overflow: hidden;
}

th, td {
	text-align: left;
	padding: 15px;
	border: none;
	border-bottom: 1px solid #e0e0e0;
}

th {
	background: linear-gradient(to right, #4CAF50, #2E7D32);
	color: white;
	font-weight: 600;
	text-transform: uppercase;
	font-size: 14px;
	letter-spacing: 0.5px;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #f1f7f1;
}

tr:last-child td {
	border-bottom: none;
}

.table-image {
	width: 80px;
	height: 60px;
	object-fit: cover;
	border-radius: 4px;
	border: 1px solid #ddd;
}

.table-actions {
	display: flex;
	gap: 8px;
}

.btn-action {
	padding: 8px 12px;
	border-radius: 4px;
	font-size: 13px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s;
	border: none;
}

.btn-edit {
	background-color: #2196F3;
	color: white;
}

.btn-edit:hover {
	background-color: #1976D2;
	transform: translateY(-2px);
}

.btn-delete {
	background-color: #f44336;
	color: white;
}

.btn-delete:hover {
	background-color: #d32f2f;
	transform: translateY(-2px);
}

.truncate {
	max-width: 200px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	display: block;
}

footer {
	background: linear-gradient(to right, #4CAF50, #2E7D32);
	color: white;
	text-align: center;
	padding: 20px 0;
	border-radius: 8px;
	margin-top: 25px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

footer h2 {
	margin: 0;
	font-size: 20px;
	font-weight: 600;
}

@media screen and (min-width: 768px) {
	.form-group-half {
		width: 50%;
	}
	.form-group-third {
		width: 33.333%;
	}
}

@media screen and (max-width: 768px) {
	.container {
		width: 95%;
	}
	nav a, .disabled-link {
		padding: 12px 15px;
		font-size: 14px;
	}
	nav a i, .disabled-link i {
		margin-right: 5px;
	}
	article {
		padding: 20px;
	}
	.card-header {
		margin: -20px -20px 15px;
		padding: 12px 15px;
	}
	.form-container {
		padding: 15px;
	}
	.btn {
		padding: 10px 18px;
	}
	th, td {
		padding: 10px;
		font-size: 14px;
	}
	.table-responsive {
		overflow-x: auto;
		-webkit-overflow-scrolling: touch;
	}
}
</style>
</head>
<body>
	<div class="container">
		<header>
			<img src="/ASSIGNMENTJAVA_PD10303/image/congcu.png" alt=""
				width="1200" height="200">
		</header>
		<%
		User user = (User) session.getAttribute("khachHang");
		Boolean role = user != null ? user.isRole() : false;
		%>
		<nav>
			<ul>
				<li><a href="/ASSIGNMENTJAVA_PD10303/ass"><i
						class="fas fa-home"></i> Home</a></li>
				<li><a href="/ASSIGNMENTJAVA_PD10303/new"><i
						class="fas fa-newspaper"></i> News</a></li>

				<%
				if (role != null && role) {
				%>
				<li><a href="/ASSIGNMENTJAVA_PD10303/user"><i
						class="fas fa-users"></i> User</a></li>
				<li><a href="/ASSIGNMENTJAVA_PD10303/catego"><i
						class="fas fa-tags"></i> Category</a></li>
				<li><a href="/ASSIGNMENTJAVA_PD10303/newsletter"><i
						class="fas fa-envelope"></i> Newsletter</a></li>
				<%
				} else {
				%>
				<li><span class="disabled-link"><i class="fas fa-users"></i>
						User</span></li>
				<li><span class="disabled-link"><i class="fas fa-tags"></i>
						Category</span></li>
				<li><span class="disabled-link"><i
						class="fas fa-envelope"></i> Newsletter</span></li>
				<%
				}
				%>
			</ul>
		</nav>
		<article>
			<div class="card-header">
				<h2>
					<i class="fas fa-newspaper"></i> Quản Lý Tin Tức
				</h2>
			</div>

			<div class="tabs">
				<div class="tab active" data-tab="form">Thêm/Sửa Tin Tức</div>
				<div class="tab" data-tab="list">Danh Sách Tin Tức</div>
			</div>

			<div class="tab-content active" id="form-tab">
				<div class="form-container">
					<h3 class="form-title">
						<i class="fas fa-plus-circle"></i> ${item != null ? 'Cập Nhật Tin Tức' : 'Thêm Tin Tức Mới'}
					</h3>

					<c:url var="path" value="/new" />
					<form action="${path}/insert" method="post"
						enctype="multipart/form-data">
						<div class="form-row">
							<div class="form-group form-group-half">
								<label for="new-news-id" class="form-label">ID:</label> <input
									type="text" id="new-news-id" name="id" class="form-control"
									value="${item != null ? item.id : ''}">
							</div>

							<div class="form-group form-group-half">
								<label for="new-title" class="form-label">Tiêu Đề:</label> <input
									type="text" id="new-title" name="title" class="form-control"
									value="${item != null ? item.title : ''}" required>
							</div>
						</div>

						<div class="form-group form-group-full">
							<label for="new-content" class="form-label">Nội Dung:</label>
							<textarea id="new-content" name="content" class="form-control"
								required>${item != null ? item.content : ''}</textarea>
						</div>

						<div class="form-row">
							<div class="form-group form-group-half">
								<label for="new-image" class="form-label">Ảnh:</label> <input
									type="file" id="new-image" name="image" class="form-control"
									accept="image/*">
								<c:if test="${item != null && item.image != null}">
									<img src="${item.image}" alt="" class="image-preview" />
								</c:if>
							</div>

							<div class="form-group form-group-half">
								<label for="new-posted-date" class="form-label">Ngày
									Đăng:</label> <input type="date" id="new-posted-date" name="posted"
									class="form-control"
									value="${item != null && item.postedDate != null ? item.postedDate.toString().substring(0, 10) : ''}"
									required>
							</div>
						</div>

						<div class="form-row">
							<div class="form-group form-group-third">
								<label for="new-author" class="form-label">Tác Giả (ID):</label>
								<input type="text" id="new-author" name="authorId"
									class="form-control" value="${item != null ? item.author : ''}"
									required>
							</div>

							<div class="form-group form-group-third">
								<label for="view-count" class="form-label">Số Lượt Xem:</label>
								<input type="number" name="viewCount" id="view-count"
									class="form-control"
									value="${item != null ? item.viewCount : 0}" required>
							</div>

							<div class="form-group form-group-third">
								<label for="new-category" class="form-label">Loại Tin
									Tức:</label> <select id="new-category" name="categoryId"
									class="form-control" required>
									<c:forEach var="category" items="${categoriesList}">
										<option value="${category.id}"
											<c:if test="${item != null && item.categoryid != null && item.categoryid.id == category.id}">selected</c:if>>
											${category.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="form-group">
							<label class="form-label">Xuất Hiện Trên Trang Chủ:</label>
							<div class="radio-group">
								<div class="form-check">
									<input type="radio" class="form-check-input" id="home-yes"
										name="home" value="true"
										${item != null && item.home ? 'checked' : ''}> <label
										class="form-check-label" for="home-yes">Có</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" id="home-no"
										name="home" value="false"
										${item != null && !item.home ? 'checked' : ''}> <label
										class="form-check-label" for="home-no">Không</label>
								</div>
							</div>
						</div>

						<div class="btn-group">
							<button formaction="${path}/insert" type="submit"
								class="btn btn-primary">
								<i class="fas fa-plus-circle"></i> Thêm
							</button>
							<button formaction="${path}/update" type="submit"
								class="btn btn-primary" ${item != null ? '' : 'disabled'}>
								<i class="fas fa-sync-alt"></i> Cập Nhật
							</button>
							<button formaction="${path}/reset" type="submit"
								class="btn btn-secondary">
								<i class="fas fa-redo"></i> Reset
							</button>
						</div>
					</form>
				</div>
			</div>

			<div class="tab-content" id="list-tab">
				<div class="table-responsive">
					<table>
						<thead>
							<tr>
								<th>ID</th>
								<th>Tiêu Đề</th>
								<th>Nội Dung</th>
								<th>Ảnh</th>
								<th>Ngày Đăng</th>
								<th>Tác Giả</th>
								<th>Lượt Xem</th>
								<th>Loại</th>
								<th>Home</th>
								<th>Hành Động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="d" items="${list}" varStatus="vs">
								<tr>
									<td>${d.id}</td>
									<td><span class="truncate">${d.title}</span></td>
									<td><span class="truncate">${d.content}</span></td>
									<td><img
										src="${pageContext.request.contextPath}/${d.image}"
										alt="Ảnh tin tức" class="table-image" loading="lazy" /></td>
									<td><fmt:formatDate value="${d.postedDate}"
											pattern="dd/MM/yyyy" /></td>
									<td>${d.author}</td>
									<td>${d.viewCount}</td>
									<td>${d.categoryid.name}</td>
									<td>${d.home ? 'Có' : 'Không'}</td>
									<td class="table-actions">
										<form method="post" action="${path}/edit"
											style="display: inline;">
											<input type="hidden" name="id" value="${d.id}" />
											<button type="submit" class="btn-action btn-edit">
												<i class="fas fa-edit"></i> Sửa
											</button>
										</form>
										<form method="post" action="${path}/delete"
											style="display: inline;"
											onsubmit="return confirm('Bạn có chắc chắn muốn xóa tin tức này?');">
											<input type="hidden" name="id" value="${d.id}" />
											<button type="submit" class="btn-action btn-delete">
												<i class="fas fa-trash-alt"></i> Xóa
											</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<script>
				<c:if test="${not empty successMessage}">
				alert("${successMessage}");
				</c:if>

				<c:if test="${not empty errorMessage}">
				alert("${errorMessage}");
				</c:if>
				
				// Tab switching functionality
				document.addEventListener('DOMContentLoaded', function() {
					const tabs = document.querySelectorAll('.tab');
					const tabContents = document.querySelectorAll('.tab-content');
					
					tabs.forEach(tab => {
						tab.addEventListener('click', function() {
							const tabId = this.getAttribute('data-tab');
							
							// Remove active class from all tabs and contents
							tabs.forEach(t => t.classList.remove('active'));
							tabContents.forEach(c => c.classList.remove('active'));
							
							// Add active class to current tab and content
							this.classList.add('active');
							document.getElementById(tabId + '-tab').classList.add('active');
						});
					});
				});
			</script>
		</article>
		<footer>
			<h2>
				<%
				if (user == null) {
					user = (User) session.getAttribute("khachHang");
				}
				if (user != null) {
					out.print("Welcome " + user.getFullname() + "!");
				} else {
					out.print("Welcome Guest!");
				}
				%>
			</h2>
		</footer>
	</div>
</body>
</html>