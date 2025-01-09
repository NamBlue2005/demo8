package connect;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DBConnectionTest", urlPatterns = {"/testDB"})
public class DBConnectionTestServlet extends HttpServlet {

    // Cấu hình kết nối MySQL
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/QuanLyBanHangCongNghe?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "Namblue2005@"; // Thay bằng mật khẩu MySQL của bạn

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Nạp driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Kết nối cơ sở dữ liệu
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

            if (connection != null) {
                System.out.println("Kết nối cơ sở dữ liệu thành công!");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }


        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body>");
            out.println("<h1>Testing Database Connection</h1>");

            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD)) {
                if (connection != null) {
                    out.println("<p style='color: green;'>Database connection successful!</p>");
                } else {
                    out.println("<p style='color: red;'>Database connection failed!</p>");
                }
            } catch (SQLException e) {
                out.println("<p style='color: red;'>SQLException: " + e.getMessage() + "</p>");
            }

            out.println("</body></html>");
        }
    }
}
