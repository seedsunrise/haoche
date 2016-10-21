<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增城市"></c:set>
<%@include file="../../lib/header.jsp"%>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/system/city/edit"></c:set>
<c:set var="newName" value="新增城市"></c:set>
<c:set var="sidebarOn" value="城市设置" ></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>城市/门店管理</span> <i class="fa fa-angle-right"></i></li>

                <c:if test="${empty city.id}">
                    <li><span>新增城市</span></li>
                </c:if>
                <c:if test="${city.id > 0}">
                    <li><span>编辑城市</span></li>
                </c:if>
            </ul>

            <form action="/system/city/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="cityId" value="${city.id}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">新增城市<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="cityName" class="FormLayout"><span class="LabelNeed">城市名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="cityName" maxlength="10" name="cityName" value="${city.cityName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="cityChar"><span class="LabelNeed">城市首字母：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <div class="FormLayout FormItemControl">
                                        <select name="cityChar" id="cityChar" class="CustomSelect" value="${city.cityChar}" required>
                                            <option value="">请选择</option>
                                            <% for(int i=(int)'A';i<'A'+26;i++) {%>
                                            <option value="<%= (char)i %>"><%= (char)i %></option>
                                            <%}%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="baiduCityCode"><span class="LabelNeed">百度城市Code：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="number" id="baiduCityCode" name="baiduCityCode" number="true" value="${city.baiduCityCode}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout"><span class="LabelNeed">是否开通二手车业务：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <label for="saleOpenedNot" class="FormRatio">
                                        <input type="radio" name="saleOpened" id="saleOpenedNot" value="false" <c:if test="${city.saleOpened == false || city == null }">checked</c:if>>
                                        <span>不开通</span>
                                    </label>
                                    <label for="saleOpenedYes" class="FormRatio">
                                        <input type="radio" name="saleOpened" id="saleOpenedYes" value="true" <c:if test="${city.saleOpened == true}">checked</c:if>>
                                        <span>开通</span>
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
