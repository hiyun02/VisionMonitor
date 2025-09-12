package khy.springjpa.service.impl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import khy.springjpa.dto.RecordDTO;

import khy.springjpa.repository.RecordRepository;
import khy.springjpa.repository.entity.RecordEntity;
import khy.springjpa.service.IRecordService;
import khy.springjpa.util.CmmUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service("RecordService")
public class RecordService implements IRecordService {

    private final RecordRepository recordRepository;

    @Override
    public int insertRecord(RecordDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".insertRecord Start!");

        int res = 0;

        try {
            if (pDTO == null) {
                pDTO = new RecordDTO();
                log.info("input dto is null");
            }

            RecordEntity pEntity = RecordEntity.builder()
                    .userId(pDTO.getUserId()).recordDate(pDTO.getRecordDate())
                    .startTime(pDTO.getStartTime()).endTime(pDTO.getEndTime())
                    .streamingTime(pDTO.getStreamingTime()).faceTime(pDTO.getFaceTime())
                    .nearTime(pDTO.getNearTime()).blinkTime(pDTO.getBlinkTime())
                    .distractTime(pDTO.getDistractTime()).attentionTime(pDTO.getAttentionTime())
                    .attentionTime(pDTO.getAttentionTime()).dailyMemo(pDTO.getDailyMemo())
                    .recordTitle(pDTO.getRecordTitle()).monthDate(pDTO.getMonthDate()).build();

            recordRepository.save(pEntity);

            res = 1;

            pEntity = null;

        } catch (Exception e) {
            log.info(e.toString());
        } finally {
            log.info(this.getClass().getName() + ".insertRecord End!");
        }
        return res;
    }

    @Override
    public List<RecordDTO> getRecordList(RecordDTO pDTO) throws Exception {

        log.info(this.getClass().getName() + ".getRecordList Start!");

        if (pDTO == null) {
            pDTO = new RecordDTO();
            log.info("input dto is null");
        }

        List<RecordEntity> rEntityList = recordRepository.findAllByUserIdOrderByRecordSeqDesc(pDTO.getUserId());

        if (rEntityList == null) {
            log.info("query result is null");
            rEntityList = new ArrayList<>();
        }

        List<RecordDTO> rList = new ObjectMapper().convertValue(rEntityList , new TypeReference<List<RecordDTO>>(){});

        log.info(this.getClass().getName() + ".getRecordList End!");

        return rList;

    }

    @Override
    public RecordDTO getDailyRecord(RecordDTO pDTO) throws Exception {
        log.info(this.getClass().getName()+".getDailyRecord Start!");

        if (pDTO == null) {
            log.info("input dto is null");
            pDTO = new RecordDTO();
        }

        String recordSeq = CmmUtil.nvl(pDTO.getRecordSeq());
        log.info("recordSeq : "+recordSeq);

        Optional<RecordEntity> opt = recordRepository.findById(recordSeq);

        if (!opt.isPresent()) {
            log.info("recordEntity is null");
            RecordDTO recordDTO = new RecordDTO();
            return recordDTO;
        }

        RecordEntity recordEntity = opt.get();

        RecordDTO recordDTO = new ObjectMapper().convertValue(recordEntity, RecordDTO.class);

        log.info(this.getClass().getName()+".getDailyRecord End!");

        return recordDTO;
    }

    @Override
    public int insertDailyMemo(RecordDTO pDTO) throws Exception {
        log.info(this.getClass().getName()+".insertDailyMemo Start!");

        int res = 0;

        String recordSeq = pDTO.getRecordSeq();
        String dailyMemo = pDTO.getDailyMemo();

        Optional<RecordEntity> opt = recordRepository.findById(recordSeq);

        if (!opt.isPresent()) {
            return res;
        }

        log.info("seq로 조회한 레코드가 존재함");
        RecordEntity rEntity = opt.get();

        //seq(pk)와 메모값을 엔터티에 빌드
        RecordEntity pEntity = RecordEntity.builder()
                        .recordSeq(recordSeq).dailyMemo(dailyMemo)
                        .recordTitle(rEntity.getRecordTitle()).recordDate(rEntity.getRecordDate())
                        .attentionTime(rEntity.getAttentionTime()).blinkTime(rEntity.getBlinkTime())
                        .nearTime(rEntity.getNearTime()).faceTime(rEntity.getFaceTime()).endTime(rEntity.getEndTime())
                        .distractTime(rEntity.getDistractTime()).startTime(rEntity.getStartTime())
                        .streamingTime(rEntity.getStreamingTime()).userId(rEntity.getUserId())
                        .monthDate(rEntity.getMonthDate()).build();

        recordRepository.save(pEntity);
        res = 1;

        log.info(this.getClass().getName()+".insertDailyMemo End!");

        return res;
    }

    @Override
    public int recordDel(RecordDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".recordDel Start!");

        int res = 0;

        if (pDTO == null) {
            log.info("input dto is null");
            pDTO = new RecordDTO();
        }

        String userId = CmmUtil.nvl(pDTO.getUserId());

        recordRepository.deleteByUserId(userId);

        res = 1;

        log.info(this.getClass().getName() + ".recordDel End!");

        return res;
    }

    @Override
    public List<RecordDTO> getWcTextList(RecordDTO pDTO) throws Exception {

        log.info(this.getClass().getName()+"getWcTextList Start!");

        String userId = CmmUtil.nvl(pDTO.getUserId());
        String monthDate = CmmUtil.nvl(pDTO.getMonthDate());

        log.info("userId : " + userId);
        log.info("monthDate : " + monthDate);

        List<RecordEntity> rEntityList = recordRepository.findAllByUserIdAndMonthDate(userId, monthDate);

        if (rEntityList == null) {
            rEntityList = new ArrayList<RecordEntity>();
            log.info("result list is null");
        }

        List<RecordDTO> rList = new ObjectMapper().convertValue(rEntityList , new TypeReference<List<RecordDTO>>(){});

        log.info(this.getClass().getName()+"getWcTextList End!");

        return rList;
    }


}
