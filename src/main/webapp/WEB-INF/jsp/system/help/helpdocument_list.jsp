<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="帮助文档"></c:set>
<c:set var="navOn" value="系统设置"></c:set>
<c:set var="newName" value="新增帮助文档"></c:set>

<%@include file="../../lib/header.jsp"%>

<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/help/helpDocument/editPage"></c:set>

<c:set var="sidebarOn" value="帮助文档" ></c:set>
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
					帮助文档
				</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/help/helpDocument/list" novalidate>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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
					<th>帮助文档编号</th>
					<th>文档标题</th>
					<th>文档标签</th>
					<th>所属二级标题</th>
					<th>作者</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="document">
					<tr>
						<td>${document.id}</td>
						<td>${document.title}</td>
						<td>${document.label}</td>
						<td>${document.secondLevelMenuName}</td>
						<td>${document.authorName}</td>
						<td class="TDAction">
							<a href="/help/helpDocument/editPage?documentId=${document.id}" class="ListBtn">编辑</a>
							<c:choose>
								<c:when test="${document.disable}">
									<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="启用成功"
									   data-confirm="你确定要启用这个标题？" data-pending="启用"
									   data-url="/help/helpDocument/disable?documentId=${document.id}&disable=false">启用</a>
								</c:when>
								<c:otherwise>
									<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="禁用成功"
									   data-confirm="你确定要禁用这个标题？" data-pending="禁用"
									   data-url="/help/helpDocument/disable?documentId=${document.id}&disable=true">禁用</a>
								</c:otherwise>
							</c:choose>
							<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
							   data-confirm="你确定要删除这个标题？" data-pending="删除"
							   data-url="/help/helpDocument/delete?documentId=${document.id}">删除</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/help/helpDocument/list?search=${map.search}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
