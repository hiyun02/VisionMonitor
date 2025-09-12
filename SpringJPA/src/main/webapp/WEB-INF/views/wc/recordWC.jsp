<%@ page import="khy.springjpa.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String wcTextTotal = CmmUtil.nvl((String) request.getAttribute("wcTextTotal"));
    String msg = CmmUtil.nvl((String) request.getAttribute("msg"));
%>
<!DOCTYPE html>
<!-- saved from url=(0038)https://www.jasondavies.com/wordcloud/ -->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Word Cloud Generator</title>
    <script type="text/javascript">
        alert("<%=msg%>")
    </script>
    <style>
        body {
            position: relative;
            font-family: "Helvetica Neue", sans-serif;
            width: 960px;
            margin: auto;
            margin-bottom: 1em;
            margin-top: 20px;
        }

        #presets a {
            border-left: solid #666 1px;
            padding: 0 10px;
        }

        #presets a.first {
            border-left: none;
        }

        #keyword {
            width: 300px;
        }

        #fetcher {
            width: 500px;
        }

        #keyword, #go {
            font-size: 1.5em;
        }

        #text {
            width: 100%;
            height: 100px;
        }

        p.copy {
            font-size: small;
        }

        #form {
            font-size: small;
            position: relative;
        }

        hr {
            border: none;
            border-bottom: solid #ccc 1px;
        }

        a.active {
            text-decoration: none;
            color: #000;
            font-weight: bold;
            cursor: text;
        }

        #angles line, #angles path, #angles circle {
            stroke: #666;
        }

        #angles text {
            fill: #333;
        }

        #angles path.drag {
            fill: #666;
            cursor: move;
        }

        #angles {
            text-align: center;
            margin: 0 auto;
            width: 350px;
        }

        #angles input, #max {
            width: 42px;
        }
    </style>

    <meta http-equiv="origin-trial"
          content="A+cA2PUOfIOKAdSDJOW5CP9ZlxONy1yu+hqAq72zUtKw4rLdihqRp6Nui/jUyCyegr+BUtH+C+Elv0ufn05yBQEAAACFeyJvcmlnaW4iOiJodHRwczovL2RvdWJsZWNsaWNrLm5ldDo0NDMiLCJmZWF0dXJlIjoiUHJpdmFjeVNhbmRib3hBZHNBUElzIiwiZXhwaXJ5IjoxNjY5NzY2Mzk5LCJpc1N1YmRvbWFpbiI6dHJ1ZSwiaXNUaGlyZFBhcnR5Ijp0cnVlfQ==">
    <meta http-equiv="origin-trial"
          content="A+zsdH3aNZT/bkjT8U/o5ACzyaeNYzTvtoVmwf/KOilfv39pxY2AIsOwhQJv+YnXp98i3TqrQibIVtMWs5UHjgoAAACLeyJvcmlnaW4iOiJodHRwczovL2dvb2dsZXN5bmRpY2F0aW9uLmNvbTo0NDMiLCJmZWF0dXJlIjoiUHJpdmFjeVNhbmRib3hBZHNBUElzIiwiZXhwaXJ5IjoxNjY5NzY2Mzk5LCJpc1N1YmRvbWFpbiI6dHJ1ZSwiaXNUaGlyZFBhcnR5Ijp0cnVlfQ==">
    <meta http-equiv="origin-trial"
          content="AxceVEhIegcDEHqLXFQ2+vPKqzCppoJYsRCZ/BdfVnbM/sUUF2BXV8lwNosyYjvoxnTh2FC8cOlAnA5uULr/zAUAAACLeyJvcmlnaW4iOiJodHRwczovL2dvb2dsZXRhZ3NlcnZpY2VzLmNvbTo0NDMiLCJmZWF0dXJlIjoiUHJpdmFjeVNhbmRib3hBZHNBUElzIiwiZXhwaXJ5IjoxNjY5NzY2Mzk5LCJpc1N1YmRvbWFpbiI6dHJ1ZSwiaXNUaGlyZFBhcnR5Ijp0cnVlfQ==">
    <link rel="preload" href="/Word Cloud Generator_files/f(4).txt" as="script">
    <script type="text/javascript" src="/Word Cloud Generator_files/f(4).txt"></script>
    <link rel="preload" href="/Word Cloud Generator_files/f(5).txt" as="script">
    <script type="text/javascript" src="/Word Cloud Generator_files/f(5).txt"></script>
</head>
<body>
<div>
    <h2>10월의 핵심 키워드</h2>
