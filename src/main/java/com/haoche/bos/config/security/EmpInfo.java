package com.haoche.bos.config.security;


import com.haoche.remoting.dto.ActionDTO;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class EmpInfo implements Serializable {

    private static final long serialVersionUID = 6106476071456641909L;
    private Long id;
    private String realName;
    private int empIdentity;
    private Long departmentId;
    private String departmentName;
    private Long positionId;
    private String positionName;
    private String mobile;
    private String username;
    private Integer workStatus;
    private Long baseCityId;
    private String baseCityName;
    private String wxTeamOpenId;
    private Date createdAt;

    private List<ActionDTO> actionDTOs;

    public List<ActionDTO> getActionDTOs() {
        return actionDTOs;
    }

    public void setActionDTOs(List<ActionDTO> actionDTOs) {
        this.actionDTOs = actionDTOs;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public int getEmpIdentity() {
        return empIdentity;
    }

    public void setEmpIdentity(int empIdentity) {
        this.empIdentity = empIdentity;
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

    public Integer getWorkStatus() {
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

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
