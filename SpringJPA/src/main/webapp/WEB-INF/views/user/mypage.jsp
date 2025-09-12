<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/img/favicon.png">
    <title>
        Material Kit 2 by Creative Tim
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
    <!-- Nucleo Icons -->
    <link href="/css/nucleo-icons.css" rel="stylesheet" />
    <link href="/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="/css/material-kit.css?v=3.0.0" rel="stylesheet" />
</head>

<body class="blog-author bg-gray-200">
<!-- Navbar Transparent -->
<<nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3  navbar-transparent ">
    <div class="container">
        <a class="navbar-brand  text-white " href="/"  title="Designed and Coded by Creative Tim" data-placement="bottom">
            메인페이지
        </a>
        <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon mt-2">
          <span class="navbar-toggler-bar bar1"></span>
          <span class="navbar-toggler-bar bar2"></span>
          <span class="navbar-toggler-bar bar3"></span>
        </span>
        </button>
        <div class="collapse navbar-collapse w-100 pt-3 pb-2 py-lg-0 ms-lg-12 ps-lg-5" id="navigation">
            <ul class="navbar-nav navbar-nav-hover ms-auto">
                <li class="nav-item dropdown dropdown-hover mx-2 ms-lg-6">
                    <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuPages8" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
                        mypage
                        <img src="/img/down-arrow-white.svg" alt="down-arrow" class="arrow ms-2 d-lg-block d-none">
                        <img src="/img/down-arrow-dark.svg" alt="down-arrow" class="arrow ms-2 d-lg-none d-block">
                    </a>
                    <div class="dropdown-menu dropdown-menu-animation ms-n3 dropdown-md p-3 border-radius-lg mt-0 mt-lg-3" aria-labelledby="dropdownMenuPages8">
                        <div class="d-none d-lg-block">
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                내 정보
                            </h6>
                            <a href="/user/mypage" class="dropdown-item border-radius-md">
                                <span>내 정보 확인</span>
                            </a>
                        </div>
                        <div class="d-lg-none">
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                Landing Pages
                            </h6>
                            <a href="../pages/about-us.html" class="dropdown-item border-radius-md">
                                <span>About Us</span>
                            </a>
                            <a href="../pages/contact-us.html" class="dropdown-item border-radius-md">
                                <span>Contact Us</span>
                            </a>
                            <a href="../pages/author.html" class="dropdown-item border-radius-md">
                                <span>Author</span>
                            </a>
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1 mt-3">
                                Account
                            </h6>
                            <a href="../pages/sign-in.html" class="dropdown-item border-radius-md">
                                <span>Sign In</span>
                            </a>
                        </div>
                    </div>
                </li>
                <li class="nav-item dropdown dropdown-hover mx-2">
                    <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuBlocks" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons opacity-6 me-2 text-md">view_day</i>
                        Study
                        <img src="/img/down-arrow-white.svg" alt="down-arrow" class="arrow ms-2 d-lg-block d-none">
                        <img src="/img/down-arrow-dark.svg" alt="down-arrow" class="arrow ms-2 d-lg-none d-block">
                    </a>
                    <div class="dropdown-menu dropdown-menu-animation ms-n3 dropdown-md p-3 border-radius-lg mt-0 mt-lg-3" aria-labelledby="dropdownMenuPages8">
                        <div class="d-none d-lg-block">
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                공부
                            </h6>
                            <a href="/study/study" class="dropdown-item border-radius-md">
                                <span>공부하기</span>
                            </a>
                        </div>
                        <ul class="dropdown-menu dropdown-menu-animation dropdown-menu-end dropdown-md dropdown-md-responsive p-3 border-radius-lg mt-0 mt-lg-3" aria-labelledby="dropdownMenuBlocks">
                            <div class="d-none d-lg-block">
                            </div>

                        </ul>
                    </div>
                </li>
                <li class="nav-item dropdown dropdown-hover mx-2">
                    <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" id="dropdownMenuDocs" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons opacity-6 me-2 text-md">article</i>
                        studyRecode
                        <img src="/img/down-arrow-white.svg" alt="down-arrow" class="arrow ms-2 d-lg-block d-none">
                        <img src="/img/down-arrow-dark.svg" alt="down-arrow" class="arrow ms-2 d-lg-none d-block">
                    </a>
                    <div class="dropdown-menu dropdown-menu-animation ms-n3 dropdown-md p-3 border-radius-lg mt-0 mt-lg-3" aria-labelledby="dropdownMenuPages8">
                        <div class="d-none d-lg-block">
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                공부
                            </h6>
                            <a href="/study/studyRecode" class="dropdown-item border-radius-md">
                                <span>공부기록보기</span>
                            </a>
                        </div>
                        <ul class="dropdown-menu dropdown-menu-animation dropdown-menu-end dropdown-md dropdown-md-responsive mt-0 mt-lg-3 p-3 border-radius-lg" aria-labelledby="dropdownMenuDocs">
                            <div class="d-none d-lg-block">

                            </div>

                        </ul>
                    </div>
                <li class="nav-item ms-lg-auto">
                </li>
                <li class="nav-item my-auto ms-3 ms-lg-0">
                    <a href="https://www.creative-tim.com/product/material-kit-pro" class="btn btn-sm  bg-white  mb-0 me-1 mt-2 mt-md-0">로그아웃</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- End Navbar -->
