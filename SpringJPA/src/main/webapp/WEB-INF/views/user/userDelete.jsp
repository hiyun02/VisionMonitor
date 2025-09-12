<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/img/favicon.png">
    <title>
        회원탈퇴
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

    <script type="text/javascript">

        function doSubmit(f) {
            if(!(f.auth_text.value==="탈퇴하겠습니다")) {
                alert("올바른 텍스트를 입력해주세요");
                f.auth_text.focus();
                return false;
            }
        }

    </script>
</head>

<body class="sign-in-basic">

<div class="page-header align-items-start min-vh-100" style="background-image: url('https://images.unsplash.com/photo-1497294815431-9365093b7331?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80');" loading="lazy">
    <span class="mask bg-gradient-dark opacity-6"></span>
    <div class="container my-auto">
        <div class="row">
            <div class="col-lg-4 col-md-8 col-12 mx-auto">
                <div class="card z-index-0 fadeIn3 fadeInBottom">
                    <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                        <div class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
                            <h4 class="text-white font-weight-bolder text-center mt-2 mb-0">회원탈퇴</h4>
                        </div>
                    </div>
                    <div class="card-body">
                        <form role="form" action="/user/userDel" method="post" onsubmit="return doSubmit(this);">
                            <div class="input-group input-group-outline my-3">
                                <h5>정말 탈퇴하시겠습니까?</h5>
                                <br>
                                <h8>탈퇴 전 본인 확인을 위해 비밀번호를 입력하세요</h8>
                                <br><br>
                                <input type="password" name="userPw" class="form-control">
                            </div>

                            <div class="input-group input-group-outline my-3">
                                <h8>탈퇴 확인을 위해  "탈퇴하겠습니다" 를 입력하세요</h8>

                                <br><br>
                                <input type="text" name="auth_text" class="form-control" placeholder="탈퇴하겠습니다">
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn bg-gradient-primary w-100 my-4 mb-2">확인</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
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