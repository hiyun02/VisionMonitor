package khy.springjpa.controller;

import khy.springjpa.dto.MailDTO;
import khy.springjpa.dto.MonitorDTO;
import khy.springjpa.dto.UserInfoDTO;
import khy.springjpa.service.IMailService;
import khy.springjpa.service.IMonitorService;
import khy.springjpa.service.IUserInfoService;
import khy.springjpa.util.CmmUtil;
import khy.springjpa.util.EncryptUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
public class UserInfoController {

    @Resource(name = "MailService")
    private IMailService mailService;

    @Resource(name = "MonitorService")
    private IMonitorService monitorService;

    @Resource(name = "UserInfoService")
    private IUserInfoService userinfoService;


    //로그인한 상태에서 비밀번호를 변경하는 로직 : 기존 비밀번호를 입력받아 세션의 아이디와 로그인로직 실행 후 변경
    @RequestMapping(value = "/updateUserPw")
    public String changeNewPw(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".changeNewPw Start!!");

        String url;
        String msg;

        String ss_user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        //입력받은 기존비밀번호
        String input_userPw = EncryptUtil.encHashSHA256(CmmUtil.nvl((String) request.getParameter("input_userPw")));

        log.info("SS_USER_ID : " + ss_user_id);
        log.info("input_userPw : " + input_userPw);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUser_id(ss_user_id);
        pDTO.setUser_pw(input_userPw);

        //입력받은 비밀번호와 세션의 아이디로 로그인 실행
        UserInfoDTO rDTO = userinfoService.userLogin(pDTO);

        pDTO = null;

        if (rDTO.getUser_id() == null) {

            log.info("잘못된 비밀번호가 입력되어 로그인 로직 실패");

            msg = "비밀번호가 올바르지 않습니다.";
            url = "/user/userLoginForm";

        } else {

            log.info("올바른 비밀번호가 입력됨을 확인함");
            //update 로직 시작
            pDTO = new UserInfoDTO();

            //입력받은 신규비밀번호
            String newUserPw = EncryptUtil.encHashSHA256(CmmUtil.nvl((String) request.getParameter("input_newPw")));
            String userSeq = CmmUtil.nvl(rDTO.getUser_seq());
            String userId = CmmUtil.nvl(rDTO.getUser_id());
            String userNm = CmmUtil.nvl(rDTO.getUser_nm());
            String userEmail = CmmUtil.nvl(rDTO.getUser_email());

            rDTO = null;

            log.info("userSeq : " + userSeq);
            log.info("newUserPw : " + newUserPw);
            log.info("userId : " + userId);
            log.info("userNm : " + userNm);
            log.info("userEmail : " + userEmail);

            pDTO.setUser_seq(userSeq);
            pDTO.setUser_id(userId);
            pDTO.setUser_pw(newUserPw);
            pDTO.setUser_nm(userNm);
            pDTO.setUser_email(userEmail);

            int updateRes = userinfoService.updateUserPw(pDTO);

            if (updateRes == 1) {
                log.info("비밀번호 변경 성공");
                url = "/user/userLoginForm";
                msg = "비밀번호가 성공적으로 변경되었습니다. 로그인 페이지로 이동합니다.";
            } else {
                log.info("비밀번호 변경 실패");
                url = "/user/userLoginForm";
                msg = "시스템 오류. 잠시 후 다시 시도해주세요.";
            }
        }

        model.addAttribute("url", url);
        model.addAttribute("msg", msg);

        log.info(this.getClass().getName() + ".changeNewPw End!!");

