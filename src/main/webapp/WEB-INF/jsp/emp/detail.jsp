<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="员工详情"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp"%>

<%--<c:set var="sidebarOn" value="在职员工" ></c:set>--%>

<c:if test="${map.workStatus == 0}">
    <c:set var="newUrl" value="/emp/edit?workStatus=0"></c:set>
</c:if>
<c:if test="${map.workStatus != 0}">
    <c:set var="newUrl" value="/emp/edit"></c:set>
</c:if>
<c:set var="newName" value="新增员工"></c:set>

<c:if test="${map.workStatus == 0}">
    <c:set var="sidebarOn" value="在职员工" ></c:set>
</c:if>
<c:if test="${map.workStatus != 0}">
    <c:set var="sidebarOn" value="全部员工" ></c:set>
</c:if>

<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
                <li><span>员工管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>${map.emp.realName}详情</span></li>
            </ul>
            <div class="DetailWrapper">
                <div class="ShowGroupWrapper">
                    <div class="ShowTitle">员工基本信息</div>
                    <ul class="ClearFix ShowGroup">
                        <li>
                            <label>员工中文姓名：</label>
                            <span>${map.emp.realName}</span>
                        </li>
                        <li>
                            <label>员工英文姓名：</label>
                            <span>${map.emp.username}</span>
                        </li>
                        <li>
                            <label>所在城市：</label>
                            <span>${map.emp.baseCityName}</span>
                        </li>
                        <li>
                            <label>所属部门：</label>
                            <span>${map.emp.departmentName}</span>
                        </li>
                        <li>
                            <label>岗位：</label>
                            <span>${map.emp.positionName}</span>
                        </li>
                        <li>
                            <label>创建日期：</label>
                            <span class="FormatDate">${map.emp.createdAt}</span>
                        </li>
                    </ul>
                </div>
                <div class="ShowGroupWrapper">
                    <div class="ShowTitle">员工账号信息</div>
                    <ul class="ClearFix ShowGroup">
                        <li>
                            <label>账号：</label>
                            <span>${map.emp.username}</span>
                        </li>
                        <li>
                            <label>手机号：</label>
                            <span>${map.emp.mobile}</span>
                        </li>
                        <li>
                            <label>微信OpenId：</label>
                        <span>
							<c:if test="${map.emp.wxTeamOpenId}">${map.emp.wxTeamOpenId}</c:if>
							<c:if test="${!map.emp.wxTeamOpenId}">暂无</c:if>
                        </span>
                        </li>
                    </ul>
                </div>
                <div class="ShowGroupWrapper">
                    <div class="ShowTitle">员工状态</div>
                    <ul class="ShowGroup">
                        <li>
                            <label>状态：</label>
                        <span>
							<c:if test="${map.emp.workStatus==0}">在职</c:if>
							<c:if test="${map.emp.workStatus == 1}">离职</c:if>
                        </span>
                        </li>
                    </ul>
                </div>
                <div class="ActionArea ClearFix">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <c:if test="${map.emp.workStatus==0}">
                        <c:if test='${CurrentUser.check("/emp/empQuit")}'>
                            <a href="javascript:;" class="Btn BtnDanger SetStatus AjaxBtn" data-msg="设置成功" data-pending="设置中..." data-url="/emp/empQuit?empId=${map.emp.id}">设置为离职员工</a>
                        </c:if>
                    </c:if>
                </div>

            </div>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>
