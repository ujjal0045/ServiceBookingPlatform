<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Register - ServiceBook</title>


    <!-- Bootstrap CSS -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- Bootstrap Icons -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">


    <!-- Custom CSS -->

    <link rel="stylesheet" href="Styles/register.css">

</head>


<body>
	
	<header>
		<div class="brand">
			<img alt="" src="image/logo.jpeg">
			<h2>ServiceBook</h2>
		</div>
		<div>
			<button class="btn btn-light">Login</button>
			<button class="btn btn-primary">Register</button>
		</div>
	</header>

	<main>
		<div class="intro-content">

    <h2>Create Your Account</h2>

    <p>
        Join us and access trusted service providers near you.
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
		<div>
			<h2>Register Page</h2>
			<form action="RegisterServlet" method="post" >

			    <!-- Full Name -->
			    <div class="mb-3">
			        <label for="name" class="form-label">
			            Full Name
			        </label>
			
			        <input
			            type="text"
			            class="form-control"
			            id="name"
			            name="name"
			            placeholder="Enter your full name"
			            required>
			    </div>
			    
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
			
			
			    <!-- Email -->
			    <div class="mb-3">
			        <label for="email" class="form-label">
			            Email Address
			        </label>
			
			        <input
			            type="email"
			            class="form-control"
			            id="email"
			            name="email"
			            placeholder="Enter your email address"
			            required>
			    </div>
			
			
			    <!-- Phone -->
			    <div class="mb-3">
			        <label for="phone" class="form-label">
			            Phone Number
			        </label>
			
			        <input
			            type="tel"
			            class="form-control"
			            id="phone"
			            name="phone"
			            placeholder="Enter your phone number"
			            required>
			    </div>
			
			
			    <!-- Role -->
			    <div class="mb-3">
			        <label for="role" class="form-label">
			            Register As
			        </label>
			
			        <select
			            class="form-select"
			            id="role"
			            name="role"
			            required>
			
			            <option value="customer" selected disabled>
			                Select your role
			            </option>
			
			            <option value="customer">
			                Customer
			            </option>
			
			            <option value="provider">
			                Service Provider
			            </option>
			
			        </select>
			    </div>
				<div id="providerFields" class="provider-fields"  autocomplete="off">

					    <!-- Service Category -->
					    <div class="mb-3">
					        <label class="form-label">Service Category</label>
					        <input type="text" class="form-control"
					               name="serviceCategory"
					               placeholder="e.g. Plumber">
					    </div>
					
					    <!-- Experience -->
					    <div class="mb-3">
					        <label class="form-label">Experience</label>
					        <input type="number" class="form-control"
					               name="experience"
					               placeholder="Years of experience">
					    </div>
					
					    <!-- Location -->
					    <div class="mb-3">
					        <label class="form-label">Location</label>
					        <input type="text" class="form-control"
					               name="location"
					               placeholder="Enter your location">
					    </div>
					
					    <!-- Skills -->
					    <div class="mb-3">
					        <label class="form-label">Skills</label>
					        <input type="text" class="form-control"
					               name="skills"
					               placeholder="e.g. Pipe fitting, Installation">
					    </div>
					
					    <!-- Document Verification -->
					    <div class="mb-3">
					        <label class="form-label">Verification Document</label>
					        <input type="file" class="form-control"
					               name="document">
					    </div>
					
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
			
			
			    <!-- Confirm Password -->
			    <div class="mb-4">
			        <label for="confirmPassword" class="form-label">
			            Confirm Password
			        </label>
			
			        <input
			            type="password"
			            class="form-control"
			            id="confirmPassword"
			            name="confirmPassword"
			            placeholder="Confirm your password"
			            required>
			    </div>
			
			
			    <!-- Register -->
			    <button
			        type="submit"
			        class="btn btn-primary w-100">
			
			        Register
			
			    </button>
	
				</form>
		</div>
	</main>


    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>
	<script src="Scripts/register.js"></script>
</body>

</html>