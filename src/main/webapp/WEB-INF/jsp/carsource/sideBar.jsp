<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<c:if test="${newUrl != null}">
	<div class="SideBarInner SideMenu">
	<c:if test='${CurrentUser.check(newUrl)}'>
		<a class="SideBarBtn" href="${newUrl}">${newName}</a>
	</c:if>
	</div>
</c:if>


<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">车源</div>
	<c:if test="${CurrentUser.check('/carSource/list')}">
	<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('库存车源')}">SideBarOn</c:if>" href="/carSource/list?status=1">库存车源</a>
	<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('已售出车源')}">SideBarOn</c:if>" href="/carSource/list?status=2">已售出车源</a>
	<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('已退车源')}">SideBarOn</c:if>" href="/carSource/list?status=3">已退车源</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">入库管理</div>
	<c:if test="${CurrentUser.check('/carInfoApply/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('车源入库申请')}">SideBarOn</c:if>" href="/carInfoApply/list">车源入库申请</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle ">车商管理</div>
	<c:if test="${CurrentUser.check('/system/business/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('车商')}">SideBarOn</c:if>"
		   href="/system/business/list">车商</a>
	</c:if>
	<c:if test="${CurrentUser.check('/system/business/accountList')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('车商帐号')}">SideBarOn</c:if>"
		   href="/system/business/accountList">车商帐号</a>
	</c:if>
</div>


