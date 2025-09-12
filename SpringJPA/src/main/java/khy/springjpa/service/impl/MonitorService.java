package khy.springjpa.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import khy.springjpa.dto.MonitorDTO;

import khy.springjpa.repository.MonitorRepository;
import khy.springjpa.repository.entity.MonitorEntity;
import khy.springjpa.service.IMonitorService;
import khy.springjpa.util.CmmUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service("MonitorService")
public class MonitorService implements IMonitorService {

    private final MonitorRepository monitorRepository;

    @Override
    public int insertMonitorInfo(MonitorDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".insertMonitorInfo Start!");

        int res = 0;

        try {

            if (pDTO == null) {
                log.info("input DTO is null");
                pDTO = new MonitorDTO();
            }

            String userId = CmmUtil.nvl(pDTO.getUserId());
            log.info("userId : "+userId);

            MonitorEntity pEntity = MonitorEntity.builder()
                    .userId(userId).build();

            monitorRepository.save(pEntity);

            res = 1;

        } catch (Exception e) {

            log.info("query failed");

            log.info(e.toString());

        } finally {

            log.info(this.getClass().getName() + ".insertMonitorInfo End!");

        }

        return res;
    }

    @Override
    public int updateMonitorInfo(MonitorDTO pDTO) throws Exception {

        log.info(this.getClass().getName()+"updateMonitorInfo Start!");

        int res = 0;

        try {
            if (pDTO == null) {
                log.info("input dto is null");
                pDTO = new MonitorDTO();
            }

            String userId = CmmUtil.nvl(pDTO.getUserId());


            MonitorEntity rEntity = monitorRepository.findByUserId(userId);

            //userID를 기반으로 사용자의 monitor정보 도큐먼트를 가져옴
            MonitorDTO monitorDTO = new ObjectMapper().convertValue(rEntity, MonitorDTO.class);

            String distance_check = CmmUtil.nvl(pDTO.getDistanceCheck(),CmmUtil.nvl(monitorDTO.getDistanceCheck()));
            String blink_check = CmmUtil.nvl(pDTO.getBlinkCheck(), CmmUtil.nvl(monitorDTO.getBlinkCheck()));
            String sleepCheckTime = CmmUtil.nvl(pDTO.getSleepCheckTime(), CmmUtil.nvl(monitorDTO.getSleepCheckTime()));
            String nearCheckTime = CmmUtil.nvl(pDTO.getNearCheckTime(), CmmUtil.nvl(monitorDTO.getNearCheckTime()));
            String restTerm = CmmUtil.nvl(pDTO.getRestTerm(), CmmUtil.nvl(monitorDTO.getRestTerm()));
            String restTime = CmmUtil.nvl(pDTO.getRestTime(), CmmUtil.nvl(monitorDTO.getRestTime()));
            String mSleep = CmmUtil.nvl(pDTO.getMSleep(), CmmUtil.nvl(monitorDTO.getMSleep()));
            String mNear = CmmUtil.nvl(pDTO.getMNear(), CmmUtil.nvl(monitorDTO.getMNear()));
            String mRestStart = CmmUtil.nvl(pDTO.getMRestStart(), CmmUtil.nvl(monitorDTO.getMRestStart()));
            String mRestEnd = CmmUtil.nvl(pDTO.getMRestEnd(), CmmUtil.nvl(monitorDTO.getMRestEnd()));

            log.info("userId : " + userId);
            log.info("distance_check : " + distance_check);
            log.info("blink_check : " + blink_check);
            log.info("sleepCheckTime : " + sleepCheckTime);
            log.info("nearCheckTime : " + nearCheckTime);
            log.info("restTerm : " + restTerm);
            log.info("restTime : " + restTime);
            log.info("mSleep : " + mSleep);
            log.info("mNear : " + mNear);
            log.info("mRestStart : " + mRestStart);
            log.info("mRestEnd : " + mRestEnd);

            String monitorSeq = monitorDTO.getMonitorSeq();

            if (distance_check.length() == 0) {
                distance_check = monitorDTO.getDistanceCheck();
                log.info("bring before saved value");
            }
            if (blink_check.length() == 0) {
                blink_check = monitorDTO.getBlinkCheck();
                log.info("bring before saved value");
            }
            if (sleepCheckTime.length() == 0) {
                sleepCheckTime = monitorDTO.getSleepCheckTime();
                log.info("bring before saved value");
            }
            if (nearCheckTime.length() == 0) {
                nearCheckTime = monitorDTO.getNearCheckTime();
                log.info("bring before saved value");
            }
            if (restTerm.length() == 0) {
                restTerm = monitorDTO.getRestTerm();
                log.info("bring before saved value");
            }
            if (restTime.length() == 0) {
                restTime = monitorDTO.getRestTime();
                log.info("bring before saved value");
            }
            if (mSleep.length() == 0) {
                mSleep = monitorDTO.getMSleep();
                log.info("bring before saved value");
            }
            if (mNear.length() == 0) {
                mNear = monitorDTO.getMNear();
                log.info("bring before saved value");
            }
            if (mRestStart.length() == 0) {
                mRestStart = monitorDTO.getMRestStart();
                log.info("bring before saved value");
            }
            if (mRestEnd.length() == 0) {
                mRestEnd = monitorDTO.getMRestEnd();
                log.info("bring before saved value");
            }

            MonitorEntity pEntity = MonitorEntity.builder()
                    .monitorSeq(monitorSeq).userId(userId)
                    .distanceCheck(distance_check).blinkCheck(blink_check)
                    .sleepCheckTime(sleepCheckTime).nearCheckTime(nearCheckTime)
                    .restTerm(restTerm).restTime(restTime).mSleep(mSleep).mNear(mNear)
                    .mRestStart(mRestStart).mRestEnd(mRestEnd).build();

            monitorRepository.save(pEntity);

            res = 1;

        } catch (Exception e) {
            log.info(e.toString());
        }

        log.info(this.getClass().getName()+"updateMonitorInfo Start!");

        return res;
    }

    @Override
    public MonitorDTO getMonitorInfo(MonitorDTO pDTO) throws Exception {
        log.info(this.getClass().getName()+".getMonitorInfo Start!");

        String userId = CmmUtil.nvl(pDTO.getUserId());

        log.info("userId : "+userId);

        MonitorEntity rEntity = monitorRepository.findByUserId(userId);

        if (rEntity == null) {
            rEntity = new MonitorEntity();
        }

        MonitorDTO rDTO = new ObjectMapper().convertValue(rEntity, MonitorDTO.class);

        log.info(this.getClass().getName()+".getMonitorInfo End!");

        return rDTO;
    }

    @Override
    public int monitorDel(MonitorDTO pDTO) throws Exception {
        log.info(this.getClass().getName() + ".monitorDel Start!");

        int res = 0;

        if (pDTO == null) {
            log.info("input DTO is null");
            pDTO = new MonitorDTO();
        }

        String userId = CmmUtil.nvl(pDTO.getUserId());

        try {

            monitorRepository.deleteByUserId(userId);

            res = 1;

        } catch (Exception e) {

            log.info("query failed");

            log.info(e.toString());

        } finally {

            log.info(this.getClass().getName() + ".monitorDel End!");

        }

        return res;
    }
}
