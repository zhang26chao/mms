package blog;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 15-8-2
 * Time: 下午5:49
 * To change this template use File | Settings | File Templates.
 */
public class DateUtil {

    public static final String DATE_FORMAT_FULL_NORMAL = "yyyy-MM-dd HH:mm:ss";

    public static final String DATE_FORMAT_FULL_SHORT = "yyyyMMddHHmmss";

    public static final String DATE_FORMAT_DATE_NORMAL = "yyyy-MM-dd";

    public static Date add(int field, Date date, int add) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(field, add);
        return calendar.getTime();
    }

    public static Date addDate(Date date, int add) {
        return add(Calendar.DAY_OF_MONTH, date, add);
    }

    public static Date addMonth(Date date, int add) {
        return add(Calendar.MONTH, date, add);
    }

    public static Date addYear(Date date, int add) {
        return add(Calendar.YEAR, date, add);
    }

    public static String dateToStr(Date date, String pattern) {
        DateFormat format = new SimpleDateFormat(pattern);
        return format.format(date);
    }

    public static Date strToDate(String date, String pattern) {
        DateFormat format = new SimpleDateFormat(pattern);
        try {
            return format.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Date getCurMonthFirstDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        return calendar.getTime();
    }

}
