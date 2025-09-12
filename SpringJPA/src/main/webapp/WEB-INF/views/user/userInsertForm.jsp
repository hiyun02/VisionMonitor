<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="apple-touch-icon" sizes="76x76" href="/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/img/favicon.png">
    <title>
        회원가입
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
    <script src="/js/jquery-3.6.0.min.js"></script>

    <script type="text/javascript">
        function userInsertCheck(f) {
            if (f.user_id.value == "") {
                alert("아이디를 입력하세요");
                f.user_id.focus();
                return false;
            }
            if (f.user_nm.value == "") {
                alert("아이디를 입력하세요");
                f.user_nm.focus();
                return false;
            }
            if (f.user_pw.value == "") {
                alert("비밀번호를 입력하세요");
                f.user_pw.focus();
                return false;
            }
            if (f.user_pw2.value == "") {
                alert("비밀번호 확인을 입력하세요");
                f.user_pw2.focus();
                return false;
            }
            if (f.user_email.value == "") {
                alert("이메일을 입력하세요");
                f.user_email.focus();
                return false;
            }
        }

        function IdCheck() {
            $.ajax({
                type: "POST",
                url: "/user/getIdExist",
                data: $("#user_id"),
                success(data) {
                    console.log(data);
                    if (data.Exist_yn==="y") {
                        $("#id_result").text("중복된 아이디가 있습니다.");
                        $("#id_result").css('color', 'red');
                        $("#btn_reg").attr("type", "button");
                    } else {
                        $("#id_result").text('사용가능한 아이디 입니다.');
                        $("#id_result").css('color', 'blue');
                        $("#btn_reg").attr("type", "submit");
                    }
                }
            })
        }

        function emailCheck(){
            $.ajax({
                type: "POST",
                url: "/user/getEmailExist",
                data: $("#user_email"),
                success(data) {
                    if (data.Exist_yn === "y") {
                        $("#email_result").text("중복된 이메일이 있습니다.");
                        $("#email_result").css('color', 'red');
                        $("#btn_reg").attr("type", "button");
                    } else {
                        $("#email_result").text('사용가능한 이메일 입니다.');
                        $("#email_result").css('color', 'blue');
                        $("#btn_reg").attr("type", "submit");
                    }
                }
            })
        }

    </script>
</head>

<body class="contact-us">
<section>
    <div class="page-header min-vh-100">
        <div class="container">
            <div class="row">
                <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 start-0 text-center justify-content-center flex-column">
                    <div class="position-relative h-100 m-3 px-7 border-radius-lg d-flex flex-column justify-content-center"
                         style="background-image: url('/img/illustrations/illustration-signin.jpg'); background-size: cover;"
                         loading="lazy"></div>
                </div>
                <div class="col-xl-5 col-lg-6 col-md-7 d-flex flex-column ms-auto me-auto ms-lg-auto me-lg-5">
                    <div class="card d-flex blur justify-content-center shadow-lg my-sm-0 my-sm-6 mt-8 mb-5">
                        <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
                            <div class="bg-gradient-primary shadow-primary border-radius-lg p-3">
                                <h3 class="text-white text-primary mb-0">회원가입</h3>
                            </div>
                        </div>
                        <form action="/user/userInsert" method="post" onsubmit="return userInsertCheck(this)">
                            <div class="card-body">
                                <div class="card-body p-0 my-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group input-group-static mb-4">
                                                <label>아이디</label>
                                                <input type="text" id="user_id" name="user_id" class="form-control"
                                                       placeholder="ID">
                                                <div id="id_result"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 ps-md-2">
                                            <div class="input-group input-group-static mb-4">
                                                <button type="button" class="btn bg-gradient-primary mt-3 mb-0"
                                                        onclick="IdCheck();">중복확인
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 ps-md-2">
                                            <div class="input-group input-group-static mb-4">
                                                <label>이름</label>
                                                <input type="text" id="user_nm" name="user_nm" class="form-control"
                                                       placeholder="이름">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="input-group input-group-static mb-4">
                                            <label>비밀번호</label>
                                            <input type="password" id="user_pw" name="user_pw" class="form-control"
                                                   placeholder="비밀번호">
                                        </div>
                                    </div>
                                    <div class="col-md-6 ps-md-2">
                                        <div class="input-group input-group-static mb-4">
                                            <label>비밀번호 확인</label>
                                            <input type="password" id="user_pw2" name="user_pw2"
                                                   class="form-control" placeholder="비밀번호 확인">
                                        </div>
                                    </div>
                                </div>
                                <div id = "pwd_res"></div>

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
                                            <button type="button" onclick="emailCheck();" class="btn bg-gradient-primary mt-3 mb-0">중복확인
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div id="email_result"></div>
                                <div class="row">
                                    <div class="col-md-12 text-center">
                                        <button type="submit" id="btn_reg" class="btn bg-gradient-primary mt-3 mb-0">
                                            시작하기
                                        </button>
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
<script type="text/javascript">
    //비밀번호 확인 로직
    $("#user_pw2").on("propertychange change keyup paste input", function () {
        if ($("#user_pw").val() == $("#user_pw2").val()) {
            $("#pwd_res").text("비밀번호와 일치합니다!");
            $("#pwd_res").css('color', 'blue');
            $("#btn_reg").attr("type", "submit");
        } else {
            $("#pwd_res").text("비밀번호와 일치하지 않습니다");
            $("#pwd_res").css('color', 'red');
            $("#btn_reg").attr("type", "button");
        }
    });
</script>
</body>
</html>