<!-- -------- START HEADER 4 w/ search book a ticket form ------- -->
<header>
    <div class="page-header min-height-400" style="background-image: url('//img/city-profile.jpg');" loading="lazy">
        <span class="mask bg-gradient-dark opacity-8"></span>
    </div>
</header>
<!-- -------- END HEADER 4 w/ search book a ticket form ------- -->
<div class="card card-body blur shadow-blur mx-3 mx-md-4 mt-n6 mb-4">
    <!-- START Testimonials w/ user image & text & info -->
    <section class="py-sm-7 py-5 position-relative">
        <div class="container">
            <div class="row">
                <div class="col-12 mx-auto">
                    <div class="mt-n8 mt-md-n9 text-center">
                        <img class="avatar avatar-xxl shadow-xl position-relative z-index-2" src="/img/bruce-mars.jpg" alt="bruce" loading="lazy">
                    </div>
                    <div class="row py-5">
                        <div class="col-lg-7 col-md-7 z-index-2 position-relative px-md-2 px-sm-5 mx-auto">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h3 class="mb-0">Michael Roven</h3>
                                <div class="d-block">
                                    <button type="button" class="btn btn-sm btn-outline-info text-nowrap mb-0">Follow</button>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-auto">
                                    <span class="h6">323</span>
                                    <span>Posts</span>
                                </div>
                                <div class="col-auto">
                                    <span class="h6">3.5k</span>
                                    <span>Followers</span>
                                </div>
                                <div class="col-auto">
                                    <span class="h6">260</span>
                                    <span>Following</span>
                                </div>
                            </div>
                            <p class="text-lg mb-0">
                                Decisions: If you can’t decide, the answer is no.
                                If two equally difficult paths, choose the one more
                                painful in the short term (pain avoidance is creating
                                an illusion of equality). Choose the path that leaves
                                you more equanimous. <br><a href="javascript:;" class="text-info icon-move-right">More about me
                                <i class="fas fa-arrow-right text-sm ms-1"></i>
                            </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- END Testimonials w/ user image & text & info -->
    <!-- START Blogs w/ 4 cards w/ image & text & link -->
    <section class="py-3">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <h3 class="mb-5">Check my latest blogposts</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="card card-plain">
                        <div class="card-header p-0 position-relative">
                            <a class="d-block blur-shadow-image">
                                <img src="/img/examples/testimonial-6-2.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg" loading="lazy">
                            </a>
                        </div>
                        <div class="card-body px-0">
                            <h5>
                                <a href="javascript:;" class="text-dark font-weight-bold">Rover raised $65 million</a>
                            </h5>
                            <p>
                                Finding temporary housing for your dog should be as easy as
                                renting an Airbnb. That’s the idea behind Rover ...
                            </p>
                            <a href="javascript:;" class="text-info text-sm icon-move-right">Read More
                                <i class="fas fa-arrow-right text-xs ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card card-plain">
                        <div class="card-header p-0 position-relative">
                            <a class="d-block blur-shadow-image">
                                <img src="/img/examples/testimonial-6-3.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg" loading="lazy">
                            </a>
                        </div>
                        <div class="card-body px-0">
                            <h5>
                                <a href="javascript:;" class="text-dark font-weight-bold">MateLabs machine learning</a>
                            </h5>
                            <p>
                                If you’ve ever wanted to train a machine learning model
                                and integrate it with IFTTT, you now can with ...
                            </p>
                            <a href="javascript:;" class="text-info text-sm icon-move-right">Read More
                                <i class="fas fa-arrow-right text-xs ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="card card-plain">
                        <div class="card-header p-0 position-relative">
                            <a class="d-block blur-shadow-image">
                                <img src="/img/examples/blog-9-4.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-lg" loading="lazy">
                            </a>
                        </div>
                        <div class="card-body px-0">
                            <h5>
                                <a href="javascript:;" class="text-dark font-weight-bold">MateLabs machine learning</a>
                            </h5>
                            <p>
                                If you’ve ever wanted to train a machine learning model
                                and integrate it with IFTTT, you now can with ...
                            </p>
                            <a href="javascript:;" class="text-info text-sm icon-move-right">Read More
                                <i class="fas fa-arrow-right text-xs ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-12 col-12">
                    <div class="card card-blog card-background cursor-pointer">F
                        <div class="full-background" style="background-image: url('/img/examples/blog2.jpg')" loading="lazy"></div>
                        <div class="card-body">
                            <div class="content-left text-start my-auto py-4">
                                <h2 class="card-title text-white">Flexible work hours</h2>
                                <p class="card-description text-white">Rather than worrying about switching offices every couple years, you stay in the same place.</p>
                                <a href="javascript:;" class="text-white text-sm icon-move-right">Read More
                                    <i class="fas fa-arrow-right text-xs ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- END Blogs w/ 4 cards w/ image & text & link -->
