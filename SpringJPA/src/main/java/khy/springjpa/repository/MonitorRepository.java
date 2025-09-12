package khy.springjpa.repository;

import khy.springjpa.repository.entity.MonitorEntity;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MonitorRepository extends MongoRepository<MonitorEntity, String> {

    //저장 및 수정 -> save

    //모니터링 시작 전 사용자 모니터링 값 가져오기
    MonitorEntity findByUserId(String userId);

    //탈퇴 시 삭제하는 로직
    void deleteByUserId(String userId);

}
