package khy.springjpa.repository.entity;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "record_info")
public class RecordEntity {

    @Id
    private String recordSeq;

    @NonNull
    @Field(name = "user_id")
    private String userId; // 기록정보를 사용할 사용자의 아이디

    @NonNull
    @Field(name = "record_date")
    private String recordDate; // yyyy-mm-dd

    @NonNull
    @Field(name = "start_time")
    private String startTime; // 웹캠시작시간

    @NonNull
    @Field(name = "end_time")
    private String endTime; //웹캠종료시간

    @NonNull
    @Field(name = "streaming_time")
    private String streamingTime; //웹캠작동시간

    @NonNull
    @Field(name = "face_time")
    private String faceTime; //얼굴인식시간

    @NonNull
    @Field(name = "near_time")
    private String nearTime; //근거리탐지시간

    @NonNull
    @Field(name = "blink_time")
    private String blinkTime; //졸음탐지시간

    @NonNull
    @Field(name = "distract_time")
    private String distractTime; //집중못한시간(근거리+졸음)

    @NonNull
    @Field(name = "attention_time")
    private String attentionTime; //사용자집중시간

    //일일 사용자 코멘트
    @Field(name = "daily_memo")
    private String dailyMemo;

    @NonNull
    @Field(name = "record_title")
    private String recordTitle; //기록 제목

    @NonNull
    @Field(name = "month_date")
    private String monthDate;
}
