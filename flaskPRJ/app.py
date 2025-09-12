from flask import Flask, redirect, render_template, request, Response
import datetime
import webCam
import timeUtil

app = Flask(__name__)


@app.route('/', methods=['GET'])
def index():
    print("=====================index=====================")
    # GET 방식으로 전송된 모니터링 설정 데이터(쿼리스트링으로 넘겨받음)
    param = request.args

    return render_template(
        'index.html',
        distance_check=param.get("distance_check"),
        blink_check=param.get("blink_check"),
        sleepCheckTime=param.get("sleepCheckTime"),
        nearCheckTime=param.get("nearCheckTime"),
        restTerm=param.get("restTerm"),
        restTime=param.get("restTime"),
        mNear=param.get("mNear"),
        mSleep=param.get("mSleep"),
        mRestStart=param.get("mRestStart"),
        mRestEnd=param.get("mRestEnd")
    )


@app.route('/video_feed/<distance_check>/<blink_check>/<sleepCheckTime>/<nearCheckTime>/<restTerm>/<restTime>/<mSleep>/'
           '<mRestStart>/<mRestEnd>/<mNear>', methods=['GET'])
def video_feed(distance_check, blink_check, sleepCheckTime, nearCheckTime, restTerm,
               restTime, mSleep, mRestStart, mRestEnd, mNear):
    print("====================video_feed=====================")

    return Response(webCam.gen_frames(distance_check, blink_check, sleepCheckTime, nearCheckTime,
                                      restTerm, restTime, mNear, mSleep, mRestStart, mRestEnd),
                    mimetype='multipart/x-mixed-replace; boundary=frame')


@app.route('/faceFalse')
def faceFalse():
    print("====================faceFalse=====================")
    return "frame can't be read"


## 스트리밍 중지 및 결과 전달하는 함수
@app.route("/result")
def getResult():
    print("=====================getResult=======================")

    # 졸거나 자세가 흐트러진 시간(float)
    nearTime = webCam.nearTime
    blinkTime = webCam.blinkTime
    startTime = webCam.startTime
    startCam = webCam.startCam
    endCam = webCam.endCam
    faceTime = webCam.faceTime
    distractTime = nearTime + blinkTime

    # 웹캠시작시간
    start_time = str(startTime).split(".")[0]
    # 웹캠종료시간
    end_time = str(startTime + datetime.timedelta(seconds=(endCam - startCam))).split(".")[0]
    # 웹캠 작동 시간
    streaming_time = timeUtil.count_time(startCam, endCam)
    # 실제 집중 시간
    attention_time = timeUtil.count_time(distractTime, faceTime)
    # 졸거나 자세가 흐트러진 시간
    distract_time = timeUtil.floatTime(distractTime)
    # 자세가 흐트러진(화면과 너무 가까운) 시간
    near_time = timeUtil.floatTime(nearTime)
    # 졸았던 시간
    blink_time = timeUtil.floatTime(blinkTime)
    # 얼굴 인식 시간
    face_time = timeUtil.floatTime(faceTime)

    resultString = "http://localhost:11000/getPythonResult?" \
                   "start_time=" + start_time + "&end_time=" + end_time + "&streaming_time=" + streaming_time + \
                   "&face_time=" + face_time + "&near_time=" + near_time + "&blink_time=" + blink_time + \
                   "&distract_time=" + distract_time + "&attention_time=" + attention_time

    return redirect(resultString)


@app.route("/blink")
def setBlink():
    print("================setBlink===============")
    return render_template("blink.html")

@app.route('/video_blink')
def video_blink():
    print("====================video_blink=====================")

    return Response(webCam.blink_frames(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')


@app.route("/blinkResult")
def getResultBlink():
    print("===============getResultBlink==============")
    blinkValue = str(round(webCam.blinkValue, 2))
    url = "http://localhost:11000/blinkUpdate?blinkValue=" + blinkValue
    return redirect(url)


@app.route("/distance")
def setDistance():
    print("================setDistance===============")
    return render_template("distance.html")


@app.route('/video_distance')
def video_distance():
    print("====================video_distance===================")

    return Response(webCam.distance_frames(),
                    mimetype='multipart/x-mixed-replace; boundary=frame')


@app.route("/distanceResult")
def getResultDistance():
    print("===============getResultDistance==============")
    distanceValue = str(webCam.distanceValue)
    url = "http://localhost:11000/distanceUpdate?distanceValue=" + distanceValue
    return redirect(url)



@app.route("/maintest")
def maintest():
    print("================main===============")
    return render_template("main.html")


@app.route("/resultPage")
def result():
    print("================resultPage===============")
    return render_template("result.html")

@app.route("/test")
def test():
    print("================test===============")
    return render_template("test.html")
#
# @app.route("/ocrProcess")
# def odrProcess() :
#     print("==================ocrProcess=====================")
#
#     ocr.doVisionOCR("images/ICCUOCR01.jpg", "D:/ICCU/final/SpringJPA/src/main/resources/static/img/ocr/OcrText001.txt")
#
#     url="http://localhost:11000/ocr/textReadProc"
#     return redirect(url)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port='5000')