        return "/redirect";
    }

    /**
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    //inputforfindPw로부터 입력받은 아이디로 비밀번호 찾기 인증번호 보내는 로직
    @RequestMapping(value = "/findUserPw/sendKey")
    @ResponseBody
    public HashMap<String, String> sendPwKey(HttpServletRequest request, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".sendPwKey Start!!");

        String url = "";
        String msg = "";
        int res = 0;
        String randomKey = "";

        String input_id = CmmUtil.nvl((String) request.getParameter("user_id"));
        String input_email = CmmUtil.nvl(request.getParameter("user_email"));

        //db에서 가져온 사용자 이메일
        String result_email = CmmUtil.nvl(userinfoService.findUserEmailByUserId(input_id));

        if (result_email.length() == 0) {
            log.info("잘못된 아이디로, 조회된 메일정보가 없음");
        } else {
            log.info("메일 조회 성공, 메일 발송 시작");

            //랜덤 인증번호 생성
            randomKey = String.valueOf( (int) (Math.random() * 1000000));

            //메일 발송
            MailDTO mDTO = new MailDTO();
            mDTO.setToMail(EncryptUtil.decAES128CBC(input_email));
            mDTO.setTitle("ICCU가 회원님의 비밀번호 찾기 인증번호를 발송드립니다.");
            mDTO.setContents("회원님의 비밀번호 찾기 인증번호는 " + randomKey + " 입니다. 잊지 마세요 !");

            res = mailService.doSendMail(mDTO);

        }
        HashMap<String, String> rMap = new HashMap<>();

        rMap.put("auth_code", randomKey);
        rMap.put("result", String.valueOf(res));


        log.info(this.getClass().getName() + ".sendPwKey End!!");

        return rMap;
    }

    //비밀번호 수정 로직
    @RequestMapping(value = "/findUserPw")
    public String findPw(HttpServletRequest request, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".findPw Start!!");

        String url = "";
        String msg = "";

        String newPw = EncryptUtil.encHashSHA256(CmmUtil.nvl((String) request.getParameter("user_pw2")));
        String user_id = CmmUtil.nvl((String) request.getParameter("user_id"));
        log.info("newPw : " + newPw);
        log.info("user_id : " + user_id);

        UserInfoDTO pDTO = new UserInfoDTO();
        pDTO.setUser_pw(newPw);
        pDTO.setUser_id(user_id);

        int res = userinfoService.updateUserPw(pDTO);

        if (res == 1) {
            log.info("success");
            msg = "비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요";
            url = "/user/userLoginForm";
        } else {
            log.info("fail");
            msg = "비밀번호 변경에 실패하였습니다. let_hykim@naver.com으로 문의주세요";
            url = "/user/userLoginForm";
        }

        model.addAttribute("url", url);
        model.addAttribute("msg", msg);

        log.info(this.getClass().getName() + ".findPw End!!");

        return "/redirect";
    }

    //inputforfindUserIdByUserEmail로부터 이메일을 입력받아 아이디찾기 및 인증번호 발송
    @PostMapping(value = "/findUserId/sendKey")
    @ResponseBody
    public HashMap<String, String> sendIdKey(HttpServletRequest request, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".sendIdKey Start!!");

        String url = "";
        String msg = "";
        String randomKey = "";

        int res = 0;
        String input_email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("user_email")));
        log.info("input_email : " + input_email);

        String result_id = CmmUtil.nvl(userinfoService.findUserIdByUserEmail(input_email));

        if (result_id.length() == 0) {
            log.info("잘못된 이메일로 아이디 조회 실패");
            msg = "이메일을 다시 확인해주세요";
            url = "/user/inputforfindUserIdByUserEmail";
        } else {
            log.info("아이디 조회 성공, 메일 발송 시작");

            //랜덤 인증번호 생성
            randomKey = String.valueOf((int) (Math.random() * 1000000));

            //메일 발송
            MailDTO mDTO = new MailDTO();
            mDTO.setToMail(EncryptUtil.decAES128CBC(input_email));
            mDTO.setTitle("ICCU가 회원님의 아이디 찾기 인증번호를 발송드립니다.");
            mDTO.setContents("회원님의 아이디 인증번호는 " + randomKey + " 입니다. 잊지 마세요 !");

            res = mailService.doSendMail(mDTO);

        }
        HashMap<String, String> rMap = new HashMap<>();

        rMap.put("auth_code", randomKey);
        rMap.put("result", String.valueOf(res));

        log.info(this.getClass().getName() + ".sendIdKey End!!");

        return rMap;
    }

    //인증번호 확인하면 ID 보여주는 로직
    @PostMapping(value = "/showUserId")
    public String showUserId(HttpServletRequest request, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".finduserID Start!!");

        String url = "";
        String msg = "";

        String input_email = EncryptUtil.encAES128CBC(CmmUtil.nvl((String) request.getParameter("user_email")));
        log.info("input_email : " + input_email);

        String result_id = CmmUtil.nvl(userinfoService.findUserIdByUserEmail(input_email));

        if (result_id.length() == 0) {
            log.info("잘못된 이메일로 아이디 조회 실패");
            msg = "이메일을 다시 확인해주세요";
            url = "/user/findUserIdByUserEmail";
        } else {
            log.info("아이디 조회 성공, 메일 발송 시작");

            msg = "회원님의 아이디는 " + result_id + "입니다!";
            url = "/user/userLoginForm";
        }

        model.addAttribute("url", url);
        model.addAttribute("msg", msg);
        log.info(this.getClass().getName() + ".finduserID End!!");

        return "/redirect";
    }

    @PostMapping(value = "/user/userLogin")
    public String userLogin(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".userLogin Start!!");

        String msg;
        String url;

        try {
            String input_id = CmmUtil.nvl(request.getParameter("user_id"));
            String input_pw = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("user_pw")));

            log.info("input_id : " + input_id);
            log.info("input_pw : " + input_pw);

            UserInfoDTO pDTO = new UserInfoDTO();

            pDTO.setUser_id(input_id);
            pDTO.setUser_pw(input_pw);

            UserInfoDTO rDTO = userinfoService.userLogin(pDTO);

            if (rDTO.getUser_id() == null) {

                log.info("로그인 실패");

                msg = "아이디 혹은 비밀번호가 올바르지 않습니다.";
                url = "/user/userLoginForm";

            } else {
                log.info("로그인 성공");

                String user_seq = CmmUtil.nvl(rDTO.getUser_seq());
                String user_id = CmmUtil.nvl(rDTO.getUser_id());
                String user_nm = CmmUtil.nvl(rDTO.getUser_nm());
                String encrypted_user_email = CmmUtil.nvl(rDTO.getUser_email());

                log.info("user_seq : " + user_seq);
                log.info("user_id : " + user_id);
                log.info("user_nm : " + user_nm);
                log.info("encrypted_user_email : " + encrypted_user_email);

                msg = user_nm + "님, 반갑습니다.";
                url = "/";

                session.setAttribute("SS_USER_SEQ", user_seq);
                session.setAttribute("SS_USER_ID", user_id);
                session.setAttribute("SS_USER_NM", user_nm);
                session.setAttribute("SS_ENCRYPTED_USER_EMAIL", encrypted_user_email);

            }
        } catch (Exception e) {
            msg = "시스템 오류입니다. 잠시 후 다시 시도해주세요.";
            url = "/user/userLoginForm";
            log.info(e.toString());
            e.printStackTrace();
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".userLogin End!!");

        return "/redirect";
    }

    //로그아웃
    @RequestMapping(value = "/user/userLogout")
    public String userLogout(HttpSession session, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".userLogout Start!!");

        // session 비움
        session.invalidate();

        model.addAttribute("msg", "로그아웃 성공");
        model.addAttribute("url", "/user/userLoginForm");

        log.info(this.getClass().getName() + ".userLogout End!!");

        return "/redirect";
    }

    @PostMapping(value = "/user/userInsert")
    public String userInsert(HttpServletRequest request, ModelMap model) throws Exception {
        log.info(this.getClass().getName() + ".userInsert Start!!");

        String msg = "";
        String url = "";

        try {

            String user_id = CmmUtil.nvl(request.getParameter("user_id"));
            String user_pw = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("user_pw")));
            String user_nm = CmmUtil.nvl(request.getParameter("user_nm"));
            String user_email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("user_email")));

            log.info("user_id : " + user_id);
            log.info("user_pw : " + user_pw);
            log.info("user_nm : " + user_nm);
            log.info("user_email : " + user_email);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_id(user_id);
            pDTO.setUser_pw(user_pw);
            pDTO.setUser_nm(user_nm);
            pDTO.setUser_email(user_email);

            userinfoService.userInsert(pDTO);

            MonitorDTO mDTO = new MonitorDTO();
            mDTO.setUserId(user_id);
            monitorService.insertMonitorInfo(mDTO);

            msg = "회원가입 성공";
            url = "/user/userLoginForm";

        } catch (Exception e) {
            // 저장 실패 시
            msg = "회원가입 실패";
            url = "/user/userInsertForm";
            log.info(e.toString());
            e.printStackTrace();
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".userInsert End!!");

        return "/redirect";
    }

    @RequestMapping(value = "/user/getIdExist")
    @ResponseBody
    public Map<String, String> getIdExist(HttpServletRequest request) throws Exception {

        log.info(this.getClass().getName() + ".getIdExist Start!!");

        Map<String, String> rMap = new HashMap<>();

        try {

            String user_id = CmmUtil.nvl(request.getParameter("user_id"));
            log.info("user_id : " + user_id);

            rMap = userinfoService.getIdExist(user_id);
            log.info("입력받은 아이디의 존재 여부 : " + rMap.get("Exist_yn"));

        } catch (Exception e) {
            rMap.put("Exist_yn", "exception");
            log.info(e.toString());
            e.printStackTrace();
        }

        log.info(this.getClass().getName() + ".getIdExist End!!");

        return rMap;
    }

    @RequestMapping(value = "/user/getEmailExist")
    @ResponseBody
    public Map<String, String> getEmailExist(HttpServletRequest request) throws Exception {

        log.info(this.getClass().getName() + ".getEmailExist Start!!");

        Map<String, String> rMap = new HashMap<>();

        try {

            String input_email_encrypted = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("user_email")));
            log.info("input_email : " + input_email_encrypted);

            rMap = userinfoService.getEmailExist(input_email_encrypted);
            log.info("입력받은 이메일의 존재 여부 : " + rMap.get("Exist_yn"));

        } catch (Exception e) {
            rMap.put("Exist_yn", "exception");
            log.info(e.toString());
            e.printStackTrace();
        }

        log.info(this.getClass().getName() + ".getEmailExist End!!");

        return rMap;
    }

    @RequestMapping(value = "/user/userDel")
    public String userDel(HttpServletRequest request, ModelMap model, HttpSession session) {

        log.info(this.getClass().getName() + ".userDel Start!");
        int res = 0;
        String msg = "";
        String url = "";


        try {
            String user_seq = CmmUtil.nvl((String) session.getAttribute("SS_USER_SEQ"));
            String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
            String user_pw = CmmUtil.nvl(request.getParameter("userPw"));

            log.info("탈퇴할 사용자 아이디 : " + user_id);

            UserInfoDTO pDTO = new UserInfoDTO();

            pDTO.setUser_seq(user_seq);
            pDTO.setUser_id(user_id);
            pDTO.setUser_pw(EncryptUtil.encHashSHA256(user_pw));

            res = userinfoService.userDelete(pDTO);

            if (res == 1) {
                log.info("삭제로직 실행 성공");

                msg = "성공적으로 탈퇴되었습니다. 이용해주셔서 감사합니다.";
                url = "/user/userLoginForm";
            } else {
                log.info("삭제로직 실행 실패 : 잘못된 비밀번호");
                msg = "비밀번호가 올바르지 않습니다.";
                url = "/user/userDelete";
            }

        } catch (Exception e) {
            log.info(e.toString());
            e.printStackTrace();
            msg = "시스템 오류입니다. 잠시후 다시 시도해주세요.";
            url = "/user/userDelete";
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".userDel End!");

        return "/redirect";
    }
}
