package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRepository {
    public boolean validateLogin(String email, String password) {
        String query = "SELECT * FROM Customer WHERE Email = ? AND Password = ?";
        try (Connection connection = BaseRepository.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();

            return resultSet.next();
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra thông tin đăng nhập: " + e.getMessage());
        }
        return false;
    }
}