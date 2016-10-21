<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增商品"></c:set>
<%--<c:if test="${map.status == 20}">--%>
    <%--<c:set var="sidebarOn" value="上架中的商品" ></c:set>--%>
<%--</c:if>--%>
<%--<c:if test="${map.status != 20}">--%>
    <%--<c:set var="sidebarOn" value="全部商品" ></c:set>--%>
<%--</c:if>--%>

<c:set var="newUrl" value="/carGoods/new"></c:set>
<c:set var="newName" value="新增商品"></c:set>
<c:set var="navOn" value="商品"></c:set>
<%@include file="../lib/header.jsp"%>
<%@include file="../lib/nav.jsp"%>

<div class="Main">
    <div id="SideBar">
        <%@include file="sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/carGoods/list?status=20">商品</a> <i class="fa fa-angle-right"></i></li>
                <li><span>商品管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>新增商品</span></li>
            </ul>
            <div class="GoodsStepWrapper">
                <div class="GoodsStep GoodsArrow">1、选择车源</div>
                <div class="GoodsStep GoodsArrow GoodsStepOn">2、完善商品信息</div>
                <div class="GoodsStep ">3、确认商品信息</div>
            </div>
            <form action="/carGoods/update" method="post" data-reloadurl="/carGoods/confirm?id=${map.carInfo.id}" class="FormHorizontal FormHorizontalWidthFull ValidateForm" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.carInfo.id}">
                <%@include file="editCommonTpl.jsp"%>
                <div class="FormItem ClearFix" style="text-align: center;margin-top: 20px">
	                <a class="Btn" href="/carGoods/new">上一步</a>
	                <a class="Btn BtnPrimary SubmitCarGoods" href="javascript:;">下一步</a>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp"%>
