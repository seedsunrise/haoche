<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="部门"></c:set>
<%@include file="../lib/header.jsp" %>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp" %>

<c:set var="sidebarOn" value="部门"></c:set>
<c:set var="newUrl" value="/dept/edit"></c:set>
<c:set var="newName" value="新增部门"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../emp/sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
				<li><span>部门/职位管理 </span> <i class="fa fa-angle-right"></i></li>
				<li><span>部门列表</span></li>
			</ul>
			<table border="1" class="Table">
				<tr class="THead">
					<th>部门编号</th>
					<th>部门名称</th>
					<th>部门经理</th>
					<th>当前部门人数</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${page.list}" var="department">
					<tr>
						<td>${department.id}</td>
						<td>${department.departmentName}</td>
						<td>${department.managerName}</td>
						<td>${department.sumEmp}</td>
						<td class="TDAction">
							<c:if test='${CurrentUser.check("/dept/detail")}'>
								<a href="/dept/detail?departmentId=${department.id}" class="ListBtn">详情</a>
							</c:if>
							<c:if test='${CurrentUser.check("/dept/edit")}'>
								<a href="/dept/edit?departmentId=${department.id}" class="ListBtn">编辑</a>
							</c:if>
							<c:if test="${CurrentUser.check('/dept/delete')}">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/dept/delete?id=${department.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${page}"></c:set>
			<c:set var="pageUrl" value="/dept/list"></c:set>
			<%@include file="../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp" %>
