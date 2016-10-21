<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="服务预约项目"></c:set>
<c:set var="sidebarOn" value="服务预约项目设置"></c:set>
<c:set var="newUrl" value="/userservice/project/edit"></c:set>
<c:set var="newName" value="新增服务预约"></c:set>
<c:set var="navOn" value="车主服务"></c:set>

<%@include file="../../../lib/header.jsp" %>
<%@include file="../../../lib/nav.jsp" %>

<div class="Main">
	<div id="SideBar">
		<%@include file="../../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/user/list">车主服务</a> <i class="fa fa-angle-right"></i></li>
				<li><span>服务预约项目设置</span> <i class="fa fa-angle-right"></i></li>
				<li>
                    <span>
                        <c:if test="${map.userServiceProject.id == null}">新增服务预约项目</c:if>
                        <c:if test="${map.userServiceProject.id != null}">编辑服务预约项目</c:if>
                    </span>
				</li>
			</ul>
			<form action="/userservice/project/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo"
			      novalidate>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="id" value="${map.userServiceProject.id}"/>
				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">服务预约项目基本信息<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
							</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="projectTitle" class="FormLayout"><span class="LabelNeed">项目标题：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" type="text" id="projectTitle" name="projectTitle"
									       value="${map.userServiceProject.projectTitle}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="url" class="FormLayout"><span class="">链接地址：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" type="text" id="url" name="url"
										   value="${map.userServiceProject.url}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="projectInfo"><span class="">项目简介：</span></label>
								<div class="FormLayout FormItemControl">
									<textarea class="FormInput" id="projectInfo" name="projectInfo" maxlength="500">${map.userServiceProject.projectInfo}</textarea>
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
<%@include file="../../../lib/footer.jsp" %>
