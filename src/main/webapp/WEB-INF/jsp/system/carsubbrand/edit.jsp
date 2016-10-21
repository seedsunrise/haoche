<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增生产厂商"></c:set>
<%@include file="../../lib/header.jsp" %>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/carsubbrand/edit"></c:set>
<c:set var="newName" value="新增生产厂商"></c:set>
<c:set var="sidebarOn" value="生产厂商"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>

                <c:if test="${carSubBrandDTO.id == null}">
                    <li><span>新增生成厂商</span></li>
                </c:if>
                <c:if test="${carSubBrandDTO.id != null}">
                    <li><span>编辑生成厂商</span></li>
                </c:if>
            </ul>
            <form action="/system/carsubbrand/update" class="FormHorizontal ValidateForm HistoryGo" >
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${carSubBrandDTO.id}">
                <input type="hidden" name="sortValue" value="${carSubBrandDTO.sortValue}">
                <input type="hidden" name="action" value="${carSubBrandDTO.action}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${carSubBrandDTO.id == null}">新增生产厂商</c:if><c:if
                                    test="${carSubBrandDTO.id != null }">编辑生产厂商</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="subBrandName" class="FormLayout"><span
                                        class="LabelNeed">生产厂商称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="subBrandName" name="subBrandName"
                                           value="${carSubBrandDTO.subBrandName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="carBrandId"><span class="LabelNeed">所属品牌：</span></label>
                                <input type="hidden" name="brandName" class="brandName"
                                       value="${carSubBrandDTO.brandName}">
                                <div class="FormLayout FormItemControl">
                                    <select name="carBrandId" id="carBrandId" class="CustomSelect LinkInput"
                                            data-input="BrandName" value="${carSubBrandDTO.carBrandId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach items="${carBrandDTOList}" var="carBrand">
                                            <option value="${carBrand.id}">${carBrand.brandName}</option>
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
