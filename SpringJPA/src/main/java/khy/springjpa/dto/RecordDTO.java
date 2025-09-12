package khy.springjpa.dto;

import lombok.Data;
import lombok.Getter;

@Data
@Getter
//기록정보 객체
public class RecordDTO {

    private String recordSeq;
    private String userId; // 기록정보를 사용할 사용자의 아이디
    private String recordDate; //yyyy-mm-dd
    private String startTime; //웹캠시작시간
    private String endTime; //웹캠종료시간
    private String streamingTime; //웹캠작동시간
    private String faceTime; //얼굴인식시간
    private String nearTime; //근거리탐지시간
    private String blinkTime; //졸음탐지시간
    private String distractTime; //집중못한시간(근거리+졸음)
    private String attentionTime; //사용자집중시간
    private String dailyMemo; //일일 사용자 코멘트
    private String recordTitle; //기록 제목
    private String monthDate; //월 표시

}