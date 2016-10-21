<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:if test="${goods == null}">
	<c:set var="title" value="新增商品"></c:set>
</c:if>
<c:if test="${goods != null}">
	<c:set var="title" value="编辑商品"></c:set>
</c:if>

<c:if test="${map.status == 20}">
	<c:set var="sidebarOn" value="上架中的商品"></c:set>
</c:if>
<c:if test="${map.status != 20}">
	<c:set var="sidebarOn" value="全部商品"></c:set>
</c:if>

<c:set var="newUrl" value="/carGoods/new"></c:set>
<c:set var="newName" value="新增商品"></c:set>
<c:set var="navOn" value="商品"></c:set>
<%@include file="../lib/header.jsp" %>
<%@include file="../lib/nav.jsp" %>

<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/carGoods/list?status=20">商品</a> <i class="fa fa-angle-right"></i></li>
				<li><span>商品管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>编辑商品</span></li>
            </ul>
            <form action="/carGoods/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm GoodsForm HistoryGo" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	            <input type="hidden" name="id" value="${map.carInfo.id}">
				<%@include file="editCommonTpl.jsp"%>
                <div class="FormItem ClearFix">
	                <button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp" %>
