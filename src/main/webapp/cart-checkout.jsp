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

    <!-- Tiêu đề -->
    <h1 class="text-center">Giỏ Hàng Của Bạn</h1>
    <hr>

    <!-- Kiểm tra xem giỏ hàng có sản phẩm không -->
    <c:choose>
        <c:when test="${cart == null || cart.size() == 0}">
            <p class="text-center text-secondary mt-4">Giỏ hàng của bạn hiện đang trống.</p>
            <div class="text-center mt-3">
                <a href="products.jsp" class="btn btn-primary">Quay lại cửa hàng</a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Hiển thị giỏ hàng -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-dark">
                    <tr class="text-center">
                        <th>#</th>
                        <th>ID</th>
                        <th>Tên sản phẩm</th>
                        <th>Đơn giá (VND)</th>
                        <th>Số lượng</th>
                        <th>Thành tiền (VND)</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Lặp qua từng sản phẩm trong giỏ hàng -->
                    <c:forEach var="item" items="${cart}" varStatus="status">
                        <tr>
                            <td class="text-center">${status.index + 1}</td>
                            <td class="text-center">${item.productId}</td>
                            <td>${item.productName}</td>
                            <td class="text-end">${item.productPrice}</td>
                            <td class="text-center">
                                <!-- Form cập nhật số lượng -->
                                <form action="updateCartItem" method="POST" style="display:inline-block;">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" style="width: 60px;" class="form-control d-inline-block text-center">
                                    <button type="submit" class="btn btn-outline-primary btn-sm">Cập nhật</button>
                                </form>
                            </td>
                            <td class="text-end">${item.quantity * item.productPrice}</td>
                            <td class="text-center">
                                <!-- Nút xóa sản phẩm -->
                                <a href="removeCartItem?productId=${item.productId}" class="btn btn-danger btn-sm">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Tổng tiền -->
            <div class="text-end mt-4 mb-3">
                <h4>
                    Tổng tiền:
                    <strong>
                        <c:set var="totalPrice" value="0"/>
                        <c:forEach var="item" items="${cart}">
                            <c:set var="totalPrice" value="${totalPrice + (item.quantity * item.productPrice)}"/>
                        </c:forEach>
                            ${totalPrice} VND
                    </strong>
                </h4>
            </div>
            <hr>

            <!-- Form thanh toán -->
            <h2 class="mt-4">Thông Tin Thanh Toán</h2>
            <form action="processOrder" method="post">
                <div class="mb-4">
                    <h5>Thông tin khách hàng</h5>
                    <p><strong>Email:</strong> <%= userEmail %></p>
                </div>
                <div class="mb-3">
                    <label for="shippingAddress" class="form-label">Địa chỉ giao hàng:</label>
                    <textarea name="shippingAddress" class="form-control" id="shippingAddress" rows="3" required placeholder="Nhập địa chỉ giao hàng của bạn"></textarea>
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-success btn-lg">Xác Nhận Thanh Toán</button>
                </div>
            </form>

            <div class="text-center mt-5">
                <a href="products.jsp" class="btn btn-secondary">Tiếp tục mua sắm</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>