<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增职位"></c:set>
<%@include file="../lib/header.jsp" %>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp" %>

<c:set var="sidebarOn" value="职位"></c:set>
<c:set var="newUrl" value="/emp/position/edit"></c:set>
<c:set var="newName" value="新增职位"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../emp/sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
				<li><span>部门/职位管理</span> <i class="fa fa-angle-right"></i></li>
				<c:if test="${empPositionDTO.id == null}">
					<li><span>新增职位</span></li>
				</c:if>
				<c:if test="${empPositionDTO.id != null}">
					<li><span>编辑职位</span></li>
				</c:if>
			</ul>
			<form action="/emp/position/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm">
				<input type="hidden" name="id" value="${empPositionDTO.id}">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">

							<c:if test="${empPositionDTO.id == null}">
								<div class="GroupTitle">新增职位<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
							</c:if>
							<c:if test="${empPositionDTO.id != null}">
								<div class="GroupTitle">编辑职位<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
							</c:if>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="positionName" class="FormLayout"><span class="LabelNeed">职位名称：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" type="text" id="positionName" name="positionName" value="${empPositionDTO.positionName}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="departmentId">所属部门：</label>
								<input type="hidden" name="departmentName" class="departmentName">
								<div class="FormLayout FormItemControl">
									<select name="departmentId" id="departmentId" class="CustomSelect LinkedInput" data-input="departmentName" value="${empPositionDTO.departmentId}" required>
										<option value="">请选择</option>
										<c:forEach var="item" items="${empDepartmentDTOList}">
											<option value="${item.id}">${item.departmentName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">职位角色<span class="LabelNeedWrapper">（多选）</span></div>
						</td>
						<td class="TableGroupContent">
							<input type="hidden" name="groupIds" value="" id="ActionsInput">
							<div class="FormLayout FormItemControl">
								<ul class="ClearFix PermissionLsit">
									<c:forEach items="${groupDtoList}" var="groupDTo" >
										<li class="PermissionItem">
											<label for="" class="CheckBoxLabel" title="${groupDTo.groupName}">
												<input type="checkbox" data-actionid="${groupDTo.id}"<c:if test="${groupDTo.isSelect == 1}">checked</c:if> />
												<span title="${groupDTo.groupName}">${groupDTo.groupName}</span>
											</label>
										</li>
									</c:forEach>
								</ul>
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
