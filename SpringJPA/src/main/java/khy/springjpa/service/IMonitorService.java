package khy.springjpa.service;

import khy.springjpa.dto.MonitorDTO;

public interface IMonitorService {
    //새로 넘겨받은 / 입력받은 값으로 사용자 모니터링 값 저장
    int insertMonitorInfo(MonitorDTO pDTO) throws Exception;

    //새로 넘겨받은 / 입력받은 값으로 사용자 모니터링 값 업데이트
    int updateMonitorInfo(MonitorDTO pDTO) throws Exception;

    //모니터링 시작하기 전 사용자 모니터링 값 가져오기
    MonitorDTO getMonitorInfo(MonitorDTO pDTO) throws Exception;

    //탈퇴시 삭제
    int monitorDel(MonitorDTO pDTO) throws Exception;
}
