package khy.springjpa.repository.entity;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Document(collection="monitor_info")
public class MonitorEntity {

    @Id
    private String monitorSeq;

    @NonNull
    @Field(name = "user_id")
    private String userId; //모니터링값 사용자 아이디


    @Field(name = "distance_check")
    private String distanceCheck; //근거리 탐지 기준(안구영역넓이)


    @Field(name = "blink_check")
    private String blinkCheck; //졸음 탐지 기준(blink값)
    //모든 시간값은 초로 입력(타입은 String)


    @Field(name = "sleepCheckTime")
    private String sleepCheckTime; //졸음 탐지 시간

    @Field(name = "nearCheckTime")
    private String nearCheckTime; //근거리 탐지

    @Field(name = "restTerm")
    private String restTerm; //휴식시간 주기

    @Field(name = "restTime")
    private String restTime; //휴식시간

    @Field(name = "mSleep")
    private String mSleep; //졸음 방지 메시지

    @Field(name = "mNear")
    private String mNear; //근거리 방지 메시지

    @Field(name = "mRestStart")
    private String mRestStart; //휴식시간 시작 메시지

    @Field(name = "mRestEnd")
    private String mRestEnd; //휴식시간 끝 메시지
}
