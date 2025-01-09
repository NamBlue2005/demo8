package servlet;

import repository.UserRepository;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/loginCustomer")
public class LoginCustomerServlet extends HttpServlet {
    private final UserRepository userRepository;

    public LoginCustomerServlet() {
        this.userRepository = new UserRepository();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean isValidUser = userRepository.validateLogin(email, password);

        if (isValidUser) {

            HttpSession userSession = request.getSession(false);
            if (userSession == null) {
                userSession = request.getSession();
            }

            userSession.setAttribute("userEmail", email);
            response.sendRedirect("welcome.jsp");
        } else {
            request.setAttribute("loginError", "Email or Password is incorrect!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
            dispatcher.forward(request, response);
        }
    }
}