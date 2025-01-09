<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách sản phẩm - NamHùng Store</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .product-card {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            transition: box-shadow 0.3s;
        }

        .product-card:hover {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .product-img {
            max-width: 100%;
            height: auto;
        }

        .product-title {
            font-size: 1.25rem;
            margin: 10px 0;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Danh sách sản phẩm</h1>
    <div class="row mt-4">
        <c:forEach var="product" items="${productList}">
            <div class="col-md-4">
                <div class="product-card">
                    <img src="${product.imageUrl}" alt="${product.name}" class="product-img">
                    <h3 class="product-title">${product.name}</h3>
                    <p class="text-muted">${product.description}</p>
                    <h4 class="text-danger">${product.price} VND</h4>
                    <a href="addToCart?productId=${product.id}" class="btn btn-primary btn-sm">Thêm vào giỏ</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>