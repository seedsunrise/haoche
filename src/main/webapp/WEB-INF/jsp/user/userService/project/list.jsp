<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="title" value="服务预约项目设置"></c:set>
<%@include file="../../../lib/header.jsp" %>
<c:set var="navOn" value="车主服务"></c:set>
<%@include file="../../../lib/nav.jsp" %>
<c:set var="sidebarOn" value="服务预约项目设置"></c:set>

<c:set var="newUrl" value="/userservice/project/edit"></c:set>
<c:set var="newName" value="新增服务预约"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../../sideBar.jsp" %>
	</div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/user/list">车主服务</a> <i class="fa fa-angle-right"></i></li>
				<li><span>服务预约</span> <i class="fa fa-angle-right"></i></li>
				<li><span>服务预约项目设置</span></li>
			</ul>
			<table border="1" class="Table">
				<tr class="THead">
					<th>服务预约项ID</th>
                    <th>项目标题</th>
                    <th>链接地址</th>
					<th>项目简介</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${map.page.list}" var="project" varStatus="status">
                    <tr>
                        <td>${project.id}</td>
						<td>${project.projectTitle}</td>
						<td>${project.url}</td>
						<td>${project.projectInfo}</td>
                        <td>
							<a href="/userservice/project/edit?id=${project.id}" class="ListBtn">编辑</a>
							<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
							   data-confirm="你确定要删除这条数据?" data-pending="删除"
							   data-url="/userservice/project/delete?id=${project.id}">删除</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/userservice/project/list?${map.param}"></c:set>
			<%@include file="../../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../../lib/footer.jsp" %>
