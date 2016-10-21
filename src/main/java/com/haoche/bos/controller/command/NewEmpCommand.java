package com.haoche.bos.controller.command;

import org.hibernate.validator.constraints.NotEmpty;

public class NewEmpCommand {

    private Long id;

    // 用户真实姓名
    @NotEmpty
    private String realName;

    // 部门id
    private Long departmentId;

    // 部门名称
    private String departmentName;

    // 手机号码
    private String mobile;

    // 用户名
    private String username;

    // 密码
    private String password;

    // 重复密码
    private String repwd;

    // 是否在职
    private Integer workStatus;

    // 所在城市id
    private Long baseCityId;

    // 所在城市名称
    private String baseCityName;

    // 微信openid
    private String wxTeamOpenId;

    // 职位id
    private Long positionId;

    // 职位名称
    private String positionName;

    private int checkCarNum;

    private String level;

    private String profile;

    private String levelCountry;

    public int getCheckCarNum() {
        return checkCarNum;
    }

    public void setCheckCarNum(int checkCarNum) {
        this.checkCarNum = checkCarNum;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getLevelCountry() {
        return levelCountry;
    }

    public void setLevelCountry(String levelCountry) {
        this.levelCountry = levelCountry;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRepwd() {
        return repwd;
    }

    public void setRepwd(String repwd) {
        this.repwd = repwd;
    }

    public Long getPositionId() {
        return positionId;
    }

    public void setPositionId(Long positionId) {
        this.positionId = positionId;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getWorkStatus() {
        if (workStatus == null) {
            return 0;
        }
        return workStatus;
    }

    public void setWorkStatus(Integer workStatus) {
        this.workStatus = workStatus;
    }

    public Long getBaseCityId() {
        return baseCityId;
    }

    public void setBaseCityId(Long baseCityId) {
        this.baseCityId = baseCityId;
    }

    public String getBaseCityName() {
        return baseCityName;
    }

    public void setBaseCityName(String baseCityName) {
        this.baseCityName = baseCityName;
    }

    public String getWxTeamOpenId() {
        return wxTeamOpenId;
    }

    public void setWxTeamOpenId(String wxTeamOpenId) {
        this.wxTeamOpenId = wxTeamOpenId;
    }
}
