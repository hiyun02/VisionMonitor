package khy.springjpa.repository;

import khy.springjpa.dto.EventDTO;
import khy.springjpa.repository.entity.EventEntity;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EventRepository extends MongoRepository<EventEntity, String> {


    List<EventEntity> findAllByUserId(String userId);

}


