package khy.springjpa.service.impl;

import khy.springjpa.dto.UserInfoDTO;
import khy.springjpa.repository.UserInfoRepository;
import khy.springjpa.repository.entity.UserInfoEntity;
import khy.springjpa.service.IUserInfoService;
import khy.springjpa.util.CmmUtil;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Getter
@RequiredArgsConstructor
@Service("UserInfoService")
public class UserInfoService implements IUserInfoService {

    private final UserInfoRepository userInfoRepository;

    @Override
    public String findUserEmailByUserId(String input_id) throws Exception {
        log.info(this.getClass().getName() + ".findUserEmailByUserId Start!");

        if (input_id == null) {
            input_id = "";
            log.info("check input_id");
        }

        UserInfoEntity rEntity = userInfoRepository.findUserEmailByUserId(input_id);

        if (rEntity == null) {
            rEntity = new UserInfoEntity();
        }

        String userEmail = rEntity.getUserEmail();
        rEntity = null;

        log.info(this.getClass().getName() + ".findUserEmailByUserId End!");

        return userEmail;
    }

    @Override
    public String findUserIdByUserEmail(String input_email) throws Exception {
        log.info(this.getClass().getName() + ".findUserIdByUserEmail Start!");

        if (input_email == null) {
            input_email = "";
            log.info("check input_email");
        }

        UserInfoEntity rEntity = userInfoRepository.findUserIdByUserEmail(input_email);

        if (rEntity == null) {
            rEntity = new UserInfoEntity();
        }

        String userId = rEntity.getUserId();
        rEntity = null;

        log.info(this.getClass().getName() + ".findUserIdByUserEmail End!");

        return userId;
    }

    @Transactional
    @Override
    public int updateUserPw(UserInfoDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".updateUserPw Start!");

        int res = 0;

        try {

            UserInfoEntity pEntity = UserInfoEntity.builder()
                    .userSeq(pDTO.getUser_seq()).userId(pDTO.getUser_id())
                    .userPw(pDTO.getUser_pw()).userNm(pDTO.getUser_nm())
                    .userEmail(pDTO.getUser_email()).build();

            userInfoRepository.save(pEntity);

            res = 1;

            pEntity = null;

        } catch (Exception e) {
            log.info(e.toString());
        } finally {
            pDTO = null;
        }

        log.info(this.getClass().getName() + ".updateUserPw End!");

        return res;
    }

    @Transactional
    @Override
    public int userInsert(UserInfoDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".userInsert Start!");

        int res = 0;

        try {

            if (pDTO == null) {
                pDTO = new UserInfoDTO();
                log.info("check input dto");
            }

            String userId = pDTO.getUser_id();
            String userPw = pDTO.getUser_pw();
            String userNm = pDTO.getUser_nm();
            String userEmail = pDTO.getUser_email();

            log.info("userId : "+userId);
            log.info("userPw : "+userPw);
            log.info("userNm : " + userNm);
            log.info("userEmail : " + userEmail);



            UserInfoEntity pEntity = UserInfoEntity.builder()
                    .userId(userId)
                    .userPw(userPw).userNm(userNm)
                    .userEmail(userEmail).build();

            userInfoRepository.save(pEntity);

            res = 1;

            pEntity = null;


        } catch (Exception e) {
            log.info(e.toString());
        }

        log.info(this.getClass().getName() + ".userInsert End!");

        return res;
    }

    @Transactional
    @Override
    public int userDelete(UserInfoDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".userDel Start!");

        int res = 0;

        try {
            if (pDTO == null) {
                pDTO = new UserInfoDTO();
                log.info("input DTO is null");
            }

            Optional<UserInfoEntity> rEntity = userInfoRepository.findByUserIdAndUserPw(pDTO.getUser_id(), pDTO.getUser_pw());

            if (rEntity.isPresent()) {
                log.info("correct id & pw --> user delete process");
                userInfoRepository.deleteById(pDTO.getUser_seq());
                res = 1;
            } else {
                log.info("received wrong password");
            }

            rEntity = null;

        } catch (Exception e) {
            log.info(e.toString());
        } finally {
            log.info(this.getClass().getName() + ".userDel Start!");
        }

        return res;
    }

    @Override
    public UserInfoDTO userLogin(UserInfoDTO pDTO) throws Exception {
        log.info(this.getClass().getName()+".userLogin Start!");

        UserInfoDTO userInfoDTO = new UserInfoDTO();

        if (pDTO == null) {
            pDTO = new UserInfoDTO();
            log.info("check input dto");
        }

        String userId = CmmUtil.nvl(pDTO.getUser_id());
        String userPw = CmmUtil.nvl(pDTO.getUser_pw());

        log.info("userId : "+userId);
        log.info("userPw : "+userPw);

        Optional<UserInfoEntity> opt = userInfoRepository.findByUserIdAndUserPw(userId, userPw);

        if (opt.isPresent()) {

            UserInfoEntity rEntity = opt.get();

            log.info("login query success");

            userInfoDTO.setUser_seq(rEntity.getUserSeq());
            userInfoDTO.setUser_id(rEntity.getUserId());
            userInfoDTO.setUser_pw(rEntity.getUserPw());
            userInfoDTO.setUser_email(rEntity.getUserEmail());
            userInfoDTO.setUser_nm(rEntity.getUserNm());


        } else {
            log.info("login query fail");
        }

        log.info(this.getClass().getName()+".userLogin End!");

        return userInfoDTO;
    }

    @Override
    public Map<String, String> getIdExist(String pUser_id) throws Exception {
        log.info(this.getClass().getName() + ".getIdExist Start!");

        Map<String, String> rMap = new HashMap<>();

        String pUserId = CmmUtil.nvl(pUser_id);

        Optional<UserInfoEntity> rEntity = userInfoRepository.findByUserId(pUserId);

        if (rEntity.isPresent()) {
            log.info("input userId is already exist.");
            rMap.put("Exist_yn", "y");
        } else {
            log.info("input userId isn't exist");
            rMap.put("Exist_yn","n");
        }

        log.info(this.getClass().getName() + ".getIdExist End!");

        return rMap;
    }

    @Override
    public Map<String, String> getEmailExist(String pUser_email) throws Exception {

        log.info(this.getClass().getName() + ".getEmailExist Start!");

        Map<String, String> rMap = new HashMap<>();

        String pUserEmail = CmmUtil.nvl(pUser_email);

        Optional<UserInfoEntity> rEntity = userInfoRepository.findByUserEmail(pUserEmail);

        if (rEntity.isPresent()) {
            log.info("input userEmail is already exist.");
            rMap.put("Exist_yn", "y");
        } else {
            log.info("input userEmail isn't exist");
            rMap.put("Exist_yn","n");
        }

        log.info(this.getClass().getName() + ".getEmailExist End!");

        return rMap;
    }
}
