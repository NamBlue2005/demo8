<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.CartItem" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Kiểm tra xem người dùng đã đăng nhập chưa
    String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

    if (userEmail == null) {
        // Nếu chưa đăng nhập, chuyển hướng đến login.jsp
        response.sendRedirect("login.jsp");
        return;
    }

    // Lấy giỏ hàng từ session
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        // Nếu giỏ hàng trống, định nghĩa cart rỗng
        cart = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng & Thanh Toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">

    <!-- Hiển thị giỏ hàng -->
    <h1 class="text-center">Giỏ Hàng Của Bạn</h1>
    <hr>
    <c:choose>
        <c:when test="${cart == null || cart.size() == 0}">
            <p class="text-center text-secondary mt-4">Giỏ hàng hiện đang trống.</p>
        </c:when>
        <c:otherwise>
            <table class="table table-bordered">
                <thead class="table-light">
                <tr>
                    <th>#</th>
                    <th>ID Sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${cart}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td>
                        <td>${item.productId}</td>
                        <td>${item.productName}</td>
                        <td>${item.productPrice} VND</td>
                        <td>${item.quantity}</td>
                        <td>${item.quantity * item.productPrice} VND</td>
                        <td>
                            <a href="removeCartItem?productId=${item.productId}" class="btn btn-danger btn-sm">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <!-- Tổng tiền -->
            <div class="text-end mt-3">
                <strong>Tổng tiền:</strong>
                <c:set var="totalPrice" value="0" />
                <c:forEach var="item" items="${cart}">
                    <c:set var="totalPrice" value="${totalPrice + (item.quantity * item.productPrice)}" />
                </c:forEach>
                    ${totalPrice} VND
            </div>
            <hr>

            <!-- Chuyển đến form thanh toán -->
            <h2>Thông Tin Thanh Toán</h2>
            <form action="processOrder" method="post">
                <div class="mb-4">
                    <h4>Thông tin khách hàng</h4>
                    <p><strong>Email:</strong> <%= userEmail %></p>
                    <p><strong>Địa chỉ giao hàng:</strong></p>
                    <textarea name="shippingAddress" class="form-control" rows="3" required placeholder="Nhập địa chỉ giao hàng của bạn"></textarea>
                </div>
                <div class="text-end mt-4">
                    <button type="submit" class="btn btn-success">Xác Nhận Thanh Toán</button>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>