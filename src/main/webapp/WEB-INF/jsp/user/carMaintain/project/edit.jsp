<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="保养预约项目"></c:set>
<c:set var="sidebarOn" value="保养预约项目设置"></c:set>
<c:set var="newUrl" value="/carMaintain/project/edit"></c:set>
<c:set var="newName" value="新增保养预约"></c:set>
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
                        <c:if test="${map.userServiceProject.id == null}">新增保养预约项目</c:if>
                        <c:if test="${map.userServiceProject.id != null}">编辑保养预约项目</c:if>
                    </span>
				</li>
			</ul>
			<form action="/carMaintain/project/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo"
			      novalidate>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="id" value="${map.userServiceProject.id}"/>
				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">保养预约项目基本信息<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
							</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="projectTitle" class="FormLayout"><span class="LabelNeed">项目标题：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="projectTitle" name="projectTitle"
									       value="${map.userServiceProject.projectTitle}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="projectInfo"><span class="">项目简介：</span></label>
								<div class="FormLayout FormItemControl">
									<textarea class="FormInput" id="projectInfo" name="projectInfo">${map.userServiceProject.projectInfo}</textarea>
								</div>
							</div>

							<div class="FormItem ClearFix">
								<label class="FormLayout" for="projectInfo"><span class="">项目类型：</span></label>
								<div class="FormLayout FormItemControl">
									<label for="saleOpenedNot" class="FormRatio">
										<input type="radio" name="type" id="saleOpenedNot" value="1" <c:if test="${map.userServiceProject.type==1 }">checked</c:if>>
										<span>更换项目</span>
									</label>
									<label for="saleOpenedYes" class="FormRatio">
										<input type="radio" name="type" id="saleOpenedYes" value="2" <c:if test="${map.userServiceProject.type==2 }">checked</c:if>>
										<span>检查项目</span>
									</label>
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
