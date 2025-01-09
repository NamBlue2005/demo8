<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Register</h1>
    <hr>
    <form action="registerCustomer" method="post">
        <div class="mb-3">
            <label for="registerName" class="form-label">Name</label>
            <input type="text" class="form-control" id="registerName" name="name" required>
        </div>
        <div class="mb-3">
            <label for="registerPhone" class="form-label">Phone</label>
            <input type="text" class="form-control" id="registerPhone" name="phone" required>
        </div>
        <div class="mb-3">
            <label for="registerEmail" class="form-label">Email</label>
            <input type="email" class="form-control" id="registerEmail" name="email" required>
        </div>
        <div class="mb-3">
            <label for="registerAddress" class="form-label">Address</label>
            <textarea class="form-control" id="registerAddress" name="address" required></textarea>
        </div>
        <div class="mb-3">
            <label for="registerGender" class="form-label">Gender</label>
            <select class="form-control" id="registerGender" name="gender" required>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="registerPassword" class="form-label">Password</label>
            <input type="password" class="form-control" id="registerPassword" name="password" required>
        </div>
        <button type="submit" class="btn btn-success">Register</button>
        <p class="mt-3">Already have an account? <a href="login.jsp">Login here</a>.</p>
        <c:if test="${not empty registerError}">
            <div class="alert alert-danger mt-3">
                    ${registerError}
            </div>
        </c:if>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>