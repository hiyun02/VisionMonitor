package khy.springjpa.service;

import khy.springjpa.dto.UserInfoDTO;

import java.util.Map;

public interface IUserInfoService {

    //비밀번호 찾기 : 입력받은 아이디로 임시비번 발송을 위한 이메일을 찾음
    String findUserEmailByUserId(String input_id) throws Exception;

    //아이디 찾기 : 입력받은 이메일로 아이디를 찾음
    String findUserIdByUserEmail(String input_email) throws Exception;

    //비밀번호 변경
    int updateUserPw(UserInfoDTO pDTO) throws Exception;

    //회원가입
    int userInsert(UserInfoDTO pDTO) throws Exception;

    //회원탈퇴
    int userDelete(UserInfoDTO pDTO) throws Exception;

    //로그인
    UserInfoDTO userLogin(UserInfoDTO pDTO) throws Exception;

    //아이디 중복 검사
    Map<String, String> getIdExist(String pUser_id) throws Exception;

    //이메일 중복 검사
    Map<String, String> getEmailExist(String pUser_email) throws Exception;


}
