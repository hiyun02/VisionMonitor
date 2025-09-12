package khy.springjpa.dto;

import lombok.Data;

@Data
public class EventDTO {

    private String eventId;
    private String userId;
    private String eventTitle;
    private String eventStart;
    private String eventEnd;


}
