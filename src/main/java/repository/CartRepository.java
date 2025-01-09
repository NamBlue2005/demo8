package repository;

import model.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartRepository {

    // Lấy CartID từ CustomerID hoặc tạo cart mới nếu chưa tồn tại
    public static int getCartIdByCustomerId(int customerId) {
        String query = "SELECT CartID FROM Cart WHERE CustomerID = ?";
        try (Connection connection = BaseRepository.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, customerId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("CartID");
            }

            // Nếu giỏ hàng chưa tồn tại, tạo mới
            String insertQuery = "INSERT INTO Cart (CustomerID) VALUES (?)";
            try (PreparedStatement insertStmt = connection.prepareStatement(insertQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                insertStmt.setInt(1, customerId);
                insertStmt.executeUpdate();
                ResultSet keys = insertStmt.getGeneratedKeys();
                if (keys.next()) {
                    return keys.getInt(1); // Trả về CartID vừa tạo
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong getCartIdByCustomerId: " + e.getMessage());
        }
        return -1;
    }

    // Thêm sản phẩm hoặc cập nhật số lượng trong giỏ hàng
    public static boolean addOrUpdateCartItem(int cartId, int productId, int quantity, double price) {
        String checkQuery = "SELECT CartItemID, Quantity FROM CartItems WHERE CartID = ? AND ProductID = ?";
        String insertQuery = "INSERT INTO CartItems (CartID, ProductID, Quantity, Price) VALUES (?, ?, ?, ?)";
        String updateQuery = "UPDATE CartItems SET Quantity = ?, Price = ? WHERE CartItemID = ?";

        try (Connection connection = BaseRepository.getConnection()) {
            PreparedStatement checkStmt = connection.prepareStatement(checkQuery);
            checkStmt.setInt(1, cartId);
            checkStmt.setInt(2, productId);
            ResultSet resultSet = checkStmt.executeQuery();

            if (resultSet.next()) {
                // Cập nhật nếu sản phẩm đã tồn tại
                int cartItemId = resultSet.getInt("CartItemID");
                int currentQuantity = resultSet.getInt("Quantity");

                PreparedStatement updateStmt = connection.prepareStatement(updateQuery);
                updateStmt.setInt(1, currentQuantity + quantity);
                updateStmt.setDouble(2, price);
                updateStmt.setInt(3, cartItemId);
                updateStmt.executeUpdate();
            } else {
                // Nếu sản phẩm chưa tồn tại, thêm mới
                PreparedStatement insertStmt = connection.prepareStatement(insertQuery);
                insertStmt.setInt(1, cartId);
                insertStmt.setInt(2, productId);
                insertStmt.setInt(3, quantity);
                insertStmt.setDouble(4, price);
                insertStmt.executeUpdate();
            }

            return true;
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong addOrUpdateCartItem: " + e.getMessage());
        }
        return false;
    }

    // Cập nhật số lượng của một sản phẩm trong giỏ hàng
    public static boolean updateCartItemQuantity(int cartId, int productId, int newQuantity) {
        String updateQuery = "UPDATE CartItems SET Quantity = ? WHERE CartID = ? AND ProductID = ?";
        try (Connection connection = BaseRepository.getConnection();
             PreparedStatement statement = connection.prepareStatement(updateQuery)) {

            statement.setInt(1, newQuantity);
            statement.setInt(2, cartId);
            statement.setInt(3, productId);
            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong updateCartItemQuantity: " + e.getMessage());
            return false;
        }
    }

    // Xóa một sản phẩm khỏi giỏ hàng
    public static boolean removeCartItem(int cartId, int productId) {
        String deleteQuery = "DELETE FROM CartItems WHERE CartID = ? AND ProductID = ?";
        try (Connection connection = BaseRepository.getConnection();
             PreparedStatement statement = connection.prepareStatement(deleteQuery)) {

            statement.setInt(1, cartId);
            statement.setInt(2, productId);
            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong removeCartItem: " + e.getMessage());
            return false;
        }
    }

    // Lấy danh sách sản phẩm trong giỏ hàng theo CartID
    public static List<CartItem> getCartItemsByCartId(int cartId) {
        List<CartItem> cartItems = new ArrayList<>();
        String query = "SELECT * FROM CartItems WHERE CartID = ?";

        try (Connection connection = BaseRepository.getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, cartId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                CartItem cartItem = new CartItem(
                        resultSet.getInt("CartItemID"),
                        cartId,
                        resultSet.getInt("ProductID"),
                        resultSet.getInt("Quantity"),
                        resultSet.getDouble("Price")
                );
                cartItems.add(cartItem); // Thêm từng CartItem vào danh sách
            }
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong getCartItemsByCartId: " + e.getMessage());
        }

        return cartItems;
    }
}