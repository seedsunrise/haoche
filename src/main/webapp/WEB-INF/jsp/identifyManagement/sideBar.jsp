<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">品质整备</div>
	<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('品质整备管理')}">SideBarOn</c:if>" href="/identifyManagement/list?identifyType=1">品质整备管理</a>
</div>