<%@ page import="khy.springjpa.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%
    String sessionId = CmmUtil.nvl((String)session.getAttribute("SS_USER_ID"));
    String userName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NM")) + "님";
    boolean loginVal = sessionId.length() == 0;
    String loginCheck = (loginVal) ? "로그인" : "로그아웃";
    String btnUrl = (loginVal) ? "/user/userLoginForm" : "/user/userLogout";

    String kakaoToken = CmmUtil.nvl((String) session.getAttribute("SS_KAKAO_TOKEN"));
    boolean kakaoYn = kakaoToken.length() != 0; //카카오 꼐정 로그인 o
    String kakaoEvent = "kakaoEvent();";

    if (kakaoYn) { //카카오 로그인된 사용자이므로 url에 카카오 로그아웃 url 문자열을 대입
        loginCheck = "카카오계정 로그아웃";
        btnUrl = "https://kauth.kakao.com/oauth/logout?client_id=e9425a2c549f929d79525d17731f99ed&logout_redirect_uri=http://localhost:11000/kakao/Logout";
        userName="";

    }
%>

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

    <script>
        function kakaoEvent(){
            alert('서비스 이용을 위해서는 ICCU 회원가입이 필요합니다');
            alert('로그인된 카카오 계정 정보를 바탕으로 ICCU 회원가입을 진행합니다')
            location.href = "/kakao/userInsertForm";
        }
    </script>
</head>

<body class="about-us bg-gray-200">
<!-- Navbar Transparent -->
<nav class="navbar navbar-expand-lg position-absolute top-0 z-index-3 w-100 shadow-none my-3  navbar-transparent ">
    <div class="container">
        <a class="navbar-brand  text-white " href="/" title="Designed and Coded by Creative Tim"
           data-placement="bottom">
            메인페이지
        </a>
        <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse"
                data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false"
                aria-label="Toggle navigation">
        <span class="navbar-toggler-icon mt-2">
          <span class="navbar-toggler-bar bar1"></span>
          <span class="navbar-toggler-bar bar2"></span>
          <span class="navbar-toggler-bar bar3"></span>
        </span>
        </button>
        <div class="collapse navbar-collapse w-100 pt-3 pb-2 py-lg-0 ms-lg-12 ps-lg-5" id="navigation">
            <ul class="navbar-nav navbar-nav-hover ms-auto">
                <li class="nav-item dropdown dropdown-hover mx-2 ms-lg-6">
                    <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center"
                       id="dropdownMenuPages8" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons opacity-6 me-2 text-md">dashboard</i>
                        mypage
                        <img src="/img/down-arrow-white.svg" alt="down-arrow" class="arrow ms-2 d-lg-block d-none">
                        <img src="/img/down-arrow-dark.svg" alt="down-arrow" class="arrow ms-2 d-lg-none d-block">
                    </a>
                    <div class="dropdown-menu dropdown-menu-animation ms-n3 dropdown-md p-3 border-radius-lg mt-0 mt-lg-3"
                         aria-labelledby="dropdownMenuPages8">
                        <div class="d-none d-lg-block" onclick=<%=kakaoYn ? kakaoEvent : "location.href='/user/mypage'"%>>
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                회원정보
                            </h6>
                        </div>
                        <div class="d-none d-lg-block" onclick=<%=kakaoYn ? kakaoEvent : "location.href='/user/userDelete'"%>>
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                회원탈퇴
                            </h6>
                        </div>
                        <div class="d-none d-lg-block">
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1" onclick=<%=kakaoYn ? kakaoEvent : "location.href='/getRecordList'"%>>
                                사용자 기록 정보
                            </h6>
                        </div>
                    </div>
                </li>
                <li class="nav-item dropdown dropdown-hover mx-2">
                    <a class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center"
                       id="dropdownMenuBlocks" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="material-icons opacity-6 me-2 text-md">view_day</i>
                        Study
                        <img src="/img/down-arrow-white.svg" alt="down-arrow" class="arrow ms-2 d-lg-block d-none">
                        <img src="/img/down-arrow-dark.svg" alt="down-arrow" class="arrow ms-2 d-lg-none d-block">
                    </a>
                    <div class="dropdown-menu dropdown-menu-animation ms-n3 dropdown-md p-3 border-radius-lg mt-0 mt-lg-3"
                         aria-labelledby="dropdownMenuPages8">
                        <div class="d-none d-lg-block" onclick=<%=kakaoYn ? kakaoEvent : "location.href='/getMonitorInfo'"%>>
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                모니터링 설정
                            </h6>
                        </div>
                        <div class="d-none d-lg-block" onclick=<%=kakaoYn ? kakaoEvent : "location.href='/cal/calendar'"%>>
                            <h6 class="dropdown-header text-dark font-weight-bolder d-flex align-items-center px-1">
                                내 일정
                            </h6>
                        </div>

                    </div>
                </li>

                <li class="nav-item my-auto ms-3 ms-lg-0">
                    <a href="<%=btnUrl%>" class="btn btn-sm  bg-white  mb-0 me-1 mt-2 mt-md-0"><%=loginCheck%></a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- End Navbar -->
<!-- -------- START HEADER 7 w/ text and video ------- -->
<header class="bg-gradient-dark">
    <div class="page-header min-vh-75" style="background-image: url('/img/bg2.jpg');">
        <span class="mask bg-gradient-dark opacity-6"></span>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center mx-auto my-auto">
                    <h1 class="text-white">안녕하세요! <%=userName%></h1>
                    <p class="lead mb-4 text-white opacity-8">ICCU와 함께 공부를 시작하세요!</p>
                </div>
            </div>
        </div>
    </div>
</header>

<footer class="footer pt-5 mt-5">

</footer>
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