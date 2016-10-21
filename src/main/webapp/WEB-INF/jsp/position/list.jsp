<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="职位"></c:set>
<%@include file="../lib/header.jsp" %>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp" %>

<c:set var="sidebarOn" value="职位"></c:set>
<c:set var="newUrl" value="/emp/position/edit"></c:set>
<c:set var="newName" value="新增职位"></c:set>
<div class="Main">
    <div id="SideBar">
        <%@include file="../emp/sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
                <li><span>部门/职位管理 </span> <i class="fa fa-angle-right"></i></li>
                <li><span>职位列表</span></li>
            </ul>
            <table border="1" class="Table">
                <tr class="THead">
                    <th>职位编号</th>
                    <th>职位名称</th>
                    <th>所属部门</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:forEach items="${page.list}" var="position">
                    <tr>
                        <td>${position.id}</td>
                        <td>${position.positionName}</td>
                        <td>${position.departmentName}</td>
                        <td class="TDAction">
                            <c:if test='${CurrentUser.check("/emp/position/edit")}'>
                                <a href="/emp/position/edit?id=${position.id}" class="ListBtn">编辑</a>
                            </c:if>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <c:if test='${CurrentUser.check("/emp/position/delete")}'>
                                <a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
                                   data-confirm="你确定要删除这条数据?" data-pending="删除"
                                   data-url="/emp/position/delete?id=${position.id}">删除</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:set var="page" value="${page}"></c:set>
            <c:set var="pageUrl" value="/emp/position/list"></c:set>
            <%@include file="../lib/pagination.jsp" %>

        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp" %>
