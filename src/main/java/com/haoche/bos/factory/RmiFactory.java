package com.haoche.bos.factory;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ApplicationObjectSupport;
import org.springframework.stereotype.Component;

@Component
public class RmiFactory extends ApplicationObjectSupport {

    private static Logger logger = LogManager.getLogger(RmiFactory.class.getName());
    private Object getRmiService(String serviceName) {

        ApplicationContext ac = getApplicationContext();
        Object rmi = null;
        try {
            rmi = ac.getBean(serviceName);
        } catch (Exception e) {
            logger.error("Get the rmi service error! serviceName="+serviceName,e);
            throw new RuntimeException("Get the rmi service error! serviceName="+serviceName,e);
        }
        if (rmi==null) {
            logger.error("There is no Rmi servcie called "+serviceName);
            throw new RuntimeException("There is no Rmi servcie called "+serviceName);
        }
        return rmi;
    }

    public Object getProjectRmiService() {
        return getRmiService("projectInterface");
    }

    public Object getUserRmiService() {
        return getRmiService("userInterface");
    }

    public Object getRightRmiService() {
        return getRmiService("rightInterface");
    }

    public Object getOrderRmiService() {
        return getRmiService("orderInterface");
    }

    public Object getEmpRmiService() {
        return getRmiService("empInterface");
    }
}
