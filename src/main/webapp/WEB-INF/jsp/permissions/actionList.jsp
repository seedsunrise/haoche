<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="业务运营系统权限"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="业务运营系统权限" ></c:set>
<div class="Main">
	<div id="SideBar">
        <%@include file="../emp/sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
				<li><span>权限管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>业务运营系统权限</span></li>
			</ul>
			<table border="1" class="Table">
                <tr class="THead">
                    <th>权限编号</th>
                    <th>权限名称</th>
                    <th>资源值</th>
                    <th>资源类型</th>
                    <th>请求方法</th>
                </tr>
                <tbody>
                <c:forEach items="${page.list}" var="action">
                    <tr>
	                    <td>${action.id}</td>
	                    <td>${action.actionName}</td>
	                    <td>${action.actionValue}</td>
	                    <td>${action.actionType}</td>
	                    <td>${action.methodType}</td>
                    </tr>
                </c:forEach>
                </tbody>
			</table>
			<c:set var="page" value="${page}"></c:set>
			<c:set var="pageUrl" value="/permissions/actionList"></c:set>
			<%@include file="../lib/pagination.jsp"%>

		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>
