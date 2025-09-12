package khy.springjpa.repository.entity;

import lombok.*;
import org.springframework.data.mongodb.core.mapping.Document;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Field;


@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "user_info")
public class UserInfoEntity {

    @Id
    private String userSeq;

    @NonNull
    @Field(name="user_id")
    private String userId;

    @NonNull
    @Field(name="user_password")
    private String userPw;

    @NonNull
    @Field(name="user_name")
    private String userNm;

    @NonNull
    @Field(name="user_email")
    private String userEmail;


}
