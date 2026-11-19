<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>ServiceBook</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="Styles/index.css">
</head>

<body>

    <!-- ================= NAVBAR ================= -->

    <header class="navbar-section">

        <div class="container">

            <nav class="navbar navbar-expand-lg">

                <!-- Logo -->
                <a class="navbar-brand logo-section" href="#">

                    <img src="image/logo.jpeg" alt="ServiceBook Logo">

                    <span>ServiceBook</span>

                </a>


                <!-- Mobile Toggle -->
                <button class="navbar-toggler" type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarContent">

                    <span class="navbar-toggler-icon"></span>

                </button>


                <!-- Navigation -->
                <div class="collapse navbar-collapse" id="navbarContent">

                    <ul class="navbar-nav mx-auto">

                        <li class="nav-item">
                            <a class="nav-link active" href="#">Home</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#">Services</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#">About</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="#">Contact</a>
                        </li>

                    </ul>


                    <!-- Buttons -->

                    <div class="auth-buttons">

                        <a class="btn btn-light login-btn">
    							Login
						</a>

                        <a class="btn btn-primary register-btn">
                            Register
                        </a>

                    </div>

                </div>

            </nav>

        </div>

    </header>


    <!-- ================= MAIN ================= -->

    <main>

        <!-- ================= HERO ================= -->

        <section class="hero-section">

    <div class="container">

        <div class="hero-box">

            <div class="hero-content">

                <h1>
                    Book Trusted Service
                    Professionals Near You
                </h1>

                <p>
                    Home services at your convenience,
                    fast, reliable, and professional.
                </p>

                <form class="search-form">

                    <div class="input-group">

                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>

                        <input
                            type="text"
                            class="form-control"
                            placeholder="Search for a service...">

                        <button class="btn btn-primary search-btn login-btn">
                            Search
                        </button>

                    </div>

                </form>

            </div>

        </div>

    </div>

</section>


        <!-- ================= SERVICES ================= -->

        <section class="services-section">

            <div class="container">

                <!-- Heading -->

                <div class="services-heading">

                    <h2>Popular Services</h2>

                    <a href="#">
                        View All
                        <i class="bi bi-arrow-right"></i>
                    </a>

                </div>


                <!-- Cards -->

                <div class="row g-4">

                    <!-- Plumber -->

                    <div class="col-6 col-md-4 col-lg">

                        <div class="service-card">

                            <div class="service-icon plumber">
                                <i class="bi bi-wrench-adjustable"></i>
                            </div>

                            <h4>Plumber</h4>

                        </div>

                    </div>


                    <!-- AC Repair -->

                    <div class="col-6 col-md-4 col-lg">

                        <div class="service-card">

                            <div class="service-icon ac">
                                <i class="bi bi-snow"></i>
                            </div>

                            <h4>AC Repair</h4>

                        </div>

                    </div>


                    <!-- Laptop -->

                    <div class="col-6 col-md-4 col-lg">

                        <div class="service-card">

                            <div class="service-icon laptop">
                                <i class="bi bi-laptop"></i>
                            </div>

                            <h4>Laptop Repair</h4>

                        </div>

                    </div>


                    <!-- Cleaning -->

                    <div class="col-6 col-md-4 col-lg">

                        <div class="service-card">

                            <div class="service-icon cleaning">
                                <i class="bi bi-house-door-fill"></i>
                            </div>

                            <h4>Cleaning</h4>

                        </div>

                    </div>


                    <!-- Painting -->

                    <div class="col-6 col-md-4 col-lg">

                        <div class="service-card">

                            <div class="service-icon painting">
                                <i class="bi bi-palette-fill"></i>
                            </div>

                            <h4>Painting</h4>

                        </div>

                    </div>

                </div>

            </div>

        </section>

    </main>


    <!-- Bootstrap JS -->

    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js">
    </script>
	<script src="Scripts/index.js"></script>
</body>

</html>