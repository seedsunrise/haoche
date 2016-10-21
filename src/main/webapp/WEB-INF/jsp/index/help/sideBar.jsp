<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">帮助中心</div>
	<c:forEach items="${map.firstLevelMenuList}" var="helpMenu">
		<a class='SideBarMainTitle <c:if test="${sidebarFirstLevelMenuOn eq helpMenu.id}">SideBarOn</c:if>' href="/index/help/documentList?firstLevelMenuId=${helpMenu.id}">${helpMenu.name}</a>
	</c:forEach>
</div>