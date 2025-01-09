package servlet;

import model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/removeCartItem")
public class RemoveCartItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        int productId = Integer.parseInt(request.getParameter("productId"));

        if (cart != null) {
            cart.removeIf(item -> item.getProductId() == productId);
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart-list.jsp"); // Quay lại trang giỏ hàng
    }
}