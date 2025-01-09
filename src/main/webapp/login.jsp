<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <h1 class="text-center">Welcome Back!</h1>
    <p class="text-center text-secondary">Please enter your credentials to login.</p>
    <hr>
    <form action="loginCustomer" method="post" class="p-4 border shadow rounded">

        <div class="mb-3">
            <label for="loginEmail" class="form-label">Email:</label>
            <input type="email" class="form-control" id="loginEmail" name="email" placeholder="Enter your email" required>
        </div>

        <div class="mb-3">
            <label for="loginPassword" class="form-label">Password:</label>
            <input type="password" class="form-control" id="loginPassword" name="password" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>

        <p class="mt-3 text-center">Don't have an account? <a href="register.jsp">Register here</a>.</p>

        <c:if test="${not empty loginError}">
            <div class="alert alert-danger mt-3 text-center">
                    ${loginError}
            </div>
        </c:if>
    </form>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>