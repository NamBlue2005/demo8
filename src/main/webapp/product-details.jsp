<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi Tiết Sản Phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Thông Tin Sản Phẩm</h1>
    <div class="row mt-4">
        <div class="col-md-6">
            <img src="${product.imageUrl}" class="img-fluid" alt="${product.name}">
        </div>
        <div class="col-md-6">
            <h2>${product.name}</h2>
            <p>Giá: <strong>${product.price} VND</strong></p>
            <p>Loại sản phẩm: ${product.type}</p>
            <p>Số lượng còn lại: ${product.stockQuantity}</p>
            <hr>
            <form action="addToCart" method="POST" class="mt-3">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="mb-3">
                    <label for="quantity" class="form-label">Số lượng</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" min="1" max="${product.stockQuantity}" required>
                </div>
                <button type="submit" class="btn btn-success">Thêm vào Giỏ Hàng</button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>