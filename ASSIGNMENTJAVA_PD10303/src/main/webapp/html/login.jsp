<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Login</title>
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

.form {
	background-color: var(--white);
	padding: 2.5rem;
	border-radius: 16px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
	transition: var(--transition);
}

.form:hover {
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

/* Prevent browser autofill styling */
.input-field:-webkit-autofill, .input-field:-webkit-autofill:hover,
	.input-field:-webkit-autofill:focus, .input-field:-webkit-autofill:active
	{
	-webkit-box-shadow: 0 0 0 30px white inset !important;
	-webkit-text-fill-color: var(--text-color) !important;
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

.submit-btn, .back-btn {
	flex: 1;
	padding: 0.9375rem;
	border: none;
	border-radius: 8px;
	font-size: 0.9375rem;
	font-weight: 600;
	cursor: pointer;
	transition: var(--transition);
	text-align: center;
	text-decoration: none;
}

.submit-btn {
	background-color: var(--primary-color);
	color: var(--white);
}

.submit-btn:hover {
	background-color: var(--primary-hover);
	transform: translateY(-2px);
}

.submit-btn:active {
	transform: translateY(0);
}

.back-btn {
	background-color: var(--secondary-color);
	color: var(--white);
}

.back-btn:hover {
	background-color: var(--secondary-hover);
	transform: translateY(-2px);
}

.back-btn:active {
	transform: translateY(0);
}

.form-footer {
	text-align: center;
	margin-top: 1.5rem;
	font-size: 0.875rem;
	color: var(--gray);
}

.form-footer a {
	color: var(--primary-color);
	text-decoration: none;
	font-weight: 500;
	transition: var(--transition);
}

.form-footer a:hover {
	text-decoration: underline;
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

.password-toggle i {
	transition: var(--transition);
}

.input-icon {
	position: absolute;
	left: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: var(--gray);
	font-size: 1rem;
}

.password-container, .username-container {
	position: relative;
}

.password-container .input-field, .username-container .input-field {
	padding-left: 2.5rem;
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
	.form {
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
	<div class="form-container">
		<div class="decorative-element top-right"></div>
		<div class="decorative-element bottom-left"></div>

		<form class="form" action="<%=request.getContextPath()%>/login"
			method="post" autocomplete="off">
			<h1 class="form-title">Welcome back</h1>

			<%
			String baoLoi = (String) request.getAttribute("baoLoi");
			if (baoLoi == null) {
				baoLoi = "";
			}
			%>

			<%
			if (!baoLoi.isEmpty()) {
			%>
			<span class="error-message"><%=baoLoi%></span>
			<%
			}
			%>

			<div class="input-group">
				<label for="username" class="input-label">Username</label>
				<div class="username-container">
					<i class="input-icon fas fa-user"></i> <input type="text"
						id="username" name="username" class="input-field"
						placeholder="Enter your username" required autocomplete="off">
				</div>
			</div>

			<div class="input-group">
				<label for="password" class="input-label">Password</label>
				<div class="password-container">
					<i class="input-icon fas fa-lock"></i> <input type="password"
						id="password" name="password" class="input-field"
						placeholder="Enter your password" required
						autocomplete="new-password"> <span class="password-toggle"><i
						class="fas fa-eye"></i></span>
				</div>
			</div>

			<div class="button-group">
				<button type="submit" class="submit-btn">Sign In</button>
				<a href="/ASSIGNMENTJAVA_PD10303/ass" class="back-btn">Back</a>
			</div>

			<div class="form-footer">
				Don't have an account? <a
					href="<%=request.getContextPath()%>/html/reigster.jsp">Sign up</a>
			</div>
		</form>
	</div>

	<script>
		// Toggle password visibility
		const passwordToggle = document.querySelector('.password-toggle i');
		const passwordField = document.getElementById('password');

		passwordToggle
				.addEventListener(
						'click',
						function() {
							const type = passwordField.getAttribute('type') === 'password' ? 'text'
									: 'password';
							passwordField.setAttribute('type', type);
							// Toggle between fa-eye and fa-eye-slash
							this.classList.toggle('fa-eye');
							this.classList.toggle('fa-eye-slash');
						});
	</script>
</body>
</html>