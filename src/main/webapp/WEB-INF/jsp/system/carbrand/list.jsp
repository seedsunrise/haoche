<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="品牌设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/carbrand/edit"></c:set>
<c:set var="newName" value="新增品牌"></c:set>
<c:set var="sidebarOn" value="品牌"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>品牌</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/system/carbrand/list" novalidate>
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" type="text" name="brandName" value="${map.brandName}" placeholder=" 索引/品牌中文名称"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>
			<table border="1" class="Table">
				<tr class="THead">
					<th>品牌ID</th>
					<th>品牌缩略图</th>
					<th>品牌索引</th>
					<th>品牌中文名称</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="carBrand">
					<tr>
						<td>${carBrand.id}</td>
						<td>
							<c:if test="${carBrand.brandIcon != ''}">
								<img src="${map.imageUrl}${carBrand.brandIcon}" class="CarBrand FancyBoxImg" href="${map.imageUrl}${carBrand.brandIcon}">
							</c:if>
						</td>
						<td>${carBrand.brandChar}</td>
						<td>${carBrand.brandName}</td>
						<td class="TDAction">
							<c:if test="${CurrentUser.check('/system/carbrand/edit')}">
								<a href="/system/carbrand/edit?id=${carBrand.id}" class="ListBtn">编辑</a>
							</c:if>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/system/carbrand/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/system/carbrand/delete?id=${carBrand.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/system/carbrand/list?brandName=${map.brandName}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
