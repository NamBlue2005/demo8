package servlet;

import model.Customer;
import repository.CustomerRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterCustomerServlet", urlPatterns = {"/registerCustomer"})
public class RegisterCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");

        String registerError = null;

        if (name == null || name.trim().isEmpty()) {
            registerError = "Tên không được để trống!";
        } else if (email == null || email.trim().isEmpty()) {
            registerError = "Email không được để trống!";
        } else if (CustomerRepository.isEmailDuplicate(email)) {
            registerError = "Email đã tồn tại!";
        } else if (phone == null || phone.trim().isEmpty()) {
            registerError = "Số điện thoại không được để trống!";
        } else if (CustomerRepository.isPhoneDuplicate(phone)) {
            registerError = "Số điện thoại đã tồn tại!";
        }

        if (registerError != null) {
            request.setAttribute("registerError", registerError);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Customer customer = new Customer(0, name, phone, email, address, gender, password);

        try {
            CustomerRepository.addCustomer(customer);
            response.sendRedirect("welcome.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("registerError", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}