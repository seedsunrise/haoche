<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车商管理"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="车源"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/business/edit"></c:set>
<c:set var="newName" value="新增车商"></c:set>
<c:set var="sidebarOn" value="车商"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../../carsource/sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车商管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>车商</span></li>
			</ul>
			<table border="1" class="Table">
				<tr class="THead">
					<th>车商ID</th>
					<%--<th>车商LOGO</th>--%>
					<th>品牌名</th>
					<th>所在城市</th>
					<th>经销公司</th>
                    <th>星级</th>
					<th>地址</th>
					<th>营业状态</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="business">
					<tr>
						<td>${business.id}</td>
						<%--<td>--%>
							<%--<c:if test="${business.businessLogo != ''}">--%>
								<%--<img class="ImagePreShow" src="${map.imageUrl}${business.businessLogo}"alt="${business.businessName}">--%>
							<%--</c:if>--%>
						<%--</td>--%>
						<td>${business.businessName}</td>
						<td>${business.businessCityName}</td>
						<td>${business.businessProfile}</td>
						<td>
							<c:if test="${business.star == 10}">一星</c:if>
							<c:if test="${business.star == 20}">两星</c:if>
							<c:if test="${business.star == 30}">三星</c:if>
							<c:if test="${business.star == 40}">四星</c:if>
							<c:if test="${business.star == 50}">五星</c:if>
						</td>
						<td>${business.address}</td>
						<td>
							<c:if test="${business.isOpened == 0}">营业中</c:if>
							<c:if test="${business.isOpened == 1}">停业中</c:if>
						</td>
						<td class="TDAction">
							<c:if test='${CurrentUser.check("/system/business/edit")}'>
								<a href="/system/business/edit?id=${business.id}" class="ListBtn">编辑</a>
							</c:if>

								<c:if test="${business.isOpened == 0 && CurrentUser.check('/system/business/changeOpenStatus')}">
									<a href="javascript:;" class="ListBtn AjaxBtn" data-msg="修改成功" data-pending="设置状态中"
									   data-url="/system/business/changeOpenStatus?id=${business.id}&isOpened=1">设为停业中</a>
								</c:if>
								<c:if test="${business.isOpened == 1 && CurrentUser.check('/system/business/changeOpenStatus')}}">
									<a href="javascript:;" class="ListBtn AjaxBtn" data-msg="修改成功" data-pending="设置状态中"
									   data-url="/system/business/changeOpenStatus?id=${business.id}&isOpened=0">设为营业中</a>
								</c:if>

							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/system/business/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/system/business/delete?id=${group.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/system/business/list"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
