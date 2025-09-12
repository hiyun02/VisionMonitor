package khy.springjpa.controller;

import khy.springjpa.dto.RecordDTO;
import khy.springjpa.service.IRecordService;
import khy.springjpa.util.CmmUtil;
import khy.springjpa.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Slf4j
@Controller
public class RecordController {

    @Resource(name = "RecordService")
    private IRecordService recordService;

    //모니터링 결과값 저장
    @RequestMapping(value = "/getPythonResult")
    public String insertRecord(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".insertRecord Start!!");

        String url = "";
        String msg = "";

        String user_id = (String) session.getAttribute("SS_USER_ID");
        String record_date = DateUtil.getDateTime("yyyy-MM-dd hh:mm:ss");
        String month_date = DateUtil.getDateTime("yyyyMM");
        String start_time = (String) request.getParameter("start_time");
        String end_time = (String) request.getParameter("end_time");
        String streaming_time = (String) request.getParameter("streaming_time");
        String face_time = (String) request.getParameter("face_time");
        String near_time = (String) request.getParameter("near_time");
        String blink_time = (String) request.getParameter("blink_time");
        String distract_time = (String) request.getParameter("distract_time");
        String attention_time = (String) request.getParameter("attention_time");
        String daily_memo = "";


        log.info("user_id : " + user_id);
        log.info("streaming_time : " + streaming_time);
        log.info("attention_time : " + attention_time);
        log.info("month_date : " + month_date);
        String userName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NM"));
        log.info("userName : " + userName);

        String record_title = userName + "님의 " + record_date + " 학습기록";
        log.info("record title : " + record_title);


        RecordDTO pDTO = new RecordDTO();
        pDTO.setRecordTitle(record_title);
        pDTO.setUserId(user_id);
        pDTO.setRecordDate(record_date);
        pDTO.setStartTime(start_time);
        pDTO.setEndTime(end_time);
        pDTO.setStreamingTime(streaming_time);
        pDTO.setNearTime(near_time);
        pDTO.setBlinkTime(blink_time);
        pDTO.setFaceTime(face_time);
        pDTO.setDistractTime(distract_time);
        pDTO.setAttentionTime(attention_time);
        pDTO.setDailyMemo(daily_memo);
        pDTO.setMonthDate(month_date);

        int res = recordService.insertRecord(pDTO);

        if (res == 1) {
            log.info("기록값 저장 성공");
            msg = "성공적으로 저장되었습니다. 수고하셨습니다.";
            url = "/getRecordList";

        } else {
            log.info("기록값 저장 실패");
            msg = "저장에 실패하였습니다. let_hykim@naver.com으로 문의주세요";
            url = "/";
        }

        model.addAttribute("url", url);
        model.addAttribute("msg", msg);

        log.info(this.getClass().getName() + ".insertRecord End!!");

        return "/redirect";
    }

    //사용자별 기록 정보 리스트 불러오기
    @RequestMapping(value = "/getRecordList")
    public String getRecordList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".getRecordList Start!!");

        // 이용자아이디
        String user_id = (String) session.getAttribute("SS_USER_ID");
        RecordDTO pDTO = new RecordDTO();
        pDTO.setUserId(user_id);

        List<RecordDTO> rList = recordService.getRecordList(pDTO);

        if (rList == null) {
            log.info("널값이 넘어와 메모리에 강제로 올림");
        }

        model.addAttribute("rList", rList);
        log.info(this.getClass().getName() + ".getRecordList End!!");

        return "/record/recordList";
    }

    //사용자 별 기록정보 상세조회
    @RequestMapping(value = "/getDailyRecord")
    public String getDailyRecord(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
        log.info(this.getClass().getName() + ".getDailyRecord Start!!");

        //url로 넘어온 일별 날짜
        String record_seq = CmmUtil.nvl((String) request.getParameter("record_seq"));
        log.info("record_seq : " + record_seq);

        RecordDTO pDTO = new RecordDTO();
        pDTO.setRecordSeq(record_seq);

        RecordDTO rDTO = recordService.getDailyRecord(pDTO);

        if (rDTO == null) {
            log.info("일일 기록 정보 조회 실패");
            String msg = "시스템 오류로 실패하였습니다. let_hykim@naver.com으로 문의주세요.";
            String url = "/record/recordList";
            model.addAttribute("msg", msg);
            model.addAttribute("url", url);
            return "/redirect";
        }

        if (rDTO.getDailyMemo() == null) {
            rDTO.setDailyMemo("");
        }

        log.info("일일 기록 정보 조회 성공");

        model.addAttribute("rDTO", rDTO);


        log.info(this.getClass().getName() + ".getDailyRecord End!!");
        return "/record/recordDaily";
    }



}