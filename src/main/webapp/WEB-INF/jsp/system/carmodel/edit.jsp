<%@ page import="com.haoche.bos.util.CalendarUtils" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增车型"></c:set>
<%@include file="../../lib/header.jsp" %>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/carmodel/edit"></c:set>
<c:set var="newName" value="新增车型"></c:set>
<c:set var="sidebarOn" value="车型配置"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${carModelDTO.id == null}">
                    <li><span>新增车型</span></li>
                </c:if>
                <c:if test="${carModelDTO.id != null}">
                    <li><span>编辑车型</span></li>
                </c:if>
            </ul>
            <form action="/system/carmodel/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${carModelDTO.id}">
                <input type="hidden" name="modelYear" value="${carModelDTO.modelYear}">
                <input type="hidden" name="action" value="${carModelDTO.action}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${carModelDTO.id == null}">新增车型</c:if><c:if
                                    test="${carModelDTO.id != null }">编辑车型</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="modelName" class="FormLayout"><span class="LabelNeed">车型名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="modelName" name="modelName"
                                           value="${carModelDTO.modelName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="modelYear"><span class="LabelNeed">年款：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <div class="FormLayout FormItemControl">
                                        <select name="modelYear" id="modelYear" class="CustomSelect"
                                                value="${carModelDTO.modelYear}" required>
                                            <option value="">请选择</option>
                                            <% for (int i = CalendarUtils.getYear(); i > 1989; i--) {%>
                                            <option value="<%= String.valueOf(i) %>"><%=  i %>
                                            </option>
                                            <%}%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="carBrandId"><span class="LabelNeed">车辆品牌：</span></label>
                                <input type="hidden" value="${carModelDTO.brandName}" name="brandName"
                                       class="CarBrandName">
                                <div class="FormLayout FormItemControl">
                                    <select name="carBrandId" id="carBrandId"
                                            class="CustomSelect LinkedInput LinkSelect"
                                            data-link="carSubBrandId"
                                            data-url="/system/carsubbrand/getCarSubBrandByCarBrandId?id="
                                            data-input="CarBrandName" value="${carModelDTO.carBrandId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach items="${carBrandDTOList}" var="carBrand">
                                            <option value="${carBrand.id}">${carBrand.brandName}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="carSubBrandId"><span
                                        class="LabelNeed">生产厂商：</span></label>
                                <input type="hidden" value="${carModelDTO.subBrandName}" name="subBrandName"
                                       class="CarSubBrandName">
                                <div class="FormLayout FormItemControl">
                                    <select name="carSubBrandId" id="carSubBrandId"
                                            class="CustomSelect LinkedInput LinkSelect" data-link="carLineId"
                                            data-url="/system/carline/getCarLineListByCarSubBrandId?id="
                                            data-input="CarSubBrandName" value="${carModelDTO.carSubBrandId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach items="${carSubBrandDTOList}" var="carSubBrand">
                                            <option value="${carSubBrand.id}">${carSubBrand.subBrandName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="carLineId"><span class="LabelNeed">所属车系：</span></label>
                                <input type="hidden" name="lineName" class="lineName" value="${carModelDTO.lineName}">
                                <div class="FormLayout FormItemControl">
                                    <select name="carLineId" id="carLineId" class="CustomSelect LinkInput"
                                            data-input="lineName" value="${carModelDTO.carLineId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach items="${carLineDTOList}" var="carLine">
                                            <option value="${carLine.id}">${carLine.lineName}</option>
                                        </c:forEach>
                                    </select>
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
