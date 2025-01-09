<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Trang Chính - NamHùngStore</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
  <h1 class="text-center mb-4">Nam Hùng Store - Sản Phẩm Nổi Bật</h1>

  <c:if test="${not empty featuredProducts}">
    <div class="row">
      <c:forEach var="product" items="${featuredProducts}">
        <div class="col-md-3 mb-4">
          <div class="card h-100">
            <img src="${product.imageUrl}" alt="${product.name}" class="card-img-top" style="height:200px; object-fit:cover;">
            <div class="card-body text-center">
              <h5 class="card-title">${product.name}</h5>
              <p class="text-muted">Loại: ${product.type}</p>
              <p class="text-danger">Giá: ${product.price} VND</p>
              <a href="/product-details.jsp?id=${product.id}" class="btn btn-primary btn-sm">Xem Chi Tiết</a>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>

  <c:if test="${empty featuredProducts}">
    <p class="text-center text-warning">Chưa có sản phẩm được hiển thị!</p>
  </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>