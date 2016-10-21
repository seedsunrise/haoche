<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="角色列表"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="角色" ></c:set>
<c:set var="newUrl" value="/permissions/edit"></c:set>
<c:set var="newName" value="新增角色"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../emp/sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
				<li><span>角色管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>角色</span></li>
			</ul>
			<table border="1" class="Table">
				<tr class="THead">
					<th>角色编号</th>
					<th>角色名称</th>
					<th>角色权限数量</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${page.list}" var="group">
					<tr>
						<td>${group.id}</td>
						<td>${group.groupName}</td>
						<td>${group.actions.size()}</td>
						<td class="TDAction">
							<c:if test='${CurrentUser.check("/permissions/detail")}'>
								<a href="/permissions/detail?id=${group.id}" class="ListBtn">详情</a>
							</c:if>
							<c:if test='${CurrentUser.check("/permissions/edit")}'>
								<a href="/permissions/edit?groupId=${group.id}" class="ListBtn">编辑</a>
							</c:if>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/permissions/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功" data-confirm="你确定要删除这条数据?" data-pending="删除" data-url="/permissions/delete?id=${group.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${page}"></c:set>
			<c:set var="pageUrl" value="/permissions/groupList"></c:set>
			<%@include file="../lib/pagination.jsp"%>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>
