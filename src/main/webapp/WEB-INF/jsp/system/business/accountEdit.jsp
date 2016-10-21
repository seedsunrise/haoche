<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车商帐号管理"></c:set>
<%@include file="../../lib/header.jsp"%>
<c:set var="navOn" value="车源"></c:set>
<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/system/business/edit"></c:set>
<c:set var="newName" value="新增车商帐号"></c:set>
<c:set var="sidebarOn" value="车商帐号" ></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../../carsource/sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">车源&车商</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车商帐号</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${map.business.id == null}">
                    <li><span>新增车商帐号</span></li>
                </c:if>
                <c:if test="${map.business.id != null}">
                    <li><span>编辑车商帐号</span></li>
                </c:if>
            </ul>
            <form action="/system/business/accountUpdate" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.business.id}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${map.business.id == null}">新增车商帐号</c:if><c:if test="${map.business.id != null }">编辑车商帐号</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="carBusinessId"><span class="LabelNeed">选择车商：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input type="hidden" value="${map.business.carBusinessName}" name="carBusinessName" class="carBusinessName">
                                    <select name="carBusinessId" id="carBusinessId" class="CustomSelect LinkedInput" data-input="carBusinessName" value="${map.business.carBusinessId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach var="item" items="${map.businessList}">
                                            <option value="${item.id}">${item.businessName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="businessUserRealName"><span class="LabelNeed">帐号所有人姓名：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <textarea class="FormInput" id="businessUserRealName" name="businessUserRealName" required>${map.business.businessUserRealName}</textarea>
                                </div>
                            </div>
	                        <div class="FormItem ClearFix">
		                        <label class="FormLayout" for="businessUserMobile"><span class="LabelNeed">手机号：</span></label>
		                        <div class="FormLayout FormItemControl">
			                        <textarea class="FormInput" id="businessUserMobile" name="businessUserMobile" required>${map.business.businessUserMobile}</textarea>
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