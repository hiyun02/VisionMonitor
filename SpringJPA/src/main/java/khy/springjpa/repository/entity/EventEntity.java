package khy.springjpa.repository.entity;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Document(collection="event")
public class EventEntity {

    @Id
    private String eventId;

    @NonNull
    @Field(name="userId")
    private String userId;

    @NonNull
    @Field(name="eventTitle")
    private String eventTitle;

    @NonNull
    @Field(name="eventStart")
    private String eventStart;


    @Field(name="eventEnd")
    private String eventEnd;
}
