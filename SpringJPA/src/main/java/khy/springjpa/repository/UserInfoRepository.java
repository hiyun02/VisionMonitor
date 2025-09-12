package khy.springjpa.repository;

import khy.springjpa.repository.entity.UserInfoEntity;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserInfoRepository extends MongoRepository<UserInfoEntity, String> {

    //아이디 중복 여부 체크
    Optional<UserInfoEntity> findByUserId(String userId);

    //아이디로 이메일 찾기
    UserInfoEntity findUserEmailByUserId(String userId);

    //이메일 중복 여부 체크
    Optional<UserInfoEntity> findByUserEmail(String userEmail);

    //이메일로 아이디 찾기
    UserInfoEntity findUserIdByUserEmail(String userEmail);

    //로그인
    Optional<UserInfoEntity> findByUserIdAndUserPw(String userId, String userPw);

}
