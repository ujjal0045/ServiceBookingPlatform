<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - ServiceBook</title>
	<!-- Bootstrap CSS -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <!-- Custom CSS -->

    <link rel="stylesheet" href="Styles/login.css">
</head>
<body>
	<header>
		<div class="brand">
			<img alt="" src="image/logo.jpeg">
			<h2>ServiceBook</h2>
		</div>
		<div>
			<a href="login.jsp" class="btn btn-light">Login</a>
			<a href="register.jsp" class="btn btn-primary">Register</a>
		</div>
	</header>
	<main>
		<div class="login-card">
		    <h2>Welcome Back!</h2>
		    <p>
		        Login to your account to book services,track your technician and more.
		    </p>
		    <div class="features">
		        <div class="feature">
		            <i class="bi bi-shield-check"></i>
		            <span>Trusted Service Providers</span>
		        </div>
		        <div class="feature">
		            <i class="bi bi-calendar-check"></i>
		            <span>Easy & Quick Booking</span>
		        </div>
		        <div class="feature">
		            <i class="bi bi-star-fill"></i>
		            <span>Reliable Quality Services</span>
		        </div>
		    </div>
		</div>
		<div class="login-card">
			<h2>Login to Your Account</h2>
			<form action="LoginServlet" method="post">
				<div class="mb-3">
			        <label for="name" class="form-label">
			           	UserName
			        </label>
			
			        <input
			            type="text"
			            class="form-control"
			            id="name"
			            name="username"
			            placeholder="Enter your username"
			            required>
			    </div>
			    <!-- Password -->
			    <div class="mb-3">
			        <label for="password" class="form-label">
			            Password
			        </label>
			        <input
			            type="password"
			            class="form-control"
			            id="password"
			            name="password"
			            placeholder="Create a password"
			            required>
			    </div>
			    
			    <div class="forgotpass">
				    <a href="#">Forgot password?</a>
				</div>
			    
			    <!-- Login -->
			    <button type="submit" class="btn btn-primary w-100 login-submit">
				    Login
				</button>
				</form>
				<div class="registerOption">
    					<p>Don't have an account? <a href="register.jsp">Register</a></p>
				</div>
		</div>	
			
	</main>
</body>
</html>