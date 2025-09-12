<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--대문페이지이다 . 마이페이지, 공부시작, 공부기록 세가지를 선택하여 들어갈 수 있으며 로그인/로그아웃 기능이 있음-->
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/img/favicon.png">
    <title>
        메인페이지
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700"/>
    <!-- Nucleo Icons -->
    <link href="/css/nucleo-icons.css" rel="stylesheet"/>
    <link href="/css/nucleo-svg.css" rel="stylesheet"/>
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="/css/material-kit.css?v=3.0.0" rel="stylesheet"/>
</head>

<body class="about-us bg-gray-200">
<section class="py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8 mx-auto text-center">
                <div class="ms-3 mb-md-5">
                    <div class="icon icon-shape icon-md bg-gradient-info shadow-info mx-auto text-center mb-4">
                        <i class="material-icons opacity-10">person</i>
                    </div>
                    <h3>모니터링 설정</h3>
                    <p>
                        공부를 시작하기 전 쉬는시간 등 다양한 설정을 진행하세요
                    </p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <div class="card card-plain">
                    <form id="contact-form" method="post" autocomplete="off">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="input-group input-group-static mb-4">
                                        <label>First Name</label>
                                        <input class="form-control" placeholder="eg. Michael" aria-label="First Name..." type="text">
                                    </div>
                                </div>
                                <div class="col-md-6 ps-2">
                                    <div class="input-group input-group-static">
                                        <label>Last Name</label>
                                        <input type="text" class="form-control" placeholder="eg. Jordan" aria-label="Last Name...">
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="input-group input-group-static">
                                    <label>Company</label>
                                    <input type="text" class="form-control" placeholder="eg. Apple Inc.">
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="input-group input-group-static">
                                    <label>Email Address</label>
                                    <input type="email" class="form-control" placeholder="eg. michael@creative-tim.com">
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="input-group input-group-static mb-3">
                                    <label>Phone Number</label>
                                    <select class="input-group-text" id="inputGroupSelect01">
                                        <option selected>RU</option>
                                        <option value="1">EN</option>
                                        <option value="2">US</option>
                                        <option value="3">AR</option>
                                    </select>
                                    <input type="number" class="form-control ps-3" aria-label="Phone Number" placeholder="+(1111) 32322 11">
                                </div>
                            </div>
                            <div class="input-group input-group-static mb-4">
                                <label>Your message</label>
                                <textarea name="message" class="form-control" placeholder="Type here" id="message" rows="6"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-check form-switch d-flex align-items-center mb-4">
                                        <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" checked="">
                                        <label class="form-check-label mb-0 ms-3" for="flexSwitchCheckDefault">I agree to the <a href="javascript:;" class="text-dark"><u>Terms and Conditions</u></a>.</label>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <button type="submit" class="btn bg-gradient-info float-end">Send Message</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!--   Core JS Files   -->
<script src="/js/core/popper.min.js" type="text/javascript"></script>
<script src="/js/core/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/plugins/perfect-scrollbar.min.js"></script>
<!--  Plugin for TypedJS, full documentation here: https://github.com/inorganik/CountUp.js -->
<script src="/js/plugins/countup.min.js"></script>
<!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
<script src="/js/plugins/parallax.min.js"></script>
<!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
<!--  Google Maps Plugin    -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
<script src="/js/material-kit.min.js?v=3.0.0" type="text/javascript"></script>
<script>
    // get the element to animate
    var element = document.getElementById('count-stats');
    var elementHeight = element.clientHeight;

    // listen for scroll event and call animate function

    document.addEventListener('scroll', animate);

    // check if element is in view
    function inView() {
        // get window height
        var windowHeight = window.innerHeight;
        // get number of pixels that the document is scrolled
        var scrollY = window.scrollY || window.pageYOffset;
        // get current scroll position (distance from the top of the page to the bottom of the current viewport)
        var scrollPosition = scrollY + windowHeight;
        // get element position (distance from the top of the page to the bottom of the element)
        var elementPosition = element.getBoundingClientRect().top + scrollY + elementHeight;

        // is scroll position greater than element position? (is element in view?)
        if (scrollPosition > elementPosition) {
            return true;
        }

        return false;
    }

    var animateComplete = true;

    // animate element when it is in view
    function animate() {

        // is element in view?
        if (inView()) {
            if (animateComplete) {
                if (document.getElementById('state1')) {
                    const countUp = new CountUp('state1', document.getElementById("state1").getAttribute("countTo"));
                    if (!countUp.error) {
                        countUp.start();
                    } else {
                        console.error(countUp.error);
                    }
                }
                if (document.getElementById('state2')) {
                    const countUp1 = new CountUp('state2', document.getElementById("state2").getAttribute("countTo"));
                    if (!countUp1.error) {
                        countUp1.start();
                    } else {
                        console.error(countUp1.error);
                    }
                }
                if (document.getElementById('state3')) {
                    const countUp2 = new CountUp('state3', document.getElementById("state3").getAttribute("countTo"));
                    if (!countUp2.error) {
                        countUp2.start();
                    } else {
                        console.error(countUp2.error);
                    }
                    ;
                }
                animateComplete = false;
            }
        }
    }

    if (document.getElementById('typed')) {
        var typed = new Typed("#typed", {
            stringsElement: '#typed-strings',
            typeSpeed: 90,
            backSpeed: 90,
            backDelay: 200,
            startDelay: 500,
            loop: true
        });
    }
</script>
<script>
    if (document.getElementsByClassName('page-header')) {
        window.onscroll = debounce(function () {
            var scrollPosition = window.pageYOffset;
            var bgParallax = document.querySelector('.page-header');
            var oVal = (window.scrollY / 3);
            bgParallax.style.transform = 'translate3d(0,' + oVal + 'px,0)';
        }, 6);
    }
</script>
</body>
</html>