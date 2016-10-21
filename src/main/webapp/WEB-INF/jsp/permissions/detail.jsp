<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="角色详情"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="角色" ></c:set>
<c:set var="newUrl" value="/permissions/edit"></c:set>
<c:set var="newName" value="新增角色"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../emp/sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
                <li><span>角色</span> <i class="fa fa-angle-right"></i></li>
                <li><span>${group.group.groupName}详情</span></li>
            </ul>

			<div class="DetailWrapper">
				<div class="ShowGroupWrapper">
					<div class="ShowTitle">角色基本信息</div>
					<ul class="ClearFix ShowGroup">
						<li>
							<label>角色名称：</label>
							<span>${group.group.groupName}</span>
						</li>
						<li>
							<label>角色简介：</label>
							<span>${group.group.groupDes}</span>
						</li>
					</ul>
				</div>
				<div class="ShowGroupWrapper">
					<div class="ShowTitle">角色运营系统权限</div>
					<ul class="ClearFix ShowGroup">
						<c:forEach items="${group.actions}" var="action" >
							<li>${action.actionName}</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>