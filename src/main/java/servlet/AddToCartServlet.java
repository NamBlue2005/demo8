package servlet;

import repository.CartRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy thông tin từ request
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price")); // Lấy giá sản phẩm từ request

            // Lấy userID (khách hàng) từ phiên làm việc
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                // Nếu chưa đăng nhập
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy mã CartID
            int cartId = CartRepository.getCartIdByCustomerId(userId);

            // Thêm sản phẩm vào giỏ hàng cùng với giá
            boolean success = CartRepository.addOrUpdateCartItem(cartId, productId, quantity, price);

            if (success) {
                response.sendRedirect("cart-list.jsp?message=success");
            } else {
                response.sendRedirect("cart-list.jsp?message=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("cart-list.jsp?message=invalidInput");
        } catch (IOException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xử lý Input/Output");
        }
    }
}