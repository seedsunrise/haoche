<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="更新员工角色"></c:set>
<%@include file="../lib/header.jsp" %>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp" %>

<c:set var="newUrl" value="/permissions/edit"></c:set>
<c:set var="newName" value="新增员工"></c:set>

<c:if test="${map.workStatus == 0}">
	<c:set var="sidebarOn" value="在职员工" ></c:set>
</c:if>
<c:if test="${map.workStatus != 0}">
	<c:set var="sidebarOn" value="全部员工" ></c:set>
</c:if>
<div class="Main">
	<div id="SideBar">
		<%@include file="../emp/sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
				<li><span>员工管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>设置员工权限</span></li>
			</ul>
			<form action="/emp/updateEmpGroup" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm" novalidate>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="empId" value="${map.id}">

				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">员工基本信息</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label class="FormLayout">员工姓名：</label>
								<div class="FormLayout FormItemControl">
									<span class="Detail">${map.realName}</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">员工账号：</label>
								<div class="FormLayout FormItemControl">
									<span class="Detail">${map.username}</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">员工角色(多选)：</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<input type="hidden" name="groups" value="" id="ActionsInput">
								<div class="FormLayout FormItemControl">
									<table border="1" class="Table">
										<tr class="THead">
											<th>选择</th>
											<th>角色编号</th>
											<th>角色名称</th>
											<th>角色描述</th>
										</tr>
										<tbody>
										<c:forEach items="${map.groups}" var="group" >
											<tr class="CheckBoxTD <c:if test="${group.isSelect == 1}">Selected</c:if>">
												<td><input type="checkbox" data-actionid="${group.id}" <c:if test="${group.isSelect == 1}">checked</c:if> /></td>
												<td>${group.id}</td>
												<td>${group.groupName}</td>
												<td>${group.groupDes}</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</td>
					</tr>
				</table>


				<div class="FormItem ClearFix">
					<button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp" %>
