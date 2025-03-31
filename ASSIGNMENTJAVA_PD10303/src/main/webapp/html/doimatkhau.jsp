<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đổi mật khẩu</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
:root {
	--primary-color: #4361ee;
	--primary-hover: #3a56d4;
	--secondary-color: #64748b;
	--secondary-hover: #475569;
	--error-color: #ef233c;
	--text-color: #2b2d42;
	--light-gray: #edf2f4;
	--gray: #8d99ae;
	--white: #ffffff;
	--transition: all 0.3s ease;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f8fafc;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	color: var(--text-color);
	background-image: radial-gradient(circle at 10% 20%, rgba(234, 249, 249, 0.67)
		0%, rgba(239, 249, 251, 0.63) 90%);
}

.form-container {
	width: 100%;
	max-width: 420px;
	padding: 2rem;
	position: relative;
}

.password-change-form {
	background-color: var(--white);
	padding: 2.5rem;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
	transition: var(--transition);
}

.password-change-form:hover {
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

.form-title {
	font-size: 1.75rem;
	font-weight: 700;
	text-align: center;
	margin-bottom: 1.5rem;
	color: var(--text-color);
	position: relative;
}

.form-title::after {
	content: '';
	display: block;
	width: 60px;
	height: 4px;
	background: var(--primary-color);
	margin: 0.75rem auto 0;
	border-radius: 2px;
}

.input-group {
	margin-bottom: 1.5rem;
	position: relative;
}

.input-label {
	display: block;
	margin-bottom: 0.5rem;
	font-size: 0.875rem;
	font-weight: 500;
	color: var(--text-color);
}

.input-field {
	width: 100%;
	padding: 0.875rem 1rem 0.875rem 2.5rem;
	font-size: 0.9375rem;
	border: 1px solid #e2e8f0;
	border-radius: 8px;
	background-color: var(--white);
	transition: var(--transition);
	color: var(--text-color);
}

.input-field:focus {
	outline: none;
	border-color: var(--primary-color);
	box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
}

.input-field::placeholder {
	color: var(--gray);
}

.error-message {
	color: var(--error-color);
	font-size: 0.8125rem;
	margin-top: 0.25rem;
	display: block;
	text-align: center;
	margin-bottom: 1rem;
}

.button-group {
	display: flex;
	gap: 1rem;
	margin-top: 1rem;
}

.submit-btn, .cancel-btn {
	flex: 1;
	padding: 0.9375rem;
	border: none;
	border-radius: 8px;
	font-size: 0.9375rem;
	font-weight: 600;
	cursor: pointer;
	transition: var(--transition);
	text-align: center;
}

.submit-btn {
	background-color: var(--primary-color);
	color: var(--white);
}

.submit-btn:hover {
	background-color: var(--primary-hover);
	transform: translateY(-2px);
}

.cancel-btn {
	background-color: var(--secondary-color);
	color: var(--white);
}

.cancel-btn:hover {
	background-color: var(--secondary-hover);
	transform: translateY(-2px);
}

.input-icon {
	position: absolute;
	left: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--gray);
	font-size: 1rem;
}

.password-toggle {
	position: absolute;
	right: 12px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
	color: var(--gray);
	font-size: 1.125rem;
}

.password-container {
	position: relative;
}

.decorative-element {
	position: absolute;
	width: 120px;
	height: 120px;
	background: rgba(67, 97, 238, 0.1);
	border-radius: 50%;
	z-index: -1;
}

.decorative-element.top-right {
	top: -50px;
	right: -50px;
}

.decorative-element.bottom-left {
	bottom: -50px;
	left: -50px;
}

@media ( max-width : 480px) {
	.form-container {
		padding: 1.5rem;
	}
	.password-change-form {
		padding: 1.75rem;
	}
	.button-group {
		flex-direction: column;
		gap: 0.75rem;
	}
}
</style>
</head>
<body>
	<%
	String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath();
	%>
	<div class="form-container">
		<div class="decorative-element top-right"></div>
		<div class="decorative-element bottom-left"></div>

		<form action="<%=url%>/doimatkhau" method="post" name="form" id="form"
			class="password-change-form">
			<h2 class="form-title">Đổi mật khẩu</h2>

			<div>
				<%
				String error = (String) request.getAttribute("error");
				%>
				<%
				String message = (String) request.getAttribute("message");
				%>
				<%
				if (error != null) {
				%>
				<span class="error-message"><%=error%></span>
				<%
				}
				%>
				<%
				if (message != null) {
				%>
				<span
					style="color: #10b981; font-size: 0.8125rem; display: block; text-align: center; margin-bottom: 1rem;"><%=message%></span>
				<%
				}
				%>
			</div>

			<div class="input-group">
				<label for="email" class="input-label">Email</label>
				<div class="password-container">
					<i class="input-icon fas fa-envelope"></i> <input type="email"
						id="email" name="email" class="input-field"
						placeholder="Nhập email của bạn" required>
				</div>
			</div>

			<div class="input-group">
				<label for="matkhaucu" class="input-label">Mật Khẩu Hiện Tại</label>
				<div class="password-container">
					<i class="input-icon fas fa-lock"></i> <input type="password"
						id="matkhaucu" name="matkhaucu" class="input-field"
						placeholder="Nhập mật khẩu hiện tại" required> <span
						class="password-toggle"><i class="fas fa-eye"></i></span>
				</div>
			</div>

			<div class="input-group">
				<label for="matkhaumoi" class="input-label">Mật Khẩu Mới</label>
				<div class="password-container">
					<i class="input-icon fas fa-key"></i> <input type="password"
						id="matkhaumoi" name="matkhaumoi" class="input-field"
						placeholder="Nhập mật khẩu mới" required> <span
						class="password-toggle"><i class="fas fa-eye"></i></span>
				</div>
			</div>

			<div class="input-group">
				<label for="nhaplaimatkhau" class="input-label">Xác Nhận Mật
					Khẩu</label>
				<div class="password-container">
					<i class="input-icon fas fa-check-circle"></i> <input
						type="password" id="nhaplaimatkhau" name="nhaplaimatkhau"
						class="input-field" placeholder="Xác nhận mật khẩu mới" required>
					<span class="password-toggle"><i class="fas fa-eye"></i></span>
				</div>
			</div>

			<div id="client-error" class="error-message"></div>

			<div class="button-group">
				<button type="submit" class="submit-btn">Đồng Ý</button>
				<button type="button" class="cancel-btn" onclick="goBack()">Back</button>
			</div>
		</form>
	</div>

	<script>
    <%if (message != null) {%>
        console.log("Success: <%=message%>");
    <%} else if (error != null) {%>
        console.error("Error: <%=error%>");
    <%}%>
    document.getElementById("form").addEventListener("submit", function(event) {
        var matkhaumoi = document.getElementById("matkhaumoi").value;
        var nhaplaimatkhau = document.getElementById("nhaplaimatkhau").value;
        var clientError = document.getElementById("client-error");

        clientError.innerHTML = "";

        if (matkhaumoi !== nhaplaimatkhau) {
            clientError.innerHTML = "Mật khẩu mới và xác nhận mật khẩu không khớp.";
            event.preventDefault();
        }
    });
    document.querySelectorAll('.password-toggle i').forEach(toggle => {
        toggle.addEventListener('click', function() {
            const input = this.parentElement.previousElementSibling;
            const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
            input.setAttribute('type', type);
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
    });

    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>