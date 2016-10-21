<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="保险公司"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/insurance/company/edit"></c:set>
<c:set var="newName" value="新增保险公司"></c:set>
<c:set var="sidebarOn" value="保险公司"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车险设置</span> <i class="fa fa-angle-right"></i></li>
				<li><span>保险公司</span></li>
			</ul>
			<table border="1" class="Table">
				<tr class="THead">
					<th>编号</th>
					<th>保险公司名称</th>
					<th>公司LOGO</th>
					<th>企业电话</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="company">
					<tr>
						<td>${company.id}</td>
						<td>${company.name}</td>
						<td>
							<c:if test="${company.logo != '' && company.logo != null }">
                                <img src="${map.imageUrl}${company.logo}" class="CarBrand FancyBoxImg" href="${map.imageUrl}${company.logo}">
                            </c:if>
						</td>
						<td>${company.phone}</td>
						<td class="TDAction">
							<c:if test="${CurrentUser.check('/insurance/company/edit')}">
								<a href="/insurance/company/edit?id=${company.id}" class="ListBtn">编辑</a>
							</c:if>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/insurance/company/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/insurance/company/delete?id=${company.id}">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/insurance/company/list}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
