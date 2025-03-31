<%@page import="com.poly.entity.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${news.title}</title>
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
    width: 1200px;
    max-width: 100%;
    margin: 0 auto;
    padding: 15px;
    transition: all 0.3s ease;
}

/* Header */
header {
    height: 350px;
    position: relative;
    margin-bottom: 15px;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.anhnen img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.anhnen:hover img {
    transform: scale(1.03);
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

/* Dropdown Menu - Updated to match Báo Pháp Luật */
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
    background: #0066cc; /* Matches the blue color in Báo Pháp Luật */
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

/* Article Content */
article {
    background-color: white;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    margin-bottom: 30px;
    width: 100%;
    height: auto;
    min-height: 800px;
}

.hienthibao {
    max-width: 1000px;
    margin: 0 auto;
}

.hienthibao h1 {
    font-size: 2.5rem;
    color: #333;
    margin-bottom: 30px;
    text-align: center;
    font-weight: 700;
    line-height: 1.3;
    position: relative;
    padding-bottom: 15px;
}

.hienthibao h1:after {
    content: '';
    position: absolute;
    width: 100px;
    height: 4px;
    background: linear-gradient(90deg, #007bff, #00c6ff);
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    border-radius: 2px;
}

.row-one {
    display: flex;
    margin-bottom: 40px;
    gap: 30px;
    align-items: flex-start;
}

.logo1 {
    flex: 0 0 45%;
}

.logo1 img {
    width: 100%;
    height: auto;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.logo1 img:hover {
    transform: scale(1.02);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

.contenth {
    flex: 1;
}

.titleh {
    font-size: 1.8rem;
    color: #333;
    margin-bottom: 20px;
    line-height: 1.4;
    font-weight: 600;
}

.desc {
    font-size: 1.1rem;
    color: #444;
    text-align: justify;
    line-height: 1.8;
    margin-bottom: 20px;
}

.row-title p {
    font-size: 1.1rem;
    color: #444;
    text-align: justify;
    line-height: 1.8;
    margin: 20px 0;
}

/* Related News Section */
.tcl {
    background: linear-gradient(to bottom, #f8f9fa, #ffffff);
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    margin-top: 40px;
    border-left: 4px solid #007bff;
}

.tcl h4 {
    color: #333;
    font-size: 1.5rem;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 2px solid #eaeaea;
    position: relative;
}

.tcl h4:after {
    content: '';
    position: absolute;
    width: 60px;
    height: 3px;
    background-color: #007bff;
    bottom: -2px;
    left: 0;
}

.tcl1 {
    margin-top: 15px;
}

.tcl1 a {
    display: block;
    padding: 12px 0;
    text-decoration: none;
    color: #0056b3;
    font-size: 1.1rem;
    border-bottom: 1px solid #eaeaea;
    transition: all 0.3s ease;
    position: relative;
    padding-left: 20px;
}

.tcl1 a:before {
    content: '→';
    position: absolute;
    left: 0;
    transition: transform 0.3s ease;
}

.tcl1 a:hover {
    color: #007bff;
    transform: translateX(5px);
}

.tcl1 a:hover:before {
    transform: translateX(3px);
}

.tcl1 a:last-child {
    border-bottom: none;
}

/* Footer */
footer {
    clear: both;
    padding: 30px 0 15px;
    background-color: #f8f9fa;
    border-top: 2px solid #3ea8ef;
    margin-top: 30px;
    width: 100%;
}

.phancuoi {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 25px;
    padding: 20px;
}

.khung, .khung1, .khung2, .khung3 {
    background-color: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    transition: transform 0.3s ease;
}

.khung:hover, .khung1:hover, .khung2:hover, .khung3:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.khung h3, .khung1 h3, .khung2 h3, .khung3 h3 {
    font-size: 20px;
    color: #333;
    margin-bottom: 20px;
    position: relative;
    padding-bottom: 10px;
}

.khung h3:after, .khung1 h3:after, .khung2 h3:after, .khung3 h3:after {
    content: '';
    position: absolute;
    width: 50px;
    height: 3px;
    background-color: #007bff;
    bottom: 0;
    left: 0;
}

.khung a, .khung1 a, .khung3 a {
    color: #555;
    text-decoration: none;
    display: block;
    font-size: 16px;
    padding: 8px 0;
    transition: all 0.3s ease;
}

.khung a:hover, .khung1 a:hover, .khung3 a:hover {
    color: #007bff;
    transform: translateX(5px);
}

.khung2 {
    text-align: center;
}

.khung2 a {
    display: inline-block;
    margin: 10px;
}

.khung2 a img {
    width: 32px;
    height: 32px;
    transition: all 0.3s ease;
    filter: grayscale(30%);
}

.khung2 a:hover img {
    transform: scale(1.2) rotate(10deg);
    filter: grayscale(0%);
}

/* Responsive Design */
@media (max-width: 1200px) {
    .container {
        width: 100%;
        padding: 10px;
    }
    .row-one {
        flex-direction: column;
    }
    .logo1 {
        flex: 0 0 100%;
        margin-bottom: 20px;
    }
    .phancuoi {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
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
    .hienthibao h1 {
        font-size: 1.8rem;
    }
    .titleh {
        font-size: 1.5rem;
    }
    .desc, .row-title p {
        font-size: 1rem;
    }
}

@media (max-width: 480px) {
    header {
        height: 200px;
    }
    .phancuoi {
        grid-template-columns: 1fr;
    }
    .hienthibao h1 {
        font-size: 1.5rem;
    }
    .tcl h4 {
        font-size: 1.3rem;
    }
    .tcl1 a {
        font-size: 1rem;
    }
}
</style>
</head>
<body>
    <div class="container">
        <header>
            <div class="anhnen">
                <img src="/ASSIGNMENTJAVA_PD10303/image/bao.png" alt="" width="1200" height="335">
            </div>
        </header>
        <nav>
            <a href="/ASSIGNMENTJAVA_PD10303/ass"><img src="/ASSIGNMENTJAVA_PD10303/image/home.png" alt="Home"></a>
            <a href="/ASSIGNMENTJAVA_PD10303/html/vanhoa.jsp">Văn hóa</a>
            <a href="/ASSIGNMENTJAVA_PD10303/html/phapluat.jsp">Pháp luật</a>
            <a href="/ASSIGNMENTJAVA_PD10303/html/thethao.jsp">Thể thao</a>
            <a href="/ASSIGNMENTJAVA_PD10303/html/giaoduc.jsp">Giáo dục</a>
            <a href="/ASSIGNMENTJAVA_PD10303/html/chinhtri.jsp">Chính trị</a>

            <%
            User user = null;
            if (session != null) {
                user = (User) session.getAttribute("khachHang");
            }
            if (user != null) {
            %>
            <div class="dropdown-container">
                <button class="dropdown-toggle"><%=user.getFullname()%> ▼</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="/ASSIGNMENTJAVA_PD10303/html/doimatkhau.jsp">Đổi mật khẩu</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="/ASSIGNMENTJAVA_PD10303/new">Công cụ quản trị</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/out">Đăng Xuất</a>
                </div>
            </div>
            <%
            } else {
            %>
            <a class="btn btn-primary" href="/ASSIGNMENTJAVA_PD10303/html/login.jsp">Đăng nhập</a>
            <%
            }
            %>
        </nav>
        <article>
            <div class="hienthibao">
                <h1><c:out value="${news.title}" /></h1>
                <div class="row-one" style="display: flex;">
                    <div class="logo1">
                        <img src="/ASSIGNMENTJAVA_PD10303/${news.image}" alt="">
                    </div>
                    <div class="contenth">
                        <h3 class="titleh" style="text-align: center;">${news.title}</h3>
                        <p class="desc">${news.content}</p>
                    </div>
                </div>
                <div class="row-title">
                    <p>${news.extraDetails}</p>
                </div>

                <div class="tcl">
                    <h4>TIN CÙNG LOẠI</h4>
                    <div class="tcl1">
                        <c:if test="${not empty relatedNews}">
                            <c:forEach var="related" items="${relatedNews}">
                                <a href="news-display?id=${related.id}">${related.title}</a><br>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty relatedNews}">
                            <p>Không có tin cùng loại nào.</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </article>
        <footer>
            <div class="phancuoi">
                <div class="khung">
                    <h3>Thông tin về tổng biên tập</h3>
                    <a> - Hải Hưng, Hải Lăng, Quảng Trị <br> - Hotline: 0969231454 <br> - FB: Võ Đình Hội <br> - Email: vodinhhoi1@gmail.com</a>
                </div>
                <div class="khung1">
                    <h3>Chăm sóc khách hàng</h3>
                    <a href="#">- Tổng đài tư vấn</a><a href="#">- Liên hệ</a><a href="#">- Hỗ trợ</a>
                </div>
                <div class="khung2">
                    <h3>Kết nối với VDH New</h3>
                    <a href="https://www.facebook.com/profile.php?id=100014716925138"><img src="/ASSIGNMENTJAVA_PD10303/image/social-media.png" alt=""></a>
                    <a href="https://mail.google.com/mail/u/0/?hl=vi#inbox"><img src="/ASSIGNMENTJAVA_PD10303/image/email.png" alt=""></a>
                    <a href="https://www.instagram.com/"><img src="/ASSIGNMENTJAVA_PD10303/image/instagram.png" alt=""></a>
                    <a href="https://www.tiktok.com/"><img src="/ASSIGNMENTJAVA_PD10303/image/tik-tok.png" alt=""></a>
                </div>
                <div class="khung3">
                    <h3>Trụ Sở</h3>
                    <a href="#">- Giới thiệu</a><a href="#">- Tin tức</a><a href="#">- Tuyển dụng</a><a href="#">- Hệ thống công ty</a>
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