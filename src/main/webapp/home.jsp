<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>NamHùngStore - Đăng Nhập Hoặc Đăng Ký</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
            padding: 10px 0;
        }

        .logo {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
        }

        footer {
            background: #e64a19;
            color: white;
            padding: 10px 0;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        .container {
            text-align: center;
            margin-top: 100px;
        }

        .btn-login, .btn-register {
            padding: 10px 20px;
            margin: 10px;
        }

        .btn-login {
            background-color: #ff5722;
            border: none;
            color: white;
        }

        .btn-login:hover {
            background-color: #e64a19;
        }

        .btn-register {
            background-color: #ffc107;
            border: none;
            color: white;
        }

        .btn-register:hover {
            background-color: #ffb300;
        }
    </style>
</head>
<body>
<header class="text-center">
    <h1 class="logo">NamHùng Store</h1>
</header>

<div class="container">
    <h2>Chào mừng đến với NamHùng Store!</h2>
    <p class="mt-3">Để bắt đầu mua sắm, bạn cần đăng nhập hoặc đăng ký tài khoản.</p>

    <div class="mt-4">
        <a href="login.jsp" class="btn btn-login">Đăng Nhập</a>
        <a href="register.jsp" class="btn btn-register">Đăng Ký</a>
    </div>
</div>

<footer class="text-center">
    <p>&copy; 2025 NamHung. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>