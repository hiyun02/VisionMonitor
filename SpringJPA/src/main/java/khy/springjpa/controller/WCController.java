package khy.springjpa.controller;

import khy.springjpa.dto.RecordDTO;
import khy.springjpa.service.impl.RecordService;
import khy.springjpa.util.CmmUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller
@RequestMapping(value = "/wc")
public class WCController {

    private RecordService recordService;

    public WCController(RecordService recordService) {
        this.recordService = recordService;
    }

    @GetMapping(value = "/recordWC")
    public String recordWC(HttpServletRequest request, ModelMap modelMap,
                           HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".drawWC Start!");

        String msg = "";
        String url = "";

        String userId = CmmUtil.nvl((String) session.getAttribute("SS_USER_ID"));
        log.info("userId : " + userId);
        String monthDate = CmmUtil.nvl(request.getParameter("monthDate"));
        log.info("monthDate : " + monthDate);

        RecordDTO recordDTO = new RecordDTO();
        recordDTO.setUserId(userId);
        recordDTO.setMonthDate(monthDate);

        List<RecordDTO> rList = recordService.getWcTextList(recordDTO);

        if (rList == null) {
            log.info("result list is null");
            rList = new ArrayList<>();
        }

        StringBuilder wcText = new StringBuilder();

        for (RecordDTO rDTO : rList) {
            log.info("수집된 기록의 입력 날짜 : " + rDTO.getRecordDate());
            wcText.append(CmmUtil.nvl(rDTO.getDailyMemo()));
        }

        String wcTextTotal = wcText.toString();
        msg = monthDate.substring(0, 4) + "년 " + monthDate.substring(4) + "월의 데이터를 기반으로 워드클라우드를 생성합니다.";
        log.info("msg : " + msg);

        modelMap.addAttribute("msg", msg);
        modelMap.addAttribute("wcTextTotal", wcTextTotal);

        log.info(this.getClass().getName() + ".drawWC End!");

        return "/wc/recordWC";
    }


}
