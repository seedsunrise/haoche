<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:if test="${map.quoter.id == null}">
    <c:set var="title" value="新增报价员"></c:set>
</c:if>
<c:if test="${map.quoter.id != null}">
    <c:set var="title" value="编辑报价员"></c:set>
</c:if>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/insurance/quoter/edit"></c:set>
<c:set var="newName" value="新增报价员"></c:set>
<c:set var="sidebarOn" value="报价员"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车险设置</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${map.quoter.id == null}">
                    <li><span>新增报价员</span></li>
                </c:if>
                <c:if test="${map.quoter.id != null}">
                    <li><span>编辑报价员</span></li>
                </c:if>
            </ul>
            <form action="/insurance/quoter/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.quoter.id}">

                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${map.quoter.id == null}">新增报价员</c:if><c:if test="${map.quoter.id != null}">编辑报价员</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="name" class="FormLayout"><span class="LabelNeed">报价员名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="name" name="name"
                                           value="${map.quoter.name}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="company"><span class="LabelNeed">所属保险公司：</span></label>
                                    <select name="company.id" id="company"
                                            class="CustomSelect" value="${map.quoter.company.id}" required>
                                        <option value="">请选择</option>
                                        <c:forEach var="item" items="${map.companyList}">
                                            <option value="${item.id}">${item.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="phone"><span class="LabelNeed">报价人电话：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="phone" name="phone" value="${map.quoter.phone}" required>
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
<%@include file="../../lib/footer.jsp" %>
