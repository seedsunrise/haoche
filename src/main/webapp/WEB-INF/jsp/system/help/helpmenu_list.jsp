<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:choose>
	<c:when test="${map.level eq 1}">
		<c:set var="title" value="一级标题"></c:set>
		<c:set var="navOn" value="系统设置"></c:set>
		<c:set var="newName" value="新增一级标题"></c:set>
		<c:set var="sidebarOn" value="一级标题" ></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="title" value="二级标题"></c:set>
		<c:set var="navOn" value="系统设置"></c:set>
		<c:set var="newName" value="新增二级标题"></c:set>
		<c:set var="sidebarOn" value="二级标题" ></c:set>
	</c:otherwise>
</c:choose>

<%@include file="../../lib/header.jsp"%>
<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/help/helpMenu/editPage?level=${map.level}"></c:set>

<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>帮助中心</span> <i class="fa fa-angle-right"></i></li>
				<li><span>
					<c:choose>
						<c:when test="${map.level eq 1}">一级标题</c:when>
						<c:otherwise>二级标题</c:otherwise>
					</c:choose>
				</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/help/helpMenu/list" novalidate>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<input type="hidden" name="level" value="${map.level}"/>
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" type="text" name="search" value="${map.search}" placeholder="标题名称"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>

			<table border="1" class="Table">
				<tr class="THead">
					<th>
						<c:choose>
							<c:when test="${map.level eq 1}">一级标题号</c:when>
							<c:otherwise>二级标题号</c:otherwise>
						</c:choose>
					</th>
					<th>标题名称</th>
					<c:if test="${map.level eq 2}"><th>所属一级标题</th></c:if>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="menu">
					<tr>
						<td>${menu.id}</td>
						<td>${menu.name}</td>
						<c:if test="${map.level eq 2}"><td>${menu.parentName}</td></c:if>
						<td class="TDAction">
							<a href="/help/helpMenu/editPage?level=${map.level}&menuId=${menu.id}" class="ListBtn">编辑</a>
							<c:choose>
								<c:when test="${menu.disable}">
									<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="启用成功"
									   data-confirm="你确定要启用这个标题？" data-pending="启用"
									   data-url="/help/helpMenu/disable?menuId=${menu.id}&disable=false&level=${map.level}">启用</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="禁用成功"
									   data-confirm="你确定要禁用这个标题？" data-pending="禁用"
									   data-url="/help/helpMenu/disable?menuId=${menu.id}&disable=true&level=${map.level}">禁用</a>
								</c:otherwise>
							</c:choose>
							<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
							   data-confirm="你确定要删除这个标题？" data-pending="删除"
							   data-url="/help/helpMenu/delete?menuId=${menu.id}&level=${map.level}">删除</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/help/helpMenu/list?level=${map.level}&search=${map.search}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
