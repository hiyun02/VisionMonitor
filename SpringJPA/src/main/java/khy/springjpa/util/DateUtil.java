package khy.springjpa.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    /**
     * 날짜, 시간 출력하기
     *
     * @param fm 날짜 출력 형식
     * @return date
     */
    public static String getDateTime(String fm) {

        Date today = new Date();
        System.out.println(today);

        SimpleDateFormat date = new SimpleDateFormat(fm);

        return date.format(today);
    }

    /**
     * 날짜, 시간 출력하기
     *
     * @return 기본값은 년.월.일
     */
    public static String getDateTime() {
        return getDateTime("yyyy.MM.dd");

    }

    //date는 yyyyMM의 형식으로 들어옴
    public static String getMonthPastTime(String date, int num) {
        String answer = "";

        String year = date.substring(0, 4);
        String month = date.substring(4);

        int nMonth = Integer.parseInt(month) - num;

        if (nMonth < 1) {
            nMonth += 12;
            year = String.valueOf(Integer.parseInt(year)-1);
        }

        answer = year+String.format("%02d",nMonth);

        System.out.println(num+"개월 전의 연월 : "+answer);
        return answer;
    }
}
