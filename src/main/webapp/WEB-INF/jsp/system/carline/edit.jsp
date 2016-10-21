<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增车系"></c:set>
<%@include file="../../lib/header.jsp"%>
<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/system/carline/edit"></c:set>
<c:set var="newName" value="新增车系"></c:set>
<c:set var="sidebarOn" value="车系" ></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${carLineDTO.id == null}">
                    <li><span>新增车系</span></li>
                </c:if>
                <c:if test="${carLineDTO.id != null}">
                    <li><span>编辑车系</span></li>
                </c:if>
            </ul>
            <form action="/system/carline/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo"
                  novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${carLineDTO.id}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${carLineDTO.id == null}">新增车系</c:if><c:if test="${carLineDTO.id != null }">编辑车系</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="lineName" class="FormLayout"><span class="LabelNeed">车系名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="lineName" name="lineName" value="${carLineDTO.lineName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="carBrandId"><span class="LabelNeed">车辆品牌：</span></label>
                                <input type="hidden" value="${carLineDTO.brandName}" name="brandName" class="CarBrandName">
                                <div class="FormLayout FormItemControl">
                                    <select name="carBrandId" id="carBrandId" class="CustomSelect LinkedInput LinkSelect" data-link="carSubBrandId" data-url="/system/carsubbrand/getCarSubBrandByCarBrandId?id="
                                            data-input="CarBrandName" value="${carLineDTO.carBrandId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach var="item" items="${carBrandDTOList}">
                                            <option value="${item.id}">${item.brandName}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="carSubBrandId"><span
                                        class="LabelNeed">生产厂商：</span></label>
                                <input type="hidden" value="${carLineDTO.subBrandName}" name="subBrandName" class="CarSubBrandName">
                                <div class="FormLayout FormItemControl">
                                    <select name="carSubBrandId" id="carSubBrandId" class="CustomSelect LinkedInput LinkSelect" data-link="carLineId" data-url="/system/carline/getCarLineListByCarSubBrandId?id="
                                            data-input="CarSubBrandName" value="${carLineDTO.carSubBrandId}" required>
                                        <option value="">请选择</option>
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
<%@include file="../../lib/footer.jsp"%>
