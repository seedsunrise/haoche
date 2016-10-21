<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车商管理"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="车源"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/business/accountEdit"></c:set>
<c:set var="newName" value="新增车商帐号"></c:set>
<c:set var="sidebarOn" value="车商帐号"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../../carsource/sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/business/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车商管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>车商帐号</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/system/business/accountList" novalidate class="MainSearchForm">
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" placeholder="姓名/手机号/车商名" type="text" name="search" value="${map.search}"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>
			<table border="1" class="Table">
				<tr class="THead">
					<th>车商帐号ID</th>
					<th>帐号所有人姓名</th>
					<th>帐号手机号</th>
					<th>所属车商</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="business">
					<tr>
						<td>${business.id}</td>
						<td>
							${business.businessUserRealName}
						</td>
						<td>${business.businessUserMobile}</td>
						<td>${business.carBusinessName}</td>
						<td class="TDAction">
							<a href="/system/business/accountEdit?id=${business.id}">编辑</a>
							<c:if test='${CurrentUser.check("/system/business/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/system/business/accountDelete?id=${business.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/system/business/accountList"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
