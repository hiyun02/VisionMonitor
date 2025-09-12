<%@ page import="khy.springjpa.dto.MonitorDTO" %>
<%@ page import="khy.springjpa.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%

    MonitorDTO rDTO = (MonitorDTO) session.getAttribute("SS_MONITORDTO");

    if (rDTO == null) {
        rDTO = new MonitorDTO();
    }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--대문페이지이다 . 마이페이 지, 공부시작, 공부기록 세가지를 선택하여 들어갈 수 있으며 로그인/로그아웃 기능이 있음-->
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
                    <form id="contact-form" name="form" method="post" autocomplete="off" >
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="input-group input-group-static mb-4">
                                        <label>근거리 기준값</label>
                                        <input class="form-control" name="distance_check" value="<%=CmmUtil.nvl(rDTO.getDistanceCheck())%>" aria-label="First Name..." type="text">
                                        <a href="http://localhost:5000/distance">웹캠으로 측정하기</a>
                                    </div>
                                </div>
                                <div class="col-md-6 ps-2">
                                    <div class="input-group input-group-static">
                                        <label>근거리탐지 기준시간</label>
                                        <input type="text" class="form-control"  name="nearCheckTime" value="<%=CmmUtil.nvl(rDTO.getNearCheckTime())%>" aria-label="Last Name...">

                                    </div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="input-group input-group-static">
                                    <label>졸음탐지 기준값</label>
                                    <input type="text" class="form-control" name="blink_check" value="<%=CmmUtil.nvl(rDTO.getBlinkCheck())%>">
                                    <a href="http://localhost:5000/blink">웹캠으로 측정하기</a>
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="input-group input-group-static">
                                    <label>졸음탐지 기준시간</label>
                                    <input type="text" class="form-control" name="sleepCheckTime" value="<%=CmmUtil.nvl(rDTO.getSleepCheckTime())%>">
                                </div>
                            </div>
                            <div class="mb-4">
                                <div class="input-group input-group-static mb-3">
                                    <label>휴식시간</label>
                                    <input type="text" class="form-control" name="restTime" value="<%=CmmUtil.nvl(rDTO.getRestTime())%>">
                                </div>
                            </div>
                            <div class="input-group input-group-static mb-4">
                                <label>휴식시간 주기</label>
                                <input type="text" class="form-control" name="restTerm" value="<%=CmmUtil.nvl(rDTO.getRestTerm())%>">
                            </div>
                            <div class="input-group input-group-static mb-4">
                                <label>졸음방지 메시지</label>
                                <input type="text" class="form-control" name="mSleep" value="<%=CmmUtil.nvl(rDTO.getMSleep())%>">
                            </div>
                            <div class="input-group input-group-static mb-4">
                                <label>근거리방지 메시지</label>
                                <input type="text" class="form-control" name="mNear" value="<%=CmmUtil.nvl(rDTO.getMNear())%>">
                            </div>
                            <div class="input-group input-group-static mb-4">
                                <label>휴식시간 시작 메시지</label>
                                <input type="text" class="form-control" name="mRestStart" value="<%=CmmUtil.nvl(rDTO.getMRestStart())%>">
                            </div>
                            <div class="input-group input-group-static mb-4">
                                <label>휴식시간 종료 메시지</label>
                                <input type="text" class="form-control" name="mRestEnd" value="<%=CmmUtil.nvl(rDTO.getMRestEnd())%>">
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-check form-switch d-flex align-items-center mb-4">

                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <input type="submit" value="수정하기" onclick="javascript: form.action='/totalUpdate';" class="btn bg-gradient-info float-end"/>
                                </div>
                                <div class="col-md-12">
                                    <input type="submit" value="시작하기" onclick="javascript: form.action='http://localhost:5000';" class="btn bg-gradient-info float-end"/>
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

</body>
</html>