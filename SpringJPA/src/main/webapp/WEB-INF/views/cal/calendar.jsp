<%@ page import="khy.springjpa.util.CmmUtil" %>
<%@ page import="khy.springjpa.dto.EventDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    List<EventDTO> eList = (List<EventDTO>) request.getAttribute("eList");

    if (eList == null) {
        eList = new ArrayList<>();
    }

    String userId = (String) session.getAttribute("SS_USER_ID");
%>
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8' />

    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet'/>
    <script src='/js/fullcal/main.js'></script>
    <script src='/js/fullcal/locales-all.js'></script>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <script type='text/javascript'>

        document.addEventListener('DOMContentLoaded', function () {
            let calendarEl = document.getElementById('calendar');
            let calendar = new FullCalendar.Calendar(calendarEl, {
                locale: 'ko',
                headerToolbar: {
                    left: 'title',
                    center: '',
                    right: 'prev,next,today'
                },
                height: 'auto',
                selectable: true,
                weekends: true,
                events: [
                    <%
                           for(EventDTO eDTO : eList) {
                               String id = eDTO.getEventId();
                               String title = eDTO.getEventTitle();
                               String start = eDTO.getEventStart();
                               String end = eDTO.getEventEnd();
                               %>
                    {
                        id: '<%=id%>',
                        title: '<%=title%>',
                        start: '<%=start%>',
                        end: '<%=end%>'
                    },

                    <%
                           }
                       %>
                ],
                select: function (info) {
                    //시작일 설정

                    let title = prompt("일정 제목 입력");
                    let start = info.start;
                    let end = info.end;

                    console.log(title);
                    console.log(start);
                    console.log(end);


                    $.ajax({
                        url: "/cal/insertEvent",
                        type: 'get',
                        data: {
                            "title": title,
                            "start": moment(start).format('YYYY-MM-DD'),
                            "end": moment(start).format('YYYY-MM-DD')
                        },
                        contentType: "application/json; charset=utf-8",
                        dataType: "text",
                        success: function (data) {
                            location.href = '/cal/calendar';
                        },
                        error: function (error) {
                            console.log(error);
                        }

                    });
                }
            });

            calendar.render();

        })

    </script>
    <style>
        #calendar{
            width:60%;
            margin:20px auto;
        }
    </style>
</head>
<body>
<div>
    <a href="/">메인페이지</a>
</div>
<div id='calendar'></div>
</body>
</html>