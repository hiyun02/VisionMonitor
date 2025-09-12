package khy.springjpa.repository;

import khy.springjpa.repository.entity.RecordEntity;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecordRepository extends MongoRepository<RecordEntity, String> {

    //기록정보 저장 -> save

    //기록정보 조회
    List<RecordEntity> findAllByUserIdOrderByRecordSeqDesc(String userId);

    //기록정보 상세조회


    //탈퇴 시 기록 정보 삭제하는 로직
    void deleteByUserId(String userId);

    //월별 wc Text
    List<RecordEntity> findAllByUserIdAndMonthDate(String userId, String monthDate);


}
