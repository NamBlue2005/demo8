package servlet;

import repository.CartRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart", "/addToCart", "/updateCart", "/removeFromCart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        if ("/addToCart".equals(action)) {
            addToCart(request, response); // Gọi phương thức thêm sản phẩm vào giỏ
        } else {
            // Xử lý các yêu cầu khác nếu có
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xử lý logic POST (nếu cần)
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Lấy thông tin sản phẩm từ URL
            int cartId = 1; // ID của giỏ hàng (cài tạm hoặc lấy từ session của user)
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = 1; // Mặc định thêm 1 sản phẩm
            double price = 0; // Giá sẽ được lấy từ DB (nếu cần thêm logic)

            // Logic thêm sản phẩm vào giỏ trong database
            CartRepository.addOrUpdateCartItem(cartId, productId, quantity, price);

            // Chuyển hướng về trang danh sách sản phẩm sau khi thêm
            response.sendRedirect("products.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: Không thể thêm sản phẩm vào giỏ hàng.");
        }
    }
}