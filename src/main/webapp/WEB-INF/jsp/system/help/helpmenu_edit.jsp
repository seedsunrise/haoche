<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:choose>
    <c:when test="${map.level eq 1}">
        <c:set var="title" value="一级标题"></c:set>
        <c:set var="navOn" value="一级标题"></c:set>
        <c:set var="newName" value="新增一级标题"></c:set>
    </c:when>
    <c:otherwise>
        <c:set var="title" value="二级标题"></c:set>
        <c:set var="navOn" value="二级标题"></c:set>
        <c:set var="newName" value="新增二级标题"></c:set>
    </c:otherwise>
</c:choose>

<%@include file="../../lib/header.jsp"%>

<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/help/helpMenu/editPage?level=${map.level}"></c:set>

<c:set var="sidebarOn" value="帮助中心" ></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>帮助中心</span> <i class="fa fa-angle-right"></i></li>
                <li>
                    <c:choose>
                        <c:when test="${map.level eq 1}"><span>一级标题</span></c:when>
                        <c:otherwise><span>二级标题</span></c:otherwise>
                    </c:choose>
                    <i class="fa fa-angle-right"></i>
                </li>
                <c:if test="${empty map.menuId || map.menuId eq 0}">
                    <li><span>新增</span></li>
                </c:if>
                <c:if test="${map.menuId > 0}">
                    <li><span>编辑</span></li>
                </c:if>
            </ul>

            <form action="/help/helpMenu/edit?level=${map.level}" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="menuId" value="${map.menuId}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">
                                <c:choose>
                                    <c:when test="${map.level eq 1}">
                                        <c:choose><c:when test="${empty map.menuId}">新增一级标题</c:when><c:otherwise>编辑一级标题</c:otherwise></c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose><c:when test="${empty map.menuId}">新增二级标题</c:when><c:otherwise>编辑二级标题</c:otherwise></c:choose>
                                    </c:otherwise>
                                </c:choose>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="name" class="FormLayout"><span class="LabelNeed">标题名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="name" maxlength="10" name="name" value="${map.helpMenu.name}" required>
                                </div>
                            </div>
                            <c:if test="${map.level eq 2}">
                                <div class="FormItem ClearFix">
                                    <label class="FormLayout" for="parentId"><span class="LabelNeed">所属一级标题：</span></label>
                                    <input type="hidden" name="parentName" class="parentName" value="${map.helpMenu.parentName}">
                                    <div class="FormLayout FormItemControl">
                                        <select value="${map.helpMenu.parentId}" name="parentId" id="parentId" class="CustomSelect LinkedInput"
                                                data-input="parentName"  required>
                                            <option value="">请选择</option>
                                            <c:forEach items="${map.helpMenuFirstLevelList}" var="parentMenu">
                                                <option value="${parentMenu.id}">${parentMenu.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </c:if>

                            <div class="FormItem ClearFix">
                                <label class="FormLayout"><span class="LabelNeed">是否启用：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <label for="disableNot" class="FormRatio">
                                        <input type="radio" name="disable" id="disableNot" value="false" <c:if test="${map.helpMenu.disable == false || map.helpMenu == null }">checked</c:if>>
                                        <span>启用</span>
                                    </label>
                                    <label for="disableYes" class="FormRatio">
                                        <input type="radio" name="disable" id="disableYes" value="true" <c:if test="${map.helpMenu.disable == true}">checked</c:if>>
                                        <span>不启用</span>
                                    </label>
                                </div>
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
<%@include file="../../lib/footer.jsp"%>
