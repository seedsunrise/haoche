<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="帮助中心"></c:set>
<c:set var="navOn" value="帮助中心"></c:set>

<%@include file="../../lib/header.jsp"%>

<%@include file="../../lib/nav.jsp"%>

<c:set var="sidebarFirstLevelMenuOn" value="${map.document.firstLevelMenuId}"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/index">首页</a> <i class="fa fa-angle-right"></i></li>
				<li><a href="/index">资料区</a> <i class="fa fa-angle-right"></i></li>
				<li><a href="/index/help/documentList?firstLevelMenuId=0">帮助中心</a> <i class="fa fa-angle-right"></i></li>
				<li><a href="/index/help/documentList?firstLevelMenuId=${map.document.firstLevelMenuId}&secondLevelMenuId=${map.document.secondLevelMenuId}">${map.document.secondLevelMenuName}</a><i class="fa fa-angle-right"></i></li>
				<li><span>${map.document.title}</span></li>
			</ul>
			<div class="ArticleWrapper ArticleContentWrapper">
				<div class="ArticleTitle">${map.document.title}</div>
				<div class="ArticleContent editor-style">
					${map.document.content}
				</div>

			</div>
		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>