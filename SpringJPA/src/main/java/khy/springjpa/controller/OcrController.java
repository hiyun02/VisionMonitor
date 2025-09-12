package khy.springjpa.controller;

import khy.springjpa.dto.RecordDTO;
import khy.springjpa.service.impl.OcrService;
import khy.springjpa.service.impl.RecordService;
import khy.springjpa.util.CmmUtil;
import khy.springjpa.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@Slf4j
@Controller
public class OcrController {

    private OcrService ocrService;
    private RecordService recordService;

    public OcrController(OcrService ocrService, RecordService recordService) {
        this.ocrService = ocrService;
        this.recordService = recordService;
    }


    @Value("${file.download.directory}")
    private String fileDownloadDirectory;


    @PostMapping("/upload")
    public String saveFileText(@RequestParam MultipartFile uploadFile,
                               HttpServletRequest request, ModelMap modelMap, HttpSession session) throws IOException {

        log.info(this.getClass().getName() + ".saveFileText Start!");


        String url = "/";
        String msg = "";

        try {
            log.info("request = {}", request);
            log.info("multipartFile = {}", uploadFile);

            String userName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NM"));
            log.info("userName : " + userName);

            String nowDate = DateUtil.getDateTime("yyyymmdd hhmmss");

            if (!uploadFile.isEmpty()) {

                String downloadPath = fileDownloadDirectory + userName + nowDate + ".jpg";

                log.info("파일 저장 경로 = {}", downloadPath);

                uploadFile.transferTo(new File(downloadPath));

                log.info("파일 저장 성공. ocr 함수 호출");

                String ocrText = CmmUtil.nvl(ocrService.detectText(downloadPath));

                //ocrText로 업데이트 로직
                String recordSeq = request.getParameter("recordSeq");
                log.info("recordSeq : " + recordSeq);

                RecordDTO recordDTO = new RecordDTO();
                recordDTO.setRecordSeq(recordSeq);
                recordDTO.setDailyMemo(ocrText);

                int res = recordService.insertDailyMemo(recordDTO);

                if (res == 1) {
                    log.info("ocrText is successfully inserted");
                    msg = "이미지 속의 메모내용이 성공적으로 기록되었습니다.";

                } else {
                    log.info("ocrText failed");
                    msg="이미지 메모 저장에 실패하였습니다. 다시 시도해주세요";
                }

                url = "/getDailyRecord?record_seq=" + recordSeq;

            } else {
                log.info("비어있는 파일");
                msg = "오류입니다. 다시 시도해주세요";
                modelMap.addAttribute("url", url);
                modelMap.addAttribute("msg", msg);
                return "/redirect";
            }

        } catch (Exception e) {
            msg = "오류입니다. 다시 시도해주세요";
            log.info(e.toString());

        } finally {

            modelMap.addAttribute("url", url);
            modelMap.addAttribute("msg", msg);
            log.info(this.getClass().getName() + ".saveFileText End!");

        }

        return "/redirect";
    }


}
