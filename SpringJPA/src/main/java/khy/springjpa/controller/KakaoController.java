package khy.springjpa.controller;

import khy.springjpa.dto.MonitorDTO;
import khy.springjpa.dto.UserInfoDTO;
import khy.springjpa.service.impl.KakaoService;
import khy.springjpa.service.impl.MonitorService;
import khy.springjpa.service.impl.UserInfoService;
import khy.springjpa.util.CmmUtil;
import khy.springjpa.util.EncryptUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


@Slf4j
@Controller
@RequestMapping(value = "/kakao")
public class KakaoController {

    private KakaoService kakaoService;
    private UserInfoService userInfoService;
    private MonitorService monitorService;

    public KakaoController(KakaoService kakaoService, UserInfoService userInfoService, MonitorService monitorService) {
        this.kakaoService = kakaoService;
        this.userInfoService = userInfoService;
        this.monitorService = monitorService;
    }

    @GetMapping(value = "/OAuthRedirect")
    public String KakaoLogin(@RequestParam("code") String code, HttpSession session) {

        log.info(this.getClass().getName() + ".KakaoOAuthCode Start!");

        String access_Token = CmmUtil.nvl(kakaoService.getAccessToken(code));

        if (access_Token.length() != 0) {
            //     session.setAttribute("userId", userInfo.get("email"));
            log.info("access_Token : " + access_Token);
            session.setAttribute("SS_KAKAO_TOKEN", access_Token);
        }

        log.info(this.getClass().getName() + ".KakaoOAuthCode End!");

        return "/index";
    }

    @GetMapping(value = "/Logout")
    public String KakaoLogout(HttpSession session) {

        log.info(this.getClass().getName() + ".KakaoLogout Start!");

        session.invalidate();

        log.info(this.getClass().getName() + ".KakaoLogout Start!");

        return "/user/userLoginForm";
    }

    @PostMapping(value = "/userInsert")
    public String kakaoUserInsert(HttpServletRequest request, ModelMap modelMap, HttpSession session) {
        log.info(this.getClass().getName() + ".kakaoUserInsert Start!");

        String url = "/index";
        String msg = "";

        try {
            int res = 0;

            String user_pw = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("user_pw")));
            log.info("user_pw : " + user_pw);

            String SS_KAKAO_TOKEN = CmmUtil.nvl((String) session.getAttribute("SS_KAKAO_TOKEN"));
            log.info("SS_KAKAO_TOKEN : " + SS_KAKAO_TOKEN);

            HashMap<String, Object> userInfo = kakaoService.getUserInfo(SS_KAKAO_TOKEN);
            log.info("토큰으로 가져온 유저정보 : " + userInfo);

            String kakaoEmail = CmmUtil.nvl((String) userInfo.get("email"));
            String kakaoNm = CmmUtil.nvl((String) userInfo.get("nickname"));
            log.info("kakaoEmail : " + kakaoEmail);
            log.info("kakaoName : " + kakaoNm);

            String user_id = kakaoEmail;
            String user_nm = kakaoNm;
            String user_email = EncryptUtil.encAES128CBC(kakaoEmail);

            UserInfoDTO userInfoDTO = new UserInfoDTO();
            userInfoDTO.setUser_id(user_id);
            userInfoDTO.setUser_pw(user_pw);
            userInfoDTO.setUser_nm(user_nm);
            userInfoDTO.setUser_email(user_email);

            res = userInfoService.userInsert(userInfoDTO);

            MonitorDTO mDTO = new MonitorDTO();
            mDTO.setUserId(user_id);
            monitorService.insertMonitorInfo(mDTO);

            if (res == 1) {
                log.info("회원가입 성공");
                url = "/user/userLoginForm";
                msg = "ICCU 회원가입을 환영합니다.";
                session.setAttribute("SS_KAKAO_TOKEN","");
            } else {
                log.info("회원가입 실패");
                msg = "회원가입에 실패하였습니다. 다시 시도해주세요";
                url = "/kakao/userInsertForm";
            }

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            modelMap.addAttribute("url", url);
            modelMap.addAttribute("msg", msg);
            log.info(this.getClass().getName() + ".kakaoUserInsert End!");
        }

        return "/redirect";
    }

    @GetMapping(value = "/userInsertForm")
    public String userInsertForm() {
        log.info(this.getClass().getName() + ".userInsertForm Started!");
        return "/kakao/userInsertForm";
    }
}
