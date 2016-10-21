<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<c:if test="${CurrentUser.check(newUrl)}">
	<c:if test="${newUrl eq '/userservice/project/edit'}">
		<div class="SideBarInner SideMenu">
			<a class="SideBarBtn" href="${newUrl}">${newName}</a>
		</div>
	</c:if>
	<c:if test="${newUrl eq '/carMaintain/project/edit'}">
		<div class="SideBarInner SideMenu">
			<a class="SideBarBtn" href="${newUrl}">${newName}</a>
		</div>
	</c:if>
	<c:if test="${newUrl eq '/user/userInfo/editPage'}">
		<div class="SideBarInner SideMenu">
			<a class="SideBarBtn" href="${newUrl}">${newName}</a>
		</div>
	</c:if>
</c:if>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">车主管理</div>
	<c:if test='${CurrentUser.check("/user/userInfo/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('车主概览')}">SideBarOn</c:if>" href="/user/userInfo/list">车主概览</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">车型油耗管理</div>
		<c:if test='${CurrentUser.check("/user/list")}'>
			<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('已设置')}">SideBarOn</c:if>" href="/user/list">已设置</a>
		</c:if>
		<c:if test='${CurrentUser.check("/user/notSetList")}'>
			<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('未设置')}">SideBarOn</c:if>" href="/user/notSetList">未设置</a>
		</c:if>
</div>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">车险续保</div>
	<c:if test='${CurrentUser.check("/carInsurance/renewalList")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('车险续保')}">SideBarOn</c:if>" href="/carInsurance/renewalList">车险续保</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">服务预约</div>
	<c:if test='${CurrentUser.check("/userservice/project/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('服务预约列表')}">SideBarOn</c:if>" href="/userservice/appointment/list">服务预约列表</a>
	</c:if>
	<%--<c:if test='${CurrentUser.check("/carMaintain/appointment/list")}'>--%>
		<%--<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('保养预约列表')}">SideBarOn</c:if>" href="/carMaintain/appointment/list?type=1">保养预约列表</a>--%>
	<%--</c:if>--%>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">设置</div>
	<c:if test='${CurrentUser.check("/userservice/project/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('服务预约项目设置')}">SideBarOn</c:if>" href="/userservice/project/list">服务预约项目设置</a>
	</c:if>
	<%--<c:if test='${CurrentUser.check("/carMaintain/project/list")}'>--%>
		<%--<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('保养预约项目设置')}">SideBarOn</c:if>" href="/carMaintain/project/list">保养预约项目设置</a>--%>
	<%--</c:if>--%>
</div>