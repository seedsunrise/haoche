<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="报价员"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/insurance/quoter/edit"></c:set>
<c:set var="newName" value="新增报价员"></c:set>
<c:set var="sidebarOn" value="报价员"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车险设置</span> <i class="fa fa-angle-right"></i></li>
				<li><span>报价员</span></li>
			</ul>
			<table border="1" class="Table">
				<tr class="THead">
					<th>编号</th>
					<th>报价人姓名</th>
					<th>所属保险公司</th>
					<th>报价人电话</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="quoter">
					<tr>
						<td>${quoter.id}</td>
						<td>${quoter.name}</td>
						<td>${quoter.company.name}</td>
						<td>${quoter.phone}</td>
						<td class="TDAction">
							<c:if test="${CurrentUser.check('/insurance/quoter/edit')}">
								<a href="/insurance/quoter/edit?id=${quoter.id}" class="ListBtn">编辑</a>
							</c:if>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
							<c:if test='${CurrentUser.check("/insurance/quoter/delete")}'>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/insurance/quoter/delete?id=${quoter.id}">删除</a>
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
