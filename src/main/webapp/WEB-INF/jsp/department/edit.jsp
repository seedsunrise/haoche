<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增部门"></c:set>
<%@include file="../lib/header.jsp" %>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp" %>

<c:set var="sidebarOn" value="部门"></c:set>
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
				<li><span>新增部门</span></li>
			</ul>
			<form action="/dept/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo">
				<input type="hidden" name="departmentId" value="${map.dept.id}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">新增部门<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="departmentName" class="FormLayout"><span class="LabelNeed">部门名称：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" type="text" id="departmentName" name="departmentName" value="${map.dept.departmentName}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="managerId">部门经理：</label>
								<input type="hidden" name="managerName" class="ManagerName">
								<div class="FormLayout FormItemControl">
									<select name="managerId" id="managerId" class="CustomSelect LinkedInput" data-input="ManagerName" value="${map.dept.managerId}">
										<option value="">请选择</option>
										<c:forEach var="item" items="${map.empList}">
											<option value="${item.id}">${item.realName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</td>
					</tr>
				</table>
				<div class="FormItem ClearFix">
					<button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
				</div>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp" %>
