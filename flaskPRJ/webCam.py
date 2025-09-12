import cv2
import numpy as np
import dlib
from math import hypot
import datetime
import time
from math import trunc
import os, sys, inspect
print("[RUN] __file__      =", __file__)
print("[RUN] CWD           =", os.getcwd())
print("[RUN] sys.executable=", sys.executable)
print("[RUN] sys.path[0:3] =", sys.path[:3])
print("[RUN] webCam loaded at", os.path.getmtime(__file__))
# 상단부 import에 추가 ★
from PIL import ImageFont
# ... 생략 ...

def gen_frames(distance_check, blink_check, sleepCheckTime, nearCheckTime, restTerm, restTime, mNear, mSleep,
               mRestStart, mRestEnd):
    print("====================gen_frames=====================")

    # 스트리밍에 필요한 객체 선언
    camera = cv2.VideoCapture(0, cv2.CAP_DSHOW)
    camera.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

    font = cv2.FONT_HERSHEY_PLAIN

    # 안면 검출하는 객체 로드
    detector = dlib.get_frontal_face_detector()
    # 안면상의 좌표를 탐지하기 위한 파일의 경로를 통해 객체 로드
    predictor = dlib.shape_predictor(
        "C:\\Workspace\\ICCU\\ICCU\\final\\python\\flaskPRJ\\shape_predictor_68_face_landmarks.dat")

    # haar cascade 검출기 객체 선언
    eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')

    time.sleep(0.2)

    # 스트리밍에 필요한 변수 바운드

    # 파라미터로 전달 받아서 바운드 돼야 할 변수 값들. 수정 필요

    distance_check = int(distance_check)  # 지정된 안구넓이
    blink_check = float(blink_check)  # 지정된 사용자 blink값
    sleepCheckTime = int(sleepCheckTime)  # input의 10배
    nearCheckTime = int(nearCheckTime)  # input의 10배
    restTerm = float(restTerm)  # 지정된 휴식주기 3
    restTime = float(restTime)  # 지정된 휴식시간
    mSleep = str(mSleep)  # 지정된 졸음알림 메시지
    mNear = str(mNear)  # 지정된 거리유지 메시지
    mRestStart = str(mRestStart)  # 지정된 쉬는시간시작 메시지
    mRestEnd = str(mRestEnd)  # 지정된 쉬는시간끝 메시지

    print("distance_check : " + str(distance_check) + " , blink_check : " + str(blink_check))

    # 쉬는 시간 기능에 사용될 변수들
    restYN = False
    restTimeCount = 0.0
    restTermCount = 0.0

    # 얼굴이 인식된 시간
    global faceTime
    faceTime = 0.0
    # 안구영역이 지정값보다 가까운 시간
    global nearTime
    nearTime = 0.0
    # 눈을 감고 있는 것으로 판정된 시간
    global blinkTime
    blinkTime = 0.0

    # 각 프레임의 시작의 시간값 저장 변수
    global endCam
    endCam = 0.0
    global startCam
    startCam = time.time()
    # 스트리밍 시작 전의 시간
    global startTime
    startTime = datetime.datetime.now()

    # 거리 판별에 사용할 현재 프레임 눈 면적을 저장할 변수
    last_eye_area = 0

    while True:
        endCam = time.time()

        if restYN:
            frame = np.zeros((512, 512, 3), np.uint8)
        else:
            ret, frame = camera.read()
            if not ret:
                print("에러로 인한 faceFalse 함수 호출")

            faces = detector(cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY))
            eyes = eye_cascade.detectMultiScale(frame, scaleFactor=1.5, minNeighbors=3, minSize=(10, 10))

            for face in faces:
                landmarks = predictor(frame, face)
                cv2.rectangle(frame, (landmarks.part(17).x, landmarks.part(17).y),
                              (landmarks.part(11).x, landmarks.part(11).y), (255, 255, 255), 1, cv2.LINE_4)

                if len(eyes):
                    for x, y, w, h in eyes:
                        # 현재 프레임의 눈 면적 저장
                        last_eye_area = int(w * h)

                        if last_eye_area > distance_check:
                            cv2.putText(frame, "too close", (50, 150), font, 7, (255, 255, 255))
                            nearTime += (time.time() - endCam)

                            if trunc(nearTime * 10) % nearCheckTime == 0:
                                 cv2.putText(frame, mNear, (50, 150), font, 7, (255, 0, 0), 5)

                        if getBlinking_ratio(landmarks) > blink_check:
                            blinkTime += (time.time() - endCam)
                            cv2.putText(frame, "sleepy?", (50, 150), font, 7, (0, 0, 0))

                            if trunc(blinkTime * 10) % sleepCheckTime == 0:
                                 cv2.putText(frame, mSleep, (50, 150), font, 7, (255, 0, 0))

                faceTime += (time.time() - endCam)

        # ===== 휴식 타이머 갱신 =====
        if restYN:  # 쉬는시간
            time.sleep(0.3)
            restTimeCount += (time.time() - endCam)
            # 기존 텍스트 유지 가능
            if trunc(restTimeCount) == restTime:
                cv2.putText(frame, mRestEnd, (12, 40), font, 2, (255, 255, 255))
                restTimeCount = 0.0
                restYN = False
        else:  # 공부시간
            restTermCount += (time.time() - endCam)
            if trunc(restTermCount) == restTerm:
                cv2.putText(frame, mRestStart, (12, 40), font, 2, (255, 255, 255))
                restTermCount = 0.0
                restYN = True

            # 휴식 남은 시간
            if restYN:
                remain_sec = max(0, int(restTime - int(restTimeCount)))
                m, s = divmod(remain_sec, 60)
                remain_str = f"Rest Left: {m:02d}:{s:02d}"
            else:
                remain_sec = max(0, int(restTerm - int(restTermCount)))
                m, s = divmod(remain_sec, 60)
                remain_str = f"To Rest: {m:02d}:{s:02d}"

            cv2.putText(frame,
                        remain_str,
                        (20, 130),  # 더 아래로
                        cv2.FONT_HERSHEY_DUPLEX,
                        0.8, (0, 0, 0), 1, cv2.LINE_AA)

            # 현재 모니터 거리 (ROI 면적 값)
            cv2.putText(frame,
                        f"Distance : {last_eye_area}",
                        (20, 160),  # 더 아래로
                        cv2.FONT_HERSHEY_DUPLEX,
                        0.8, (0, 0, 0), 1, cv2.LINE_AA)

            # 총 모니터링 시간
            total_delta = datetime.datetime.now() - startTime
            cv2.putText(frame,
                        f"Total: {str(total_delta).split('.')[0]}",
                        (20, 100),  # 내려줌
                        cv2.FONT_HERSHEY_DUPLEX,
                        0.8, (0, 0, 0), 1, cv2.LINE_AA)  # 작은 크기, 얇은 두께

        # ===== 스트리밍 인코딩 =====
        _, buffer = cv2.imencode('.jpg', frame)
        frame1 = buffer.tobytes()
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame1 + b'\r\n')

