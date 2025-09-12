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
        아이디 찾기
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
    <script src="/js/jquery-3.6.0.min.js"></script>

    <script type="text/javascript">
        function findUserId(){
            $.ajax({
                type: "POST",
                url: "/findUserId/sendKey",
                data: $("#user_email"),
                success(data) {
                    if (data.result === "1") {
                        $("#email_text").text("입력하신 이메일로 인증번호를 발송했습니다");
                        $("#email_text").css('color', 'blue');
                        $("#btn_reg").attr("type", "submit");
                    } else {
                        $("#email_text").text("이메일 발송해 실패하였습니다 다시 확인해 주세요");
                        $("#email_text").css('color', 'red');
                        $("#btn_reg").attr("type", "button");
                    }

                    $("#auth_email").on("propertychange change keyup paste input", function () {
                        if (data.auth_code === $("#auth_email").val()) {
                            $("#auth_res").text("인증번호가 일치 합니다");
                            $("#auth_res").css('color', 'blue');
                            $("#btn_reg").attr("type","submit");
                        } else {
                            $("#auth_res").text("인증번호를 다시 확인해 주세요");
                            $("#auth_res").css('color', 'red');
                            $("#btn_reg").attr("type","button");

                        }
                    });
                }
            });
        }
    </script>
</head>

<body class="contact-us">
<section>
    <div class="page-header min-vh-100">
        <div class="container">
            <div class="row">
                <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 start-0 text-center justify-content-center flex-column">
                    <div class="position-relative h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center" style="background-image: url('/img/illustrations/illustration-signin.jpg'); background-size: cover;" loading="lazy"></div>
                </div>
                <div class="col-xl-5 col-lg-6 col-md-7 d-flex flex-column ms-auto me-auto ms-lg-auto me-lg-5">
                    <div class="card d-flex blur justify-content-center shadow-lg my-sm-0 my-sm-6 mt-8 mb-5">
                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
                            <div class="bg-gradient-primary shadow-primary border-radius-lg p-3">
                                <h3 class="text-white text-primary mb-0">아이디 찾기</h3>
                            </div>
                        </div>
                        <div class="card-body">
                            <form id="contact-form" action="/showUserId" method="post">
                                <div class="card-body p-0 my-3">
                                    <div class="row">
                                        <div class="col-md-6 ps-md-2">
                                            <div class="input-group input-group-static mb-4">
                                                <label>이메일</label>
                                                <input type="email" id="user_email" name="user_email"
                                                       class="form-control" placeholder="hello@creative-tim.com">
                                            </div>
                                        </div>
                                        <div class="col-md-6 ps-md-2">
                                            <div class="input-group input-group-static mb-4">
                                                <button type="button" onclick="findUserId();" class="btn bg-gradient-primary mt-3 mb-0">인증번호 전송
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="email_text"></div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="input-group input-group-static mb-4">
                                                <label>인증번호</label>
                                                <input type="text" id="auth_email" name="auth_email" class="form-control" >
                                                <div id="auth_res"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 text-center">
                                            <button type="submit" id="btn_reg" class="btn bg-gradient-primary mt-3 mb-0">전송</button>
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