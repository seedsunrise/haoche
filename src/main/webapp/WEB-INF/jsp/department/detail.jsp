<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="部门详情"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="部门" ></c:set>
<c:set var="newUrl" value="/dept/edit"></c:set>
<c:set var="newName" value="新增部门"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../emp/sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
				<li><span>部门/职位管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>部门</span> <i class="fa fa-angle-right"></i></li>
				<li><span>${map.emp.departmentName}详情</span></li>
			</ul>
			<div class="DetailWrapper">
				<div class="ShowGroupWrapper">
					<div class="ShowTitle">部门基本信息</div>
					<ul class="ClearFix ShowGroup">
						<li>
							<label>部门名称：</label>
							<span>${map.department.departmentName}</span>
						</li>
						<li>
							<label>部门经理：</label>
							<span>${map.department.managerName}</span>
						</li>
						<li>
							<label>创建日期：</label>
							<span class="FormatDate">${map.department.createdAt}</span>
						</li>
					</ul>
				</div>
				<div class="ShowGroupWrapper">
					<div class="ShowTitle">部门在职员工</div>
					<table border="1" class="Table" style="margin-top: 30px">
						<tr class="THead">
							<th>员工编号</th>
							<th>姓名</th>
							<th>手机号</th>
							<th>城市</th>
							<th>所属部门</th>
							<th>职位</th>
							<th>状态</th>
							<th>操作</th>
						</tr>
						<tbody>
						<c:forEach items="${map.page.list}" var="emp">
							<tr>
								<td>${emp.id}</td>
								<td>${emp.realName}</td>
								<td>${emp.mobile}</td>
								<td>${emp.baseCityName}</td>
								<td>${emp.departmentName}</td>
								<td>${emp.positionName}</td>
								<td>
									<c:if test="${emp.workStatus eq 0}">在职</c:if>
								</td>
								<td class="TDAction">
									<a href="/emp/detail?id=${emp.id}" class="ListBtn">详情</a>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
					<c:set var="page" value="${map.page}"></c:set>
					<c:set var="pageUrl" value="/dept/detail?departmentId=${map.department.id}"></c:set>
					<%@include file="../lib/pagination.jsp" %>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>