</div>
<section class="py-lg-5">
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card box-shadow-xl overflow-hidden mb-5">
                    <div class="row">
                        <div class="col-lg-5 position-relative bg-cover px-0" style="background-image: url('/img/examples/blog2.jpg')" loading="lazy">
                            <div class="z-index-2 text-center d-flex h-100 w-100 d-flex m-auto justify-content-center">
                                <div class="mask bg-gradient-dark opacity-8"></div>
                                <div class="p-5 ps-sm-8 position-relative text-start my-auto z-index-2">
                                    <h3 class="text-white">Contact Information</h3>
                                    <p class="text-white opacity-8 mb-4">Fill up the form and our Team will get back to you within 24 hours.</p>
                                    <div class="d-flex p-2 text-white">
                                        <div>
                                            <i class="fas fa-phone text-sm"></i>
                                        </div>
                                        <div class="ps-3">
                                            <span class="text-sm opacity-8">(+40) 772 100 200</span>
                                        </div>
                                    </div>
                                    <div class="d-flex p-2 text-white">
                                        <div>
                                            <i class="fas fa-envelope text-sm"></i>
                                        </div>
                                        <div class="ps-3">
                                            <span class="text-sm opacity-8">hello@creative-tim.com</span>
                                        </div>
                                    </div>
                                    <div class="d-flex p-2 text-white">
                                        <div>
                                            <i class="fas fa-map-marker-alt text-sm"></i>
                                        </div>
                                        <div class="ps-3">
                                            <span class="text-sm opacity-8">Dyonisie Wolf Bucharest, RO 010458</span>
                                        </div>
                                    </div>
                                    <div class="mt-4">
                                        <button type="button" class="btn btn-icon-only btn-link text-white btn-lg mb-0" data-toggle="tooltip" data-placement="bottom" data-original-title="Log in with Facebook">
                                            <i class="fab fa-facebook"></i>
                                        </button>
                                        <button type="button" class="btn btn-icon-only btn-link text-white btn-lg mb-0" data-toggle="tooltip" data-placement="bottom" data-original-title="Log in with Twitter">
                                            <i class="fab fa-twitter"></i>
                                        </button>
                                        <button type="button" class="btn btn-icon-only btn-link text-white btn-lg mb-0" data-toggle="tooltip" data-placement="bottom" data-original-title="Log in with Dribbble">
                                            <i class="fab fa-dribbble"></i>
                                        </button>
                                        <button type="button" class="btn btn-icon-only btn-link text-white btn-lg mb-0" data-toggle="tooltip" data-placement="bottom" data-original-title="Log in with Instagram">
                                            <i class="fab fa-instagram"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-7">
                            <form class="p-3" id="contact-form" method="post">
                                <div class="card-header px-4 py-sm-5 py-3">
                                    <h2>Say Hi!</h2>
                                    <p class="lead"> We'd like to talk with you.</p>
                                </div>
                                <div class="card-body pt-1">
                                    <div class="row">
                                        <div class="col-md-12 pe-2 mb-3">
                                            <div class="input-group input-group-static mb-4">
                                                <label>My name is</label>
                                                <input type="text" class="form-control" placeholder="Full Name">
                                            </div>
                                        </div>
                                        <div class="col-md-12 pe-2 mb-3">
                                            <div class="input-group input-group-static mb-4">
                                                <label>I'm looking for</label>
                                                <input type="text" class="form-control" placeholder="What you love">
                                            </div>
                                        </div>
                                        <div class="col-md-12 pe-2 mb-3">
                                            <div class="input-group input-group-static mb-4">
                                                <label>Your message</label>
                                                <textarea name="message" class="form-control" id="message" rows="6" placeholder="I want to say that..."></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 text-end ms-auto">
                                            <button type="submit" class="btn bg-gradient-info mb-0">Send Message</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- -------- START FOOTER 5 w/ DARK BACKGROUND ------- -->
