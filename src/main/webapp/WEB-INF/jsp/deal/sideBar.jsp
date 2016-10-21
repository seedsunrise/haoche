<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">交付管理</div>
		<a class="SideBarMainTitle 	<c:if test="${sidebarOn.equals('待完成订单')}">SideBarOn</c:if>"
		   	href="/deal/list?carAction=1">待完成订单</a>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('已提车订单')}">SideBarOn</c:if>"
		   href="/deal/list?carAction=2">已提车订单</a>
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('全部订单')}">SideBarOn</c:if>"
		   href="/deal/list?carAction=0">全部订单</a>
</div>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">车险订单管理</div>
	<a class="SideBarMainTitle 	<c:if test="${sidebarOn.equals('全部车险订单')}">SideBarOn</c:if>"
	   href="/carInsurance/payList">全部车险订单</a>
</div>
