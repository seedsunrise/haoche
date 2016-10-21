package com.haoche.bos.util;

import org.springframework.util.StringUtils;

public class AuthUtils {

	public static String getValue(String actionValue, String method) {
		
		if(StringUtils.isEmpty(method)) {
			return actionValue;
		}
		method = method.toLowerCase();
		if (StringUtils.isEmpty(actionValue)) {
			return "/"+method;
		} else {
			if (actionValue.endsWith("/")) {
				return actionValue+method;
			} else {
				return actionValue+"/"+method;
			}
		}
	}
}