<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车型设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/carmodel/edit"></c:set>
<c:set var="newName" value="新增车型"></c:set>
<c:set var="sidebarOn" value="车型配置"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>车型</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/system/carmodel/list" novalidate>
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" type="text" name="modelName" value="${map.modelName}" placeholder=" 索引/品牌中文名称"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>

				</form>
			</div>
			<table border="1" class="Table">

				<tr class="THead">
					<th>车型ID</th>
					<th>车型名称</th>
					<th>年款</th>
					<th>所属车系</th>
					<th>所属生产厂商</th>
					<th>所属品牌</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="carModel">
					<tr>
						<td>${carModel.id}</td>
						<td>${carModel.modelName}</td>
						<td>${carModel.modelYear}</td>
						<td>${carModel.lineName}</td>
						<td>${carModel.subBrandName}</td>
						<td>${carModel.brandName}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/system/carmodel/list?modelName=${map.modelName}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>
		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