def blink_frames():
    print("====================blink_frames=====================")

    # 스트리밍에 필요한 객체 선언
    camera = cv2.VideoCapture(0, cv2.CAP_DSHOW)
    camera.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

    font = cv2.FONT_HERSHEY_PLAIN

    # 안면 검출하는 객체 로드
    detector = dlib.get_frontal_face_detector()
    # 안면상의 좌표를 탐지하기 위한 파일의 경로를 통해 객체 로드


    predictor = dlib.shape_predictor("C:\\Workspace\\ICCU\\ICCU\\final\\python\\flaskPRJ\\shape_predictor_68_face_landmarks.dat")


    time.sleep(0.2)

    global blinkValue
    blinkValue = 0.0

    while True:

        ret, frame = camera.read()

        if ret == False:
            print("에러로 인한 faceFalse 함수 호출")
            frame = np.zeros((512, 512, 3), np.uint8)
            cv2.putText(frame, "Please Try Again", (12, 40), font, 2, (255, 255, 255))
        else:
            faces = detector(cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY))
            # faces의 크기는 검출된 얼굴(좌표list)의 개수 --> RuntimeError 대처 필요!!!!!!!!!!!!!!!!

            # 얼굴이 인식될 때 거리와 졸음 모니터링
            for face in faces:
                landmarks = predictor(frame, face)

                # 얼굴 영역을 사각형으로 표시 -> 얼굴인식 여부를 사용자가 확인할 수 있게 함
                cv2.rectangle(frame, (landmarks.part(17).x, landmarks.part(17).y),
                              (landmarks.part(11).x, landmarks.part(11).y), (255, 255, 255), 1, cv2.LINE_4)

                cv2.putText(frame, "Close Your Eyes And Click Under Button", (12, 40), font, 2, (255, 255, 255))

                # 수평선/수직선 비율의 값으로 깜박임을 판단
                blinkValue = getBlinking_ratio(landmarks)

        # 읽어온 frame을 html로 보내는 로직. 버퍼에 담은 후 바이트코드 형태로 변환
        _, buffer = cv2.imencode('.jpg', frame)
        frame1 = buffer.tobytes()
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame1 + b'\r\n')


