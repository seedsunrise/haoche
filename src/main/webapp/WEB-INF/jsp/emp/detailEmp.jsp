<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="个人资料"></c:set>
<%@include file="../lib/header.jsp"%>
<%--<c:set var="navOn" value="员工管理"></c:set>--%>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="个人资料" ></c:set>

<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar1.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
            <ul class="BreadCrumb">
                <li><span>个人设置</span> <i class="fa fa-angle-right"></i></li>
                <li><span>个人资料</span> <i class="fa fa-angle-right"></i></li>
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
                    <input type=button  class="Btn BtnPrimary FormBtnSubmit" onclick="window.location.href=('/emp/edit?workStatus=0&id=${map.emp.id}&from=1')" value="修改个人资料"/>
                </div>

            </div>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>
