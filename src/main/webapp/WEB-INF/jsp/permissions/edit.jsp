<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="角色"></c:set>
<%@include file="../lib/header.jsp" %>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp" %>

<c:set var="sidebarOn" value="角色"></c:set>
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
				<c:if test="${map.group.id == null}">
					<li><span>新增角色</span></li>
				</c:if>
				<c:if test="${map.group.id != null}">
					<li><span>编辑角色</span></li>
				</c:if>
			</ul>
			<form action="/permissions/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo" novalidate>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="id" value="${map.group.id}">
				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">角色基本信息<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="groupName" class="FormLayout"><span class="LabelNeed">角色名称：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" type="text" id="groupName" name="groupName" value="${map.group.groupName}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="groupDesc">角色简介：</label>
								<div class="FormLayout FormItemControl">
									<textarea class="FormInput" type="text" id="groupDesc" name="groupDesc" >${map.group.groupDes}</textarea>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">角色运营系统权限<span class="LabelNeedWrapper">（多选）</span></div>
						</td>
						<td class="TableGroupContent">
							<input type="hidden" name="actions" value="" id="ActionsInput">
							<div class="FormLayout FormItemControl">
								<ul class="ClearFix PermissionLsit">
									<c:forEach items="${map.actions}" var="action" >
										<c:if test="${action.id>269 && action.actionName != null}">
											<li class="PermissionItem">
												<label for="" class="CheckBoxLabel" title="${action.actionName}">
													<input type="checkbox" data-actionid="${action.id}" <c:if test="${action.isSelect == 1}">checked</c:if> />
													<span title="${action.actionName}">${action.actionName}</span>
												</label>
											</li>
										</c:if>
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
<%@include file="../lib/footer.jsp"%>