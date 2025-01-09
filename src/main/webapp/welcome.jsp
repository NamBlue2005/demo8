<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
  // Kiểm tra người dùng đã đăng nhập hay chưa
  String userEmail = (session != null) ? (String) session.getAttribute("userEmail") : null;

  if (userEmail == null) {
    // Chuyển hướng về trang login.jsp nếu chưa đăng nhập
    response.sendRedirect("login.jsp");
    return;
  }

  // Kết nối đến cơ sở dữ liệu và lấy danh sách sản phẩm
  Connection connection = null;
  PreparedStatement statement = null;
  ResultSet resultSet = null;
  String errorMessage = null;

  try {
    // Nạp driver JDBC MySQL
    Class.forName("com.mysql.cj.jdbc.Driver");
    // Kết nối đến cơ sở dữ liệu
    connection = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/quanlybanhangcongnghe", "username", "password");

    // Lấy danh sách sản phẩm từ bảng Product
    String sql = "SELECT * FROM Product";
    statement = connection.prepareStatement(sql);
    resultSet = statement.executeQuery();

  } catch (ClassNotFoundException e) {
    errorMessage = "Không tìm thấy driver JDBC MySQL.";
    e.printStackTrace(); // In ra console server
  } catch (SQLException e) {
    errorMessage = "Lỗi kết nối cơ sở dữ liệu. Vui lòng thử lại sau.";
    e.printStackTrace(); // In ra console server
  }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>NamHùngStore</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #fff8e1;
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
<header class="bg-warning py-3 text-white text-center">
  <h1>NamHùngStore</h1>
</header>

<div class="container mt-4">
  <%
    if (errorMessage != null) {
      // Hiển thị lỗi nếu có
  %>
  <div class="alert alert-danger" role="alert">
    <%= errorMessage %>
  </div>
  <%
  } else {
  %>
  <h2 class="text-center mb-4">Danh sách sản phẩm</h2>
  <div class="row">
    <%
      if (resultSet != null) {
        while (resultSet.next()) {
          String productId = resultSet.getString("ProductID");
          String productName = resultSet.getString("ProductName");
          String description = resultSet.getString("Description");
          String imageURL = resultSet.getString("ImageURL");
          double price = resultSet.getDouble("Price");
    %>
    <div class="col-md-3 mb-4">
      <div class="card">
        <img src="<%= imageURL %>" class="card-img-top" alt="<%= productName %>">
        <div class="card-body text-center">
          <h5 class="card-title"><%= productName %></h5>
          <p class="card-text"><%= description %></p>
          <p class="card-text">Giá: <strong><%= price %> VND</strong></p>
          <form action="addToCart" method="POST">
            <input type="hidden" name="productId" value="<%= productId %>">
            <input type="hidden" name="quantity" value="1">
            <button type="submit" class="btn btn-dark">Thêm vào giỏ hàng</button>
          </form>
        </div>
      </div>
    </div>
    <%
      }
    } else {
    %>
    <p class="text-center">Không có sản phẩm để hiển thị.</p>
    <%
      }
    %>
  </div>
  <%
    }
  %>
</div>

<footer class="bg-dark text-white text-center py-3">
  &copy; 2025 NamHùngStore. All rights reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
  // Đóng tài nguyên sau khi sử dụng
  try {
    if (resultSet != null) resultSet.close();
    if (statement != null) statement.close();
    if (connection != null) connection.close();
  } catch (SQLException e) {
    e.printStackTrace();
  }
%>