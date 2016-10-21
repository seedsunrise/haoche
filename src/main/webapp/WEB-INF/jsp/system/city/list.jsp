<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="城市设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/city/edit"></c:set>
<c:set var="newName" value="新增城市"></c:set>
<c:set var="sidebarOn" value="城市设置"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>城市/门店管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>城市设置</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/system/city/list" novalidate>
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" type="text" name="cityName" value="${map.cityName}" placeholder="城市名称"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>

			<table border="1" class="Table">
				<tr class="THead">
					<th>城市ID</th>
					<th>首字母</th>
					<th>百度城市Code</th>
					<th>城市名称</th>
					<th>是否开通二手车销售业务</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="city">
					<tr>
						<td>${city.id}</td>
						<td>${city.cityChar}</td>
						<td>${city.baiduCityCode}</td>
						<td>${city.cityName}</td>
						<td>
							<c:if test="${city.saleOpened}">已开通</c:if>
							<c:if test="${!city.saleOpened}">未开通</c:if>
						</td>
						<td class="TDAction">
							<c:if test='${CurrentUser.check("/system/city/edit")}'>
								<a href="/system/city/edit?cityId=${city.id}" class="ListBtn">编辑</a>
							</c:if>
							<c:if test='${CurrentUser.check("/system/city/delete")}'>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/system/city/delete?id=${city.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/system/city/list?cityName=${map.cityName}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
