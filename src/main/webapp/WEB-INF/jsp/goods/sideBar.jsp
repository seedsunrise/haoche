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
	<div class="SideSubTitle">商品管理</div>
	<c:if test='${CurrentUser.check("/carGoods/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('上架中的商品')}">SideBarOn</c:if>" href="/carGoods/list?status=20">上架中的商品</a>
	</c:if>
	<c:if test='${CurrentUser.check("/carGoods/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('全部商品')}">SideBarOn</c:if>" href="/carGoods/list">全部商品</a>
	</c:if>
</div>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">车险管理</div>
	<c:if test='${CurrentUser.check("/carInsurance/list")}'>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('商品/车险列表')}">SideBarOn</c:if>" href="/carInsurance/list">商品/车险列表</a>
	</c:if>
</div>
