<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<c:if test="${newUrl != null}">
    <div class="SideBarInner SideMenu">
        <c:if test='${CurrentUser.check(newUrl)}'>
            <a class="SideBarBtn" href="${newUrl}">${newName}</a>
        </c:if>
    </div>
</c:if>

<div class="SideBarInner SideMenu">
    <div class="SideSubTitle">个人信息管理</div>
    <c:if test='${CurrentUser.check("/emp/list")}'>
        <a class="SideBarMainTitle <c:if test="${sidebarOn.equals('个人资料')}">SideBarOn</c:if>" href="/emp/detail?id=<%=CurrentUser.get().getId()%>&from=1">个人资料</a>
    </c:if>
</div>
<div class="SideBarInner SideMenu">
    <div class="SideSubTitle">账号安全管理</div>
    <c:if test="${CurrentUser.check('/dept/list')}">
        <a class="SideBarMainTitle <c:if test="${sidebarOn.equals('修改密码')}">SideBarOn</c:if>" href="/emp/changePasswordPage">修改密码</a>
        <%--<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('职位')}">SideBarOn</c:if>">职位</a>--%>
    </c:if>
</div>
