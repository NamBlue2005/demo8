package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartRepository {

    public static int getCartIdByCustomerId(int customerId) {
        String query = "SELECT CartID FROM Cart WHERE CustomerID = ?";
        try (Connection connection = BaseRepository.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, customerId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("CartID");
            }

            // Nếu không tồn tại giỏ hàng, tạo mới
            String insertQuery = "INSERT INTO Cart (CustomerID) VALUES (?)";
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                insertStmt.setInt(1, customerId);
                insertStmt.executeUpdate();
                ResultSet keys = insertStmt.getGeneratedKeys();
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong getCartIdByCustomerId: " + e.getMessage());
        }
        return -1; // Trả về -1 nếu xảy ra lỗi
    }

    public static boolean addOrUpdateCartItem(int cartId, int productId, int quantity, double price) {
        String checkQuery = "SELECT CartItemID, Quantity, Price FROM CartItems WHERE CartID = ? AND ProductID = ?";
        String insertQuery = "INSERT INTO CartItems (CartID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";
        String updateQuery = "UPDATE CartItems SET Quantity = ?, Price = ? WHERE CartItemID = ?";

        try (Connection connection = BaseRepository.getConnection()) {
            // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
            PreparedStatement checkStmt = connection.prepareStatement(checkQuery);
            checkStmt.setInt(1, cartId);
            checkStmt.setInt(2, productId);
            ResultSet resultSet = checkStmt.executeQuery();

            if (resultSet.next()) {
                // Nếu sản phẩm đã tồn tại, cập nhật số lượng và giá
                int cartItemId = resultSet.getInt("CartItemID");
                int currentQuantity = resultSet.getInt("Quantity");

                PreparedStatement updateStmt = connection.prepareStatement(updateQuery);
                updateStmt.setInt(1, currentQuantity + quantity); // Cộng dồn số lượng
                updateStmt.setDouble(2, price); // Cập nhật giá mới
                updateStmt.setInt(3, cartItemId);
                updateStmt.executeUpdate();
            } else {
                // Nếu sản phẩm chưa tồn tại, thêm mới
                PreparedStatement insertStmt = connection.prepareStatement(insertQuery);
                insertStmt.setInt(1, cartId);
                insertStmt.setInt(2, productId);
                insertStmt.setInt(3, quantity); // Thêm số lượng
                insertStmt.setDouble(4, price); // Thêm giá
                insertStmt.executeUpdate();
            }

            return true; // Thành công
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong addOrUpdateCartItem: " + e.getMessage());
        }

        return false; // Thất bại
    }

}