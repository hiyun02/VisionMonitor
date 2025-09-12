package khy.springjpa.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MailDTO {
    private String toMail;
    private String contents;
    private String title;
}
