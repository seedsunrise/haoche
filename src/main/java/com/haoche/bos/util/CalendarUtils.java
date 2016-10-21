package com.haoche.bos.util;

import java.util.Calendar;
import java.util.Date;

public class CalendarUtils {

    public static Integer getYear() {
        Calendar cal = Calendar.getInstance();
        return cal.get(Calendar.YEAR);
    }

    public static Integer getShortYear(){
        return getYear()%100;
    }

    /**
     * 将日期设为一天的开始，即00时00分00秒
     * @param date
     * @return
     */
    public static Date dayStart(Date date){
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY,0);
        cal.set(Calendar.MINUTE,0);
        cal.set(Calendar.SECOND,0);
        cal.set(Calendar.MILLISECOND,0);
        return cal.getTime();
    }

    /**
     * 将日期设为一天的结束，即23时59分59秒
     * @param date
     * @return
     */
    public static Date dayEnd(Date date){
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY,23);
        cal.set(Calendar.MINUTE,59);
        cal.set(Calendar.SECOND,59);
        cal.set(Calendar.MILLISECOND,999);
        return cal.getTime();
    }

    /**
     * 返回目标日期前指定天数的日期
     * @param dateTarget 目标日期
     * @param days 天数
     * @return
     */
    public static Date beforeOfDays(Date dateTarget, int days){
        Calendar c = Calendar.getInstance();
        c.setTime(dateTarget);
        c.add(Calendar.DAY_OF_MONTH,-days);
        return c.getTime();
    }
}
