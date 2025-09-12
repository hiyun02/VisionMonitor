package khy.springjpa.service;

import khy.springjpa.dto.MailDTO;

public interface IMailService {
    //Service에서 최종 에러를 처리할 것이기 때문에 예외처리를 넣지 않음
    int doSendMail(MailDTO pDTO);
    int contactwrite(MailDTO pDTO);
}
