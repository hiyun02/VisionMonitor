package khy.springjpa.service;

import khy.springjpa.dto.RecordDTO;

import java.util.List;

public interface IRecordService {

    //저장. 달마다 다른 컬렉션에 저장, 3개월 이전의 컬렉션은 자동 삭제함
    int insertRecord(RecordDTO pDTO) throws Exception;

    //조회
    List<RecordDTO> getRecordList(RecordDTO pDTO) throws Exception;

    //상세조회
    RecordDTO getDailyRecord(RecordDTO pDTO) throws Exception;

    //ocr메모 추가
    int insertDailyMemo(RecordDTO pDTO) throws Exception;

    int recordDel(RecordDTO pDTO) throws Exception;

    //wc
    List<RecordDTO> getWcTextList(RecordDTO pDTO) throws Exception;
}
