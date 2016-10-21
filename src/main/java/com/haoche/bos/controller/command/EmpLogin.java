package com.haoche.bos.controller.command;

import org.hibernate.validator.constraints.NotEmpty;

public class EmpLogin {

    @NotEmpty(message = "手机号码不能为空")
    private String mobile;

    @NotEmpty(message = "密码不能为空")
    private String password;

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
