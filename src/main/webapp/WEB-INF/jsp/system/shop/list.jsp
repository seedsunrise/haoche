<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="门店设置"></c:set>
<%@include file="../../lib/header.jsp"%>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/system/shop/edit"></c:set>
<c:set var="newName" value="新增门店"></c:set>
<c:set var="sidebarOn" value="门店设置" ></c:set>
<div class="Main">
	<div id="SideBar">
        <%@include file="../sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>城市/门店管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>门店设置</span></li>
            </ul>

            <div class="SearchBox ClearFix">
                <form action="/system/shop/list" novalidate>
                    <div class="SearchGroup">
                        <div class="SearchButtonWrapper ClearFix">
                            <input class="CustomInput" type="text" name="cityName" value="${map.cityName}" placeholder="城市名称"/>
                            <button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </form>
            </div>

			<table border="1" class="Table">
                <tr class="THead">
                    <th>门店ID</th>
                    <th>门店名称</th>
                    <th>所在城市</th>
                    <th>门店地址</th>
                    <th>营业状态</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:forEach items="${map.page.list}" var="shop">
                    <tr>
                        <td>${shop.id}</td>
                        <td>${shop.shopName}</td>
                        <td>${shop.cityName}</td>
                        <td>${shop.shopAddress}</td>
                        <td>
	                        <c:if test="${shop.isOpened == 0}">营业中</c:if>
	                        <c:if test="${shop.isOpened == 1}">未营业</c:if>
	                        <c:if test="${shop.isOpened == 2}">装修中</c:if>
                        </td>
                        <td class="TDAction">
	                        <c:if test="${CurrentUser.check('/system/shop/edit')}">
		                        <a href="/system/shop/edit?shopId=${shop.id}" class="ListBtn">编辑</a>
	                        </c:if>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <c:if test='${CurrentUser.check("/system/shop/delete")}'>
	                            <a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功" data-confirm="你确定要删除这条数据?" data-pending="删除" data-url="/system/shop/delete?id=${shop.id}">删除</a>
                            </c:if>

                        </td>
                    </tr>
                </c:forEach>
                </tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/system/shop/list?cityName=${map.cityName}"></c:set>
			<%@include file="../../lib/pagination.jsp"%>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp"%>
