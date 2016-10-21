<%@ page import="com.haoche.bos.util.CurrentUser" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="广告列表"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="广告列表"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/banner/edit"></c:set>
<c:set var="newName" value="新增广告"></c:set>
<c:set var="sidebarOn" value="广告列表"></c:set>

<div class="Main">
<c:if test="${CurrentUser.check('/system/banner/list')}">
    <div id="SideBar">
        <%@include file="../sideBar.jsp"%>
    </div>

    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="#">APP广告</a> <i class="fa fa-angle-right"></i></li>
                <li>
                    <span>APP广告列表</span>
                </li>
            </ul>

            <table border="1" class="Table">
                <tr class="THead">
                    <th>广告类型</th>
                    <th>点击效果</th>
                    <th>跳转地址</th>
                    <th>排序</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:forEach var="banner" items="${map.page.list}">
                    <tr>
                        <td>
                            <c:if test="${banner.bannerType eq 1}">
                                首页轮播
                            </c:if>
                            <c:if test="${banner.bannerType eq 2}">
                                首页提示
                            </c:if>
                            <c:if test="${banner.bannerType eq 3}">
                                APP启动页
                            </c:if>
                            <c:if test="${banner.bannerType eq 4}">
                                车主
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${banner.clickType eq 1}">
                                无效果
                            </c:if>
                            <c:if test="${banner.clickType eq 2}">
                                跳转APP内页
                            </c:if>
                            <c:if test="${banner.clickType eq 3}">
                                跳转外部链接
                            </c:if>
                        </td>
                        <td>${banner.clickUrl}</td>
                        <td>${banner.sortIndex}</td>
                        <td>
                            <%--<a class="ListBtn" href="/system/banner/detail?id=${banner.id}">详情</a>--%>
                            <a class="ListBtn" href="/system/banner/edit?id=${banner.id}">修改</a>
                            <a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-reloadurl="/system/banner/list" data-msg="删除成功" data-confirm="你确定要删除这条数据?" data-pending="删除" data-url="/system/banner/delete?id=${banner.id}">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:set var="page" value="${map.page}"></c:set>
            <c:set var="pageUrl" value="/system/banner/list"></c:set>
            <%@include file="../../lib/pagination.jsp"%>
        </div>
    </div>
</c:if>
</div>
<%@include file="../../lib/footer.jsp"%>