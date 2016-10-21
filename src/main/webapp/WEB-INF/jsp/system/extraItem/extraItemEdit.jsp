<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:if test="${map.item.id == null}">
    <c:set var="title" value="新增项目"></c:set>
</c:if>
<c:if test="${map.item.id != null}">
    <c:set var="title" value="编辑项目"></c:set>
</c:if>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/extraItem/edit"></c:set>
<c:set var="newName" value="新增项目"></c:set>
<c:set var="sidebarOn" value="项目列表"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>保养、美容、精品加装设置</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${map.company.id == null}">
                    <li><span>新增项目</span></li>
                </c:if>
                <c:if test="${map.company.id != null}">
                    <li><span>编辑项目</span></li>
                </c:if>
            </ul>
            <form action="/extraItem/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.item.id}">

                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${map.item.id == null}">新增项目</c:if><c:if test="${map.item.id != null}">编辑项目</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="name" class="FormLayout"><span class="LabelNeed">项目名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="name" name="name"
                                           value="${map.item.name}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="type"><span class="LabelNeed">隶属类别：</span></label>
                                <select name="type" id="type"
                                        class="CustomSelect" value="${map.item.type.id}" required>
                                    <option value="">请选择</option>
                                    <c:forEach var="item" items="${map.type}">
                                        <option value="${item.id}">${item.text}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="FormItem ClearFix">
                    <button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../../lib/footer.jsp" %>
