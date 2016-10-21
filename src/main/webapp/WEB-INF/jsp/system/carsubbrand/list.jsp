<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="生产厂商设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/carsubbrand/edit"></c:set>
<c:set var="newName" value="新增生产厂商"></c:set>
<c:set var="sidebarOn" value="生产厂商"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>生产厂商</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/system/carsubbrand/list" novalidate>
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" type="text" name="subBrandName" value="${map.subBrandName}" placeholder="生产厂商名称"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>
			<table border="1" class="Table">
				<tr class="THead">
					<th>生产厂商ID</th>
					<th>生产厂商名称</th>
					<th>所属品牌</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="carSubBrand">
					<tr>
						<td>${carSubBrand.id}</td>
						<td>${carSubBrand.subBrandName}</td>
						<td>${carSubBrand.brandName}</td>
						<td class="TDAction">
							<c:if test='${CurrentUser.check("/system/carsubbrand/edit")}'>
								<a href="/system/carsubbrand/edit?id=${carSubBrand.id}" class="ListBtn">编辑</a>
							</c:if>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/system/carsubbrand/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/system/carsubbrand/delete?id=${carSubBrand.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
            <c:set var="page" value="${map.page}"></c:set>
            <c:set var="pageUrl" value="/system/carsubbrand/list?subBrandName=${map.subBrandName}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>
        </div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
