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
	<div class="SideSubTitle">员工管理</div>
	<c:if test='${CurrentUser.check("/emp/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('在职员工')}">SideBarOn</c:if>" href="/emp/list?workStatus=0">在职员工</a>
	</c:if>
	<c:if test='${CurrentUser.check("/emp/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('全部员工')}">SideBarOn</c:if>" href="/emp/list">全部员工</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">部门/职位管理</div>
	<c:if test="${CurrentUser.check('/dept/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('部门')}">SideBarOn</c:if>" href="/dept/list">部门</a>
		<%--<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('职位')}">SideBarOn</c:if>">职位</a>--%>
	</c:if>
	<c:if test="${CurrentUser.check('/emp/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('职位')}">SideBarOn</c:if>" href="/emp/position/list">职位</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">角色管理</div>
	<c:if test='${CurrentUser.check("/permissions/groupList")}'>
		<a href="/permissions/groupList" class="SideBarMainTitle <c:if test="${sidebarOn.equals('角色')}">SideBarOn</c:if>">角色</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">权限管理</div>
	<c:if test='${CurrentUser.check("/permissions/actionList")}'>
		<a href="/permissions/actionList" class="SideBarMainTitle <c:if test="${sidebarOn.equals('业务运营系统权限')}">SideBarOn</c:if>">业务运营系统权限</a>
	</c:if>
	<%--<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('Q端APP权限')}">SideBarOn</c:if>">Q端APP权限</a>--%>
</div>
