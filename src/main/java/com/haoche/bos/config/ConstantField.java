package com.haoche.bos.config;


public class ConstantField {

    public static final String HMAC_SHA1 = "HmacSHA1";

    public static final int SESSION_TIME_OUT = 10 * 24 * 60 * 60;

    // 风控同意放款
    public static final int AGREE_RISK_ESTIMATE_RESULT = 1;

    // 风控不同意放款
    public static final int DISAGREE_RISK_ESTIMATE_RESULT = 2;

    public static final String SALT = "haoche";

    public static final String PUSH_KEY = "qiankunhaoche";

    public static final String PUSH_URL = "https://api.jpush.cn/v3/push/validate";

    public static final String APP_KEY = "e4db5db65c4b348df8e8998a";

    public static final String MASTER_SECRET = "b8dbab3b6167464cc4fb7912";

    public static final String SEND_SMS_URL = "http://hy6.nbark.com:7602/sms.aspx?userid=363&account=fzqiankunhchy6&password=goodcar2015bruce&sendTime=&extno=&action=send";

    public static final String DESCRIBE = "经过224项鉴定";
}
