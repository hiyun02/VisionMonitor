package khy.springjpa.service;

import khy.springjpa.dto.EventDTO;

import java.util.List;

public interface IEventService {

    List<EventDTO> getEventList(String userId) throws Exception;

    void insertEvent(EventDTO pDTO) throws Exception;
}
