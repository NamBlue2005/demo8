package servlet;

import model.CartItem;
import repository.CartRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart", "/addToCart", "/updateCart", "/removeFromCart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/cart":
                viewCart(request, response);
                break;
            case "/addToCart":
                addToCart(request, response);
                break;
            case "/removeFromCart":
                removeFromCart(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Chức năng không được hỗ trợ!");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/addToCart":
                addToCart(request, response);
                break;
            case "/updateCart":
                updateCart(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Chức năng không được hỗ trợ!");
                break;
        }
    }

    // Phương thức xử lý thêm sản phẩm vào giỏ hàng
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Lấy thông tin từ request
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));

            // Lấy user ID từ session
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                // Nếu user chưa đăng nhập
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy cartId và thêm sản phẩm vào giỏ hàng
            int cartId = CartRepository.getCartIdByCustomerId(userId);
            boolean success = CartRepository.addOrUpdateCartItem(cartId, productId, quantity, price);

            if (success) {
                response.sendRedirect("cart-list.jsp?message=success");
            } else {
                response.sendRedirect("cart-list.jsp?message=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("cart-list.jsp?message=invalidInput");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi không xác định xảy ra.");
        }
    }

    // Phương thức xử lý hiển thị giỏ hàng
    private void viewCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy cartId từ userId
            int cartId = CartRepository.getCartIdByCustomerId(userId);

            // Lấy tất cả các sản phẩm trong giỏ
            List<CartItem> cartItems = CartRepository.getCartItemsByCartId(cartId);

            // Đẩy dữ liệu vào request để hiển thị ở JSP
            request.setAttribute("cartItems", cartItems);

            // Chuyển hướng tới trang hiển thị giỏ hàng
            request.getRequestDispatcher("cart-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi hiển thị giỏ hàng.");
        }
    }

    // Phương thức xử lý cập nhật số lượng sản phẩm trong giỏ hàng
    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Lấy thông tin từ request
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy cartId và cập nhật số lượng sản phẩm
            int cartId = CartRepository.getCartIdByCustomerId(userId);
            boolean success = CartRepository.updateCartItemQuantity(cartId, productId, quantity);

            if (success) {
                response.sendRedirect("cart-list.jsp?message=updated");
            } else {
                response.sendRedirect("cart-list.jsp?message=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("cart-list.jsp?message=invalidInput");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi cập nhật giỏ hàng.");
        }
    }

    // Phương thức xử lý xóa sản phẩm khỏi giỏ hàng
    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Lấy thông tin từ request
            int productId = Integer.parseInt(request.getParameter("productId"));

            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy cartId và xóa sản phẩm khỏi giỏ
            int cartId = CartRepository.getCartIdByCustomerId(userId);
            boolean success = CartRepository.removeCartItem(cartId, productId);

            if (success) {
                response.sendRedirect("cart-list.jsp?message=removed");
            } else {
                response.sendRedirect("cart-list.jsp?message=error");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("cart-list.jsp?message=invalidInput");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xóa sản phẩm khỏi giỏ hàng.");
        }
    }
}