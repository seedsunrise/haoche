package com.haoche.bos.datamapper;


public class ActionDto {

    private Long id;
    private String actionName;
    private String actionValue;
    private int actionType;
    private int actionColumn;
    private String methodType;

    private int isSelect;

    public int getIsSelect() {
        return isSelect;
    }

    public void setIsSelect(int isSelect) {
        this.isSelect = isSelect;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getActionName() {
        return actionName;
    }

    public void setActionName(String actionName) {
        this.actionName = actionName;
    }

    public String getActionValue() {
        return actionValue;
    }

    public void setActionValue(String actionValue) {
        this.actionValue = actionValue;
    }

    public int getActionType() {
        return actionType;
    }

    public void setActionType(int actionType) {
        this.actionType = actionType;
    }

    public int getActionColumn() {
        return actionColumn;
    }

    public void setActionColumn(int actionColumn) {
        this.actionColumn = actionColumn;
    }

    public String getMethodType() {
        return methodType;
    }

    public void setMethodType(String methodType) {
        this.methodType = methodType;
    }

    @Override
    public String toString() {
        return "ActionDto{" +
                "id=" + id +
                ", actionName='" + actionName + '\'' +
                ", actionValue='" + actionValue + '\'' +
                ", actionType=" + actionType +
                ", actionColumn=" + actionColumn +
                ", methodType='" + methodType + '\'' +
                ", isSelect=" + isSelect +
                '}';
    }
}
