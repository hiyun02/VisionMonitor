package khy.springjpa.dto;

import lombok.Data;

@Data
public class MonitorDTO {

    private String monitorSeq;
    private String userId; //모니터링값 사용자 아이디
    private String distanceCheck; //근거리 탐지 기준(안구영역넓이)
    private String blinkCheck; //졸음 탐지 기준(blink값)
    //모든 시간값은 초로 입력(타입은 String)
    private String sleepCheckTime; //졸음 탐지 시간
    private String nearCheckTime; //근거리 탐지
    private String restTerm; //휴식시간 주기
    private String restTime; //휴식시간
    private String mSleep; //졸음 방지 메시지
    private String mNear; //근거리 방지 메시지
    private String mRestStart; //휴식시간 시작 메시지
    private String mRestEnd; //휴식시간 끝 메시지

}
