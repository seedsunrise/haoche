package com.haoche.bos.config.binder;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;
import org.springframework.web.context.request.WebRequest;

import java.text.SimpleDateFormat;
import java.util.Date;


public class BindConverter implements WebBindingInitializer {

    @Override
    public void initBinder(WebDataBinder webDataBinder, WebRequest webRequest) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy年MM月dd");
        System.err.println("date binder");
        webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(df,
                false));
    }
}