def distance_frames():
    print("====================distance_frames=====================")

    # 스트리밍에 필요한 객체 선언
    camera = cv2.VideoCapture(0, cv2.CAP_DSHOW)
    camera.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    camera.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

    font = cv2.FONT_HERSHEY_PLAIN

    # haar cascade 검출기 객체 선언
    eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')

    time.sleep(0.2)

    global distanceValue
    distanceValue = 0

    while True:

        ret, frame = camera.read()

        if ret == False:
            print("에러로 인한 faceFalse 함수 호출")
            frame = np.zeros((512, 512, 3), np.uint8)
            cv2.putText(frame, "Please Try Again", (12, 40), font, 2, (255, 255, 255))

        else:
            eyes = eye_cascade.detectMultiScale(frame, scaleFactor=1.5, minNeighbors=3, minSize=(10, 10))

            # 현재 frame에 탐지 가능한 안구 영역이 있다면 실행되는 로직
            if len(eyes):
                # 안구영역 넓이로 원근 판단
                for x, y, w, h in eyes:
                    #cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 255, 255), 2, cv2.LINE_4)
                    distanceValue = w * h

        # 읽어온 frame을 html로 보내는 로직. 버퍼에 담은 후 바이트코드 형태로 변환
        _, buffer = cv2.imencode('.jpg', frame)
        frame1 = buffer.tobytes()
        yield (b'--frame\r\n'
               b'Content-Type: image/jpeg\r\n\r\n' + frame1 + b'\r\n')


def get_blinking_ratio(eye_points, facial_landmarks):
    left_point = (facial_landmarks.part(eye_points[0]).x, facial_landmarks.part(eye_points[0]).y)
    right_point = (facial_landmarks.part(eye_points[3]).x, facial_landmarks.part(eye_points[3]).y)
    center_top = midpoint(facial_landmarks.part(eye_points[1]), facial_landmarks.part(eye_points[2]))
    center_bottom = midpoint(facial_landmarks.part(eye_points[5]), facial_landmarks.part(eye_points[4]))

    # x좌표끼리의 차와 y좌표끼리의 차를 매개변수로 넘겨 길이 계산
    hor_line_length = hypot((left_point[0] - right_point[0]), (left_point[1] - right_point[1]))
    ver_line_length = hypot((center_top[0] - center_bottom[0]), (center_top[1] - center_bottom[1]))

    ratio = hor_line_length / ver_line_length
    return ratio


# 졸음 판별을 위한 깜박임 감지
def getBlinking_ratio(landmarks):
    left_eye_ratio = get_blinking_ratio([36, 37, 38, 39, 40, 41], landmarks)
    right_eye_ratio = get_blinking_ratio([42, 43, 44, 45, 46, 47], landmarks)
    blinking_ratio = (left_eye_ratio + right_eye_ratio) / 2
    return blinking_ratio


# 입력은 time.time()의 리턴인 float이 됨
def count_time(time1, time2):
    sec = time2 - time1
    result_list = str(datetime.timedelta(seconds=sec)).split(".")

    return result_list[0]


def floatTime(float):
    result_list = str(datetime.timedelta(seconds=float)).split(".")
    return result_list[0]


def midpoint(p1, p2):
    # 픽셀 좌표는 정수만 취급(?)
    return int((p1.x + p2.x) / 2), int((p1.y + p2.y) / 2)
