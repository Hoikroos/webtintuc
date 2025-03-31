<%@page import="com.poly.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
html, body {
	height: 100%;
	margin: 0;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	color: #333;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

h1 {
	text-align: center;
	color: #007bff;
	margin-bottom: 20px;
}

.congcu {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

button {
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	padding: 10px 20px;
	margin: 0 10px;
	cursor: pointer;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #0056b3;
}

.cc {
	width: 400px;
	height: 300px;
	border: 1px solid rgb(211, 189, 189);
	border-radius: 5px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
}

.qlai {
	margin-left: -370px;
}
</style>
</head>
<body>
	<div class="qlai">
		<a href="/ASSIGNMENTJAVA_PD10303/ass"><img
			src="/ASSIGNMENTJAVA_PD10303/image/home.png" alt=""></a>
	</div>

	<div class="cc">
		<h1>
			<%
			User user = (User) session.getAttribute("khachHang");
			if (user != null) {
				out.print("Welcome " + user.getFullname() + "!");
			} else {
				out.print("Welcome Guest!");
			}
			%>
		</h1>

		<h3 style="text-align: center;">Chào mừng bạn đã đến với trang
			công cụ quản trị</h3>
		<h5 style="text-align: center;">Mời bạn chọn chức năng theo vai
			trò:</h5>

		<div class="congcu">
			<button id="quan-tri-btn"
				onclick="location.href='/ASSIGNMENTJAVA_PD10303/new'">Quản
				Trị</button>
			<button id="phong-vien-btn" disabled>Phóng Viên</button>
		</div>

		<%
		Boolean role = user != null ? user.isRole() : false;
		%>

		<script>
			const isAdmin =
		<%=role%>
			;
			const quanTriBtn = document.getElementById('quan-tri-btn');
			const phongVienBtn = document.getElementById('phong-vien-btn');
			if (isAdmin) {
				phongVienBtn.disabled = true;
				phongVienBtn.style.backgroundColor = '#ddd';
				phongVienBtn.style.cursor = 'not-allowed';
				phongVienBtn.onclick = function() {
					return false;
				};
			} else {
				quanTriBtn.disabled = true;
				quanTriBtn.style.backgroundColor = '#ddd';
				quanTriBtn.style.cursor = 'not-allowed';
				quanTriBtn.onclick = function() {
					return false;
				};
				phongVienBtn.disabled = false;
				phongVienBtn.onclick = function() {
					location.href = '/ASSIGNMENTJAVA_PD10303/new';
				};
			}
		</script>
	</div>

</body>
</html>