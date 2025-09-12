package khy.springjpa.controller;

import khy.springjpa.dto.MonitorDTO;
import khy.springjpa.service.IMonitorService;
import khy.springjpa.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class MonitorController {

    @Resource(name = "MonitorService")
    private IMonitorService monitorService;


    @RequestMapping(value = "/getMonitorInfo")
    public String getMonitorInfo(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".getMonitorInfo Start!!");

        String user_id = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        log.info("user_id : " + user_id);

        MonitorDTO pDTO = new MonitorDTO();
        pDTO.setUserId(user_id);


        MonitorDTO rDTO = monitorService.getMonitorInfo(pDTO);

        if (rDTO == null) {
            log.info("모니터링 값 조회 실패");
            String url = "/";
            String msg = "시스템 오류입니다. let_hykim@naver.com으로 문의주세요.";
            model.addAttribute("url", url);
            model.addAttribute("msg", msg);
            return "/redirect";
        }

        session.setAttribute("SS_MONITORDTO", rDTO);
        log.info(this.getClass().getName() + ".getMonitorInfo End!!");

        return "/monitor/monitorValueCheck";
    }

    @RequestMapping(value = "/blinkUpdate")
    public String blinkUpdate(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".blinkUpdate Start!!");

        String url = "";
        String msg = "";


        String blinkValue = CmmUtil.nvl(request.getParameter("blinkValue"));

        if (blinkValue.length() == 0) {
            log.info("blinkValue error");
            url = "/getMonitorInfo";
            msg = "측정값이 없습니다. 다시 측정해주세요!";
        } else {
            log.info("blinkValue : " + blinkValue);

            MonitorDTO pDTO = new MonitorDTO();
            String user_id = (String)session.getAttribute("SS_USER_ID");
            pDTO.setUserId(user_id);
            pDTO.setBlinkCheck(blinkValue);

            int res = monitorService.updateMonitorInfo(pDTO);

            if (res == 1) {
                log.info("blinkValue 수정 성공");
                session.setAttribute("SS_MONITORDTO", pDTO);
                url = "/getMonitorInfo";
                msg = "졸음판단기준값이 업데이트되었습니다.";

            } else {
                log.info("시스템 에러");
                url = "/";
                msg = "시스템 에러입니다. let_hykim@naver.com으로 문의주세요";
            }

        }

        model.addAttribute("url", url);
        model.addAttribute("msg", msg);

        log.info(this.getClass().getName() + ".blinkUpdate End!!");

        return "/redirect";
    }

    @RequestMapping(value = "/distanceUpdate")
    public String distanceUpdate(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".distanceUpdate Start!!");

        String url = "";
        String msg = "";


        String distanceValue = CmmUtil.nvl((String) request.getParameter("distanceValue"));

        if (distanceValue.length() == 0) {
            log.info("측정값이 널");
            url = "/getMonitorInfo";
            msg = "측정값이 없습니다. 다시 측정해주세요!";
        } else {
            log.info("distanceValue : " + distanceValue);

            MonitorDTO pDTO = new MonitorDTO();

            String user_id = (String)session.getAttribute("SS_USER_ID");
            pDTO.setUserId(user_id);
            pDTO.setDistanceCheck(distanceValue);

            int res = monitorService.updateMonitorInfo(pDTO);

            if (res == 1) {
                log.info("distanceValue 수정 성공");
                session.setAttribute("SS_MONITORDTO", pDTO);
                url = "/getMonitorInfo";
                msg = "거리판단기준값이 업데이트되었습니다.";

            } else {
                log.info("시스템 에러");
                url = "/";
                msg = "시스템 에러입니다. let_hykim@naver.com으로 문의주세요";
            }

        }

        model.addAttribute("url", url);
        model.addAttribute("msg", msg);

        log.info(this.getClass().getName() + ".distanceUpdate End!!");

        return "/redirect";
    }

    @RequestMapping(value = "/totalUpdate")
    public String totalUpdate(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".totalUpdate Start!!");

        String url = "";
        String msg = "";

        String distance_check = CmmUtil.nvl((String) request.getParameter("distance_check"));
        String blink_check = CmmUtil.nvl((String) request.getParameter("blink_check"));
        String sleepCheckTime = CmmUtil.nvl((String) request.getParameter("sleepCheckTime"));
        String nearCheckTime = CmmUtil.nvl((String) request.getParameter("nearCheckTime"));
        String restTerm = CmmUtil.nvl((String) request.getParameter("restTerm"));
        String restTime = CmmUtil.nvl((String) request.getParameter("restTime"));
        String mSleep = CmmUtil.nvl((String) request.getParameter("mSleep"));
        String mNear = CmmUtil.nvl((String) request.getParameter("mNear"));
        String mRestStart = CmmUtil.nvl((String) request.getParameter("mRestStart"));
        String mRestEnd = CmmUtil.nvl((String) request.getParameter("mRestEnd"));

        MonitorDTO pDTO = new MonitorDTO();
        pDTO.setUserId((String)session.getAttribute("SS_USER_ID"));
        pDTO.setDistanceCheck(distance_check);
        pDTO.setBlinkCheck(blink_check);
        pDTO.setSleepCheckTime(sleepCheckTime);
        pDTO.setNearCheckTime(nearCheckTime);
        pDTO.setRestTerm(restTerm);
        pDTO.setRestTime(restTime);
        pDTO.setMSleep(mSleep);
        pDTO.setMNear(mNear);
        pDTO.setMRestStart(mRestStart);
        pDTO.setMRestEnd(mRestEnd);


        int res = monitorService.updateMonitorInfo(pDTO);

        if (res == 1) {

            log.info("수정 성공");
            session.setAttribute("SS_MONITORDTO", pDTO);
            url = "/getMonitorInfo";
            msg = "업데이트되었습니다.";

        } else {
            log.info("시스템 에러");
            url = "/";
            msg = "시스템 에러입니다. let_hykim@naver.com으로 문의주세요";
        }


        model.addAttribute("url", url);
        model.addAttribute("msg", msg);

        log.info(this.getClass().getName() + ".totalUpdate End!!");

        return "/redirect";
    }


}
