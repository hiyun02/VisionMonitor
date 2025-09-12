package khy.springjpa.service.impl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import khy.springjpa.dto.EventDTO;
import khy.springjpa.dto.RecordDTO;
import khy.springjpa.repository.EventRepository;
import khy.springjpa.repository.entity.EventEntity;
import khy.springjpa.service.IEventService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service("EventService")
public class EventService implements IEventService {

    private EventRepository eventRepository;

    public EventService(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    @Override
    public List<EventDTO> getEventList(String userId) throws Exception {

        log.info("userId : " + userId);

        List<EventEntity> rEntityList = eventRepository.findAllByUserId(userId);

        if (rEntityList == null) {
            rEntityList = new ArrayList<>();
        }

        List<EventDTO> rList = new ObjectMapper().convertValue(rEntityList , new TypeReference<List<EventDTO>>(){});

        return rList;
    }

    @Override
    public void insertEvent(EventDTO pDTO) throws Exception {

        EventEntity eventEntity = EventEntity.builder()
                .userId(pDTO.getUserId()).eventStart(pDTO.getEventStart())
                .eventEnd(pDTO.getEventEnd()).eventTitle(pDTO.getEventTitle())
                .build();

        eventRepository.save(eventEntity);
    }
}