<footer class="footer py-5">
    <div class="container z-index-1 position-relative">
        <div class="row">
            <div class="col-lg-4 me-auto mb-lg-0 mb-4 text-lg-start text-center">
                <h6 class="text-dark font-weight-bolder text-uppercase mb-lg-4 mb-3">Material Design</h6>
                <ul class="nav flex-row ms-n3 justify-content-lg-start justify-content-center mb-4 mt-sm-0">
                    <li class="nav-item">
                        <a class="nav-link text-dark opacity-8" href="https://www.creative-tim.com" target="_blank">
                            Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark opacity-8" href="https://www.creative-tim.com/presentation" target="_blank">
                            About
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark opacity-8" href="https://www.creative-tim.com/blog" target="_blank">
                            Blog
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark opacity-8" href="https://www.creative-tim.com" target="_blank">
                            Services
                        </a>
                    </li>
                </ul>
                <p class="text-sm text-dark opacity-8 mb-0">
                    Copyright © <script>
                    document.write(new Date().getFullYear())
                </script> Material Design by Creative Tim.
                </p>
            </div>
            <div class="col-lg-6 ms-auto text-lg-end text-center">
                <p class="mb-5 text-lg text-dark font-weight-bold">
                    The reward for getting on the stage is fame. The price of fame is you can’t get off the stage.
                </p>
                <a href="javascript:;" target="_blank" class="text-dark me-xl-4 me-4 opacity-5">
                    <span class="fab fa-dribbble"></span>
                </a>
                <a href="javascript:;" target="_blank" class="text-dark me-xl-4 me-4 opacity-5">
                    <span class="fab fa-twitter"></span>
                </a>
                <a href="javascript:;" target="_blank" class="text-dark me-xl-4 me-4 opacity-5">
                    <span class="fab fa-pinterest"></span>
                </a>
                <a href="javascript:;" target="_blank" class="text-dark opacity-5">
                    <span class="fab fa-github"></span>
                </a>
            </div>
        </div>
    </div>
</footer>
<!-- -------- END FOOTER 5 w/ DARK BACKGROUND ------- -->
<!--   Core JS Files   -->
<script src="/js/core/popper.min.js" type="text/javascript"></script>
<script src="/js/core/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/plugins/perfect-scrollbar.min.js"></script>
<!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
<script src="/js/plugins/parallax.min.js"></script>
<!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
<!--  Google Maps Plugin    -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
<script src="/js/material-kit.min.js?v=3.0.0" type="text/javascript"></script>
</body>
</html>