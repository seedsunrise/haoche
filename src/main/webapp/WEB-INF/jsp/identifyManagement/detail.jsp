<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="鉴定详情"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="品质整备"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="品质整备管理" ></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <input type="hidden" value="${map.carInfo.id}" id="CarId">
        <input type="hidden" value="${map.carVin}" id="CarVin">
        <input type="hidden" value="${map.identifyType}" id="IdentifyType">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="#">品质整备</a> <i class="fa fa-angle-right"></i></li>
                <li><span>鉴定整备管理</span></li>
                <li><span>鉴定详情</span></li>
            </ul>
            <ul class="GroupList ClearFix">
                <input type="hidden" value="${map.identifyType}" id="IdentifyType">
                <c:if test="${map.identifyType == 1}">
                    <li class="OnGroupList" data-url="/identifyManagement/getCarInfoTplById?id=${map.carInfo.id}">车辆信息</li>
                </c:if>
                <c:forEach var="group" items="${map.groupList}">
                    <li data-url="/identifyManagement/findCheckByGroupId?groupId=${group.id}&identifyType=${map.identifyType}">${group.name}</li>
                </c:forEach>
            </ul>
            <div class="DetailWrapper">
                <%@include file="carInfoTpl.jsp"%>
            </div>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp"%>