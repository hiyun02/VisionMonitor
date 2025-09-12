package khy.springjpa.controller;

import khy.springjpa.dto.EventDTO;
import khy.springjpa.service.impl.EventService;
import khy.springjpa.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
@RequestMapping(value = "/cal")
public class CalController {

    private EventService eventService;

    public CalController(EventService eventService) {
        this.eventService = eventService;
    }

    @GetMapping(value = "/calendar")
    public String getCalendar(ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {

        log.info(this.getClass().getName()+"getCalendar Start!");

        String userId = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        log.info("userId : " + userId);


        List<EventDTO> eList = eventService.getEventList(userId);

        log.info("풀캘린더 시작 가져온 리스트의 값?" + eList);


        if (eList == null) {
            eList = new ArrayList<EventDTO>();

        }

        //리스트 결과값 넣어주기
        model.addAttribute("eList", eList);

        eList = null;

        log.info(this.getClass().getName()+"getCalendar End!");

        return "/cal/calendar";
    }

    @ResponseBody
    @GetMapping(value = "/insertEvent")
    public String insertEvent(HttpServletRequest request, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".insertEvent Start!");

        String userId = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        log.info("userId : " + userId);

        String title = CmmUtil.nvl(request.getParameter("title"));
        String start = CmmUtil.nvl(request.getParameter("start"));
        String end = CmmUtil.nvl(request.getParameter("end"));

        EventDTO pDTO = new EventDTO();
        pDTO.setUserId(userId);
        pDTO.setEventStart(start);
        pDTO.setEventEnd(end);
        pDTO.setEventTitle(title);

        eventService.insertEvent(pDTO);

        log.info(this.getClass().getName() + ".insertEvent End!");

        return "success";
    }
}
