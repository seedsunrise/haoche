package com.haoche.bos.util;

import com.haoche.bos.datamapper.Template;
import org.apache.commons.lang3.StringUtils;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

public class Helper {
    public static Template GetTemplateWithMap(String mapKey, String mapValue) {
        Template template = new Template();
        template.setData(new HashMap<String, String>().put(mapKey, mapValue));
        return template;
    }

    public static Object getFieldValueByName(String fieldName, Object o) {
        try {
            String firstLetter = fieldName.substring(0, 1).toUpperCase();
            String getter = "get" + firstLetter + fieldName.substring(1);
            Method method = o.getClass().getMethod(getter, new Class[] {});
            Object value = method.invoke(o, new Object[] {});
            return value;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static  String createUrl(Object dto) {
        StringBuilder param = new StringBuilder();
        Field[] fields = dto.getClass().getDeclaredFields();
        for (int i = 0; i < fields.length; i++) {
            if ("serialVersionUID".equals(fields[i].getName())) {
                continue;
            }
            Object value = Helper.getFieldValueByName(fields[i].getName(), dto);
            if (value != null) {
                if (i == 0) {
                    param.append(fields[i].getName() + "=" + value);
                } else {
                    param.append("&" + fields[i].getName() + "=" + value);
                }
            }
        }
        return param.toString();
    }

    public static Template getTemplateWithData(Object data) {
        Template template = new Template();
        template.setData(data);
        return template;
    }

    public static Template getSuccessTemplate(String message){
        Template template = new Template();
        template.setMsg(message);
        return template;
    }

    public static Template getFaildTemplate(String code, String message){
        Template template = new Template();
        template.setCode(code);
        template.setMsg(message);
        return template;

    }

    public static Date translateStrToDate(String str)throws ParseException{
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日 HH:mm");//小写的mm表示的是分钟
        Date date = null;
        if(StringUtils.isNotEmpty(str)){
            date=sdf.parse(str);
            return date;
        }
        return null;
    }
}