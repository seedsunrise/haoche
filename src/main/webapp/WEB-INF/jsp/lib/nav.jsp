<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page import="com.haoche.bos.util.CurrentUser" %>

<header>
    <div class="Layout ClearFix Relative">
        <a href="/index/statistical" class="Logo"><img src="/resources/image/MainLogo.png" alt=""></a>
        <ul class="HeaderNav">
            <li>
                <%--<c:if test='${CurrentUser.check("/index")}'>--%>
                    <a href="/index/statistical" class="BorderRight <c:if test="${navOn.equals('首页')}">NavOn</c:if>">首页</a>
                <%--</c:if>--%>
            </li>
            <c:if test='${CurrentUser.check("/carSource/list")}'>
                <li>
                    <a href="/carSource/list?status=1" class="<c:if test="${navOn.equals('车源')}">NavOn</c:if>">车源&车商</a>
                </li>
            </c:if>
            <li><a href="/identifyManagement/list?identifyType=1" class="<c:if test="${navOn.equals('品质整备')}">NavOn</c:if>">品质整备</a></li>
            <c:if test='${CurrentUser.check("/carGoods/list")}'>
                <li>
                    <a href="/carGoods/list" class="BorderRight <c:if test="${navOn.equals('商品')}">NavOn</c:if>">商品</a>
                </li>
            </c:if>
            <%--<li><a href="" class="<c:if test="${navOn.equals('客户线索')}">NavOn</c:if>">客户线索</a></li>--%>
            <c:if test='${CurrentUser.check("/deal/list")}'>
                <li><a href="/deal/list" class="BorderRight <c:if test="${navOn.equals('交付')}">NavOn</c:if>">交付</a></li>
            </c:if>
            <li><a href="/user/userInfo/list" class="BorderRight <c:if test="${navOn.equals('车主服务')}">NavOn</c:if>">车主服务</a></li>
            <%--<li><a href="" class="BorderRight <c:if test="${navOn.equals('财务管理')}">NavOn</c:if>">财务管理</a></li>--%>
            <%--<li><a href="" class="BorderRight <c:if test="${navOn.equals('数据中心')}">NavOn</c:if>">数据中心</a></li>--%>
            <li>
                <c:if test='${CurrentUser.check("/emp/list")}'>
                    <a href="/emp/list?workStatus=0" class="<c:if test="${navOn.equals('员工管理')}">NavOn</c:if>">员工管理</a>
                </c:if>
            </li>
            <li>
                <c:if test='${CurrentUser.check("/system/city/list")}'>
                    <a href="/system/city/list" class="<c:if test="${navOn.equals('系统设置')}">NavOn</c:if>">系统设置</a>
                </c:if>
            </li>
        </ul>
        <div class="HeaderUserWrapper">
            <span class="UserName NoSelect"><%= CurrentUser.get().getRealName() == null ? CurrentUser.get().getUsername() : CurrentUser.get().getRealName() %><i class="fa fa-angle-down"></i></span>
            <ul class="UserSetting">
                <li><a href="/emp/detail?id=<%=CurrentUser.get().getId()%>&from=1">个人资料</a></li>
                <li><a href="/emp/changePasswordPage">修改密码</a></li>
                <li><a href="/emp/session/destroy">退出<i class="fa fa-sign-out"></i></a></li>
            </ul>
        </div>

    </div>
</header>
