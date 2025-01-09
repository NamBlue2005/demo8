<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
  // Sử dụng đối tượng session mặc định của JSP (không khai báo lại)
  String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

  if (userEmail == null) {
    // Nếu chưa đăng nhập, chuyển hướng đến trang login.jsp
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>NamHùngStore</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      background-color: #fff8e1;
    }

    header {
      background: linear-gradient(to right, #ff5722, #ffc107);
      color: white;
      position: sticky;
      top: 0;
      z-index: 1000;
    }

    .logo {
      font-size: 2rem;
      font-weight: bold;
      text-align: center;
      margin: 0 auto;
    }

    .nav-link {
      color: white !important;
    }

    .nav-link:hover {
      color: #ffe082 !important;
    }

    .dropdown-menu {
      background-color: #ff5722;
      border: none;
    }

    .dropdown-item {
      color: white;
    }

    .dropdown-item:hover {
      background-color: #e64a19;
    }

    footer {
      background: #e64a19;
      color: white;
    }

    footer p {
      margin: 0;
    }

    .btn-dark {
      background-color: #ff5722;
      border: none;
    }

    .btn-dark:hover {
      background-color: #d84315;
    }
  </style>
</head>
<body>
<header class="py-3">
  <div class="container d-flex justify-content-between align-items-center">
    <a href="index.jsp" class="logo text-decoration-none text-white">NamHùng</a>
    <nav>
      <ul class="nav">
        <li class="nav-item"><a href="cart-list.jsp" class="nav-link">Giỏ Hàng</a></li>
        <li class="nav-item dropdown">
          <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Danh Mục</a>
          <ul class="dropdown-menu">
            <li><a href="iphones/iphone.jsp" class="dropdown-item">Iphone</a></li>
            <li><a href="Macs/mac.jsp" class="dropdown-item">Mac</a></li>
            <li><a href="phukiens/phukien.jsp" class="dropdown-item">Phụ kiện</a></li>
          </ul>
        </li>
        <%
          if (userEmail == null) { // Người dùng chưa đăng nhập
        %>
        <li class="nav-item"><a href="account.jsp" class="nav-link">Tài Khoản</a></li>
        <%
        } else { // Người dùng đã đăng nhập
        %>
        <li class="nav-item dropdown">
          <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><%= userEmail %></a>
          <ul class="dropdown-menu">
            <li><a href="logoutServlet" class="dropdown-item">Đăng Xuất</a></li>
          </ul>
        </li>
        <%
          }
        %>
      </ul>
    </nav>
  </div>
</header>

<!-- Nội dung chính -->
<div id="saleBanner" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="Img/baner.png" class="d-block w-100" alt="Khuyến Mãi 1">
    </div>
    <div class="carousel-item">
      <img src="Img/banner2.png" class="d-block w-100" alt="Khuyến Mãi 2">
    </div>
    <div class="carousel-item">
      <img src="Img/banner3.png" class="d-block w-100" alt="Khuyến Mãi 3">
    </div>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#saleBanner" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#saleBanner" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

<footer class="py-3 text-center">
  <p>&copy; 2025 NamHung. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>