</div>
<div id="vis"></div>
<div style="display:none">
    <form id="form">

        <p style="position: absolute; right: 0px; top: 0px; display: none;" id="status">201/202</p>

        <div style="text-align: center">
            <div id="presets"></div>
            <div id="custom-area">
                <p><label for="text">Paste your text below!</label>
                </p>
                <p><textarea id="text"><%=wcTextTotal%></textarea>
                    <button id="go" type="submit">Go!</button>
                </p>
            </div>
        </div>

        <hr>

        <div style="float: right; text-align: right">
            <p><label for="max">Number of words:</label> <input type="number" value="250" min="1" id="max">
            </p>
            <p><label for="per-line"><input type="checkbox" id="per-line"> One word per line</label>
                <!--<p><label for="colours">Colours:</label> <a href="#" id="random-palette">get random palette</a>-->
            </p>
            <p><label>Download:</label>
                <button id="download-svg">SVG</button><!-- |
    <a id="download-png" href="#">PNG</a>-->
            </p>
        </div>

        <div style="float: left">
            <p><label>Spiral:</label>
                <label for="archimedean"><input type="radio" name="spiral" id="archimedean" value="archimedean"
                                                checked="checked"> Archimedean</label>
                <label for="rectangular"><input type="radio" name="spiral" id="rectangular" value="rectangular">
                    Rectangular</label>
            </p>
            <p><label for="scale">Scale:</label>
                <label for="scale-log"><input type="radio" name="scale" id="scale-log" value="log" checked="checked">
                    log n</label>
                <label for="scale-sqrt"><input type="radio" name="scale" id="scale-sqrt" value="sqrt"> √n</label>
                <label for="scale-linear"><input type="radio" name="scale" id="scale-linear" value="linear"> n</label>
            </p>
            <p><label for="font">Font:</label> <input type="text" id="font" value="Impact">
            </p></div>

        <div id="angles">
            <p><input type="number" id="angle-count" value="5" min="1"> <label for="angle-count">orientations</label>
                <label for="angle-from">from</label> <input type="number" id="angle-from" value="-60" min="-90"
                                                            max="90"> °
                <label for="angle-to">to</label> <input type="number" id="angle-to" value="60" min="-90" max="90"> °
            </p>
            <svg width="151" height="70.5">
                <g transform="translate(75.5,60.5)">
                    <path d="M -40.5 0 A 40.5 40.5 0 0 1 40.5 0" style="fill: none;"></path>
                    <line x1="-47.5" x2="47.5"></line>
                    <line y2="-47.5"></line>
                    <text dy=".3em" text-anchor="end" transform="rotate(0)translate(-50.5)rotate(0)translate(2)">-90°
                    </text>
                    <text text-anchor="middle" transform="rotate(90)translate(-50.5)rotate(-90)translate(2)">0°</text>
                    <text dy=".3em" text-anchor="start" transform="rotate(180)translate(-50.5)rotate(-180)translate(2)">
                        90°
                    </text>
                    <path class="angle"
                          d="M-35.07402885326976,-20.250000000000014A40.5,40.5 0 0,1 35.074028853269766,-20.25L0,0Z"
                          style="fill: rgb(255, 204, 0);"></path>
                    <line class="angle" transform="rotate(30)" x2="-45.5"></line>
                    <line class="angle" transform="rotate(60)" x2="-40.5"></line>
                    <line class="angle" transform="rotate(90)" x2="-40.5"></line>
                    <line class="angle" transform="rotate(120)" x2="-40.5"></line>
                    <line class="angle" transform="rotate(150)" x2="-45.5"></line>
                    <path class="drag" d="M-9.5,0L-3,3.5L-3,-3.5Z" transform="rotate(30)translate(-40.5)"></path>
                    <path class="drag" d="M-9.5,0L-3,3.5L-3,-3.5Z" transform="rotate(150)translate(-40.5)"></path>
                </g>
            </svg>
        </div>

        <hr style="clear: both">

        <p style="float: right"><a href="https://www.jasondavies.com/wordcloud/about/">How the Word Cloud Generator
            Works</a>.
        </p>
        <p style="float: left">Copyright © <a href="http://www.jasondavies.com/">Jason Davies</a> | <a
                href="https://www.jasondavies.com/privacy/">Privacy Policy</a>. The generated word clouds may be used
            for any purpose.

        </p></form>

    <ins class="adsbygoogle" style="display:inline-block;width:728px;height:90px;margin-left:116px"
         data-ad-client="ca-pub-2911491153890039" data-ad-slot="2029654015" data-adsbygoogle-status="done"
         data-ad-status="filled">
        <div id="aswift_1_host" tabindex="0" title="Advertisement" aria-label="Advertisement"
             style="border: none; height: 90px; width: 728px; margin: 0px; padding: 0px; position: relative; visibility: visible; background-color: transparent; display: inline-block;">
            <iframe id="aswift_1" name="aswift_1"
                    style="left:0;position:absolute;top:0;border:0;width:728px;height:90px;"
                    sandbox="allow-forms allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts allow-top-navigation-by-user-activation"
                    width="728" height="90" frameborder="0" marginwidth="0" marginheight="0" vspace="0" hspace="0"
                    allowtransparency="true" scrolling="no" src="/Word Cloud Generator_files/ads.html"
                    data-google-container-id="a!2" data-google-query-id="CNS4gZrz2PoCFdeD6QUdFLoEsQ"
                    data-load-complete="true"></iframe>
        </div>

    </ins>

    <script src="/Word Cloud Generator_files/f(6).txt"></script>
    <script src="/Word Cloud Generator_files/f(7).txt" id="google_shimpl"></script>
    <script src="/Word Cloud Generator_files/d3.min.js.다운로드"></script>
    <script src="/Word Cloud Generator_files/cloud.min.js.다운로드"></script>
    <form action="https://www.jasondavies.com/echo" target="_blank" method="POST"><input type="hidden"
                                                                                         name="content-type"><input
            type="hidden" name="echo"></form>
    <script async="" src="/Word Cloud Generator_files/f(8).txt" crossorigin="anonymous"
            data-checked-head="true"></script>
    <script>
        (adsbygoogle = window.adsbygoogle || []).push({});
    </script>
    <ins class="adsbygoogle adsbygoogle-noablate" data-adsbygoogle-status="done" style="display: none !important;"
         data-ad-status="unfilled">
        <div id="aswift_0_host" tabindex="0" title="Advertisement" aria-label="Advertisement"
             style="border: none; height: 0px; width: 0px; margin: 0px; padding: 0px; position: relative; visibility: visible; background-color: transparent; display: inline-block;">

        </div>
    </ins>
    <iframe src="/Word Cloud Generator_files/aframe.html" width="0" height="0" style="display: none;"></iframe>
</div>
<div>
    <a href="/getRecordList">목록</a>
</div>
</body>
<iframe id="google_esf" name="google_esf" src="/Word Cloud Generator_files/zrt_lookup.html"
        style="display: none;"></iframe>
</html>