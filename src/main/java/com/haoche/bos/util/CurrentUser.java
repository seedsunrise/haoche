package com.haoche.bos.util;

import com.haoche.bos.config.security.EmpInfo;
import com.haoche.remoting.dto.ActionDTO;
import org.springframework.security.core.context.SecurityContextHolder;

public class CurrentUser {
    public static EmpInfo get() {
        Object user = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return user instanceof EmpInfo ? (EmpInfo) user : null;
    }

    public static boolean check(String url) {
        for (ActionDTO actionDTO:get ().getActionDTOs()){
            url = url.split("\\?")[0];
            if (url.equals(actionDTO.getActionValue())) {
                return true;
            }
        }
        return false;
    }
}
