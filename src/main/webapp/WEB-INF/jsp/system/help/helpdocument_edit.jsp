<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="帮助文档"></c:set>
<c:set var="navOn" value="帮助文档"></c:set>
<c:set var="newName" value="新增帮助文档"></c:set>


<%@include file="../../lib/header.jsp"%>

<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/help/helpDocument/editPage"></c:set>

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

                <c:if test="${empty map.documentId || map.documentId eq 0}">
                    <li><span>新增</span></li>
                </c:if>
                <c:if test="${map.documentId > 0}">
                    <li><span>编辑</span></li>
                </c:if>
            </ul>

            <form action="/help/helpDocument/edit" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="documentId" value="${map.documentId}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">
                                帮助文档
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="title" class="FormLayout"><span class="LabelNeed">文档标题：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="title" maxlength="10" name="title" value="${map.helpDocument.title}" required>
                                </div>
                            </div>

                            <div class="FormItem ClearFix">
                                <label for="label" class="FormLayout"><span class="LabelNeed">文档标签：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="label" maxlength="3" name="label" value="${map.helpDocument.label}" required>
                                </div>
                            </div>

                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="firstLevelMenuId"><span class="LabelNeed">所属一级标题：</span></label>
                                <input type="hidden" name="firstLevelMenuName" class="firstLevelMenuName" value="${map.helpDocument.firstLevelMenuName}">
                                <div class="FormLayout FormItemControl">
                                    <select value="${map.helpDocument.firstLevelMenuId}" name="firstLevelMenuId" id="firstLevelMenuId" class="CustomSelect LinkedInput LinkSelect"
                                            data-input="firstLevelMenuName" data-link="secondLevelMenuId" data-url="/help/helpDocument/getHelpMenuByParentId?parentId=" required>
                                        <option value="">请选择</option>
                                        <c:forEach items="${map.firstMenuList}" var="firstMenu">
                                            <option value="${firstMenu.id}">${firstMenu.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="secondLevelMenuId"><span
                                        class="LabelNeed">所属二级标题：</span></label>
                                <input type="hidden" value="${map.helpDocument.secondLevelMenuName}" name="secondLevelMenuName"
                                       class="secondLevelMenuName">
                                <div class="FormLayout FormItemControl">
                                    <select name="secondLevelMenuId" id="secondLevelMenuId"
                                            class="CustomSelect LinkedInput" data-input="secondLevelMenuName" value="${map.helpDocument.secondLevelMenuId}" required>
                                        <option value="">请选择</option>
                                    </select>
                                </div>
                            </div>

                            <div class="FormItem ClearFix">
                                <label class="FormLayout"><span class="LabelNeed">文档内容：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <textarea name="content" id="Editor">${map.helpDocument.content}</textarea>
                                </div>
                            </div>

                            <div class="FormItem ClearFix">
                                <label class="FormLayout"><span class="LabelNeed">是否启用：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <label for="disableNot" class="FormRatio">
                                        <input type="radio" name="disable" id="disableNot" value="false" <c:if test="${map.helpDocument.disable == false || map.helpDocument == null }">checked</c:if>>
                                        <span>启用</span>
                                    </label>
                                    <label for="disableYes" class="FormRatio">
                                        <input type="radio" name="disable" id="disableYes" value="true" <c:if test="${map.helpDocument.disable == true}">checked</c:if>>
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
<%@include file="../../lib/simditorFooter.jsp"%>
