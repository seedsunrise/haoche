<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="保养、美容、精品加装设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/extraItem/edit"></c:set>
<c:set var="newName" value="新增项目"></c:set>
<c:set var="sidebarOn" value="项目列表"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>保养、美容、精品加装设置</span> <i class="fa fa-angle-right"></i></li>
				<li><span>项目列表</span></li>
			</ul>
			<table border="1" class="Table">
				<tr class="THead">
					<th>编号</th>
					<th>项目名称</th>
					<th>隶属类别</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="item">
					<tr>
						<td>${item.id}</td>
						<td>${item.name}</td>
						<td>${item.type.text}</td>
						<td class="TDAction">
							<c:if test="${CurrentUser.check('/extraItem/edit')}">
								<a href="/extraItem/edit?id=${item.id}" class="ListBtn">编辑</a>
							</c:if>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/extraItem/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/extraItem/delete?id=${item.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/extraItem/list}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
