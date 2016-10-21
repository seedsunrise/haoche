package com.haoche.bos.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class BeanTemplateComponent implements ApplicationContextAware {

    private static ApplicationContext applicationContext;     //Spring上下文环境
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        BeanTemplateComponent.applicationContext = applicationContext;
    }

    public static Object getBean(String name) throws BeansException {
        return applicationContext.getBean(name);
    }

}
