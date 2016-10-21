<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车系设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/carline/edit"></c:set>
<c:set var="newName" value="新增车系"></c:set>
<c:set var="sidebarOn" value="车系"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>车系</span></li>
			</ul>

			<div class="SearchBox ClearFix">
				<form action="/system/carline/list" novalidate>
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" type="text" name="lineName" value="${map.lineName}" placeholder=" 索引/品牌中文名称"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>
			<table border="1" class="Table">
				<tr class="THead">
					<th>车系ID</th>
					<th>车系名称</th>
					<th>所属生产厂商</th>
					<th>所属品牌</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="carLine">
					<tr>
						<td>${carLine.id}</td>
						<td>${carLine.lineName}</td>
						<td>${carLine.subBrandName}</td>
						<td>${carLine.brandName}</td>
						<td class="TDAction">
							<c:if test='${CurrentUser.check("/system/carline/edit")}'>
								<a href="/system/carline/edit?id=${carLine.id}" class="ListBtn">编辑</a>
							</c:if>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/system/carline/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/system/carline/delete?id=${carLine.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/system/carline/list?lineName=${map.lineName}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
