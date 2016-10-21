<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="帮助中心"></c:set>
<c:set var="navOn" value="首页"></c:set>

<%@include file="../../lib/header.jsp"%>

<%@include file="../../lib/nav.jsp"%>

<c:set var="sidebarOn" value="帮助中心" ></c:set>

<c:set var="sidebarFirstLevelMenuOn" value="${map.firstLevelMenuId}"></c:set>
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
				<li>
					<c:if test="${map.secondLevelMenuId eq 0}">
						<span>全部</span>
					</c:if>
					<c:forEach items="${map.secondLevelMenuList}" var="helpMenu">
						<c:if test="${map.secondLevelMenuId eq helpMenu.id}">
							<span>${helpMenu.name}</span>
						</c:if>
					</c:forEach>
				</li>
			</ul>
			<div class="ArticleWrapper">
				<ul class="LevelList ClearFix">
					<li class='<c:if test="${map.secondLevelMenuId eq 0}">OnSecondLevel</c:if>'><a href="/index/help/documentList?firstLevelMenuId=${map.firstLevelMenuId}" >全部</a></li>
					<c:forEach items="${map.secondLevelMenuList}" var="helpMenu">
                        <li class='<c:if test="${map.secondLevelMenuId eq helpMenu.id}">OnSecondLevel</c:if>'>
                            <a href="/index/help/documentList?firstLevelMenuId=${map.firstLevelMenuId}&secondLevelMenuId=${helpMenu.id}">${helpMenu.name}</a>
                        </li>
					</c:forEach>
				</ul>
                <div CLASS="Clear"></div>
				<ul class="ArticleList">
					<c:forEach items="${map.page.list}" var="document">
						<li><a href="/index/help/documentDetail?documentId=${document.id}">${document.title}</a></li>
					</c:forEach>
				</ul>
			</div>

			<%--<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/help/helpDocument/list?search=${map.search}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>--%>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
