package com.haoche.bos.config.binder;

import org.springframework.core.convert.converter.Converter;
import org.springframework.util.StringUtils;


public class StringToLong implements Converter<String,Long> {
    @Override
    public Long convert(String s) {
        System.err.println("long binder");
        if (StringUtils.isEmpty(s)) {
            return 0L;
        } else {
            return Long.parseLong(s);
        }
    }
}
