<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:if test="${shopDTO != null}">
    <c:set var="title" value="修改门店"></c:set>
</c:if>
<c:if test="${shopDTO == null}">
    <c:set var="title" value="新增门店"></c:set>
</c:if>
<%@include file="../../lib/header.jsp"%>
<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/system/shop/edit"></c:set>
<c:set var="newName" value="新增门店"></c:set>
<c:set var="sidebarOn" value="门店设置" ></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>城市/门店管理</span> <i class="fa fa-angle-right"></i></li>

                <c:if test="${shopDTO.id == null}">
                    <li><span>新增门店</span></li>
                </c:if>
                <c:if test="${shopDTO.id != null}">
                    <li><span>编辑门店</span></li>
                </c:if>
            </ul>
            <form action="/system/shop/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${shopDTO.id}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">新增门店<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="shopName" class="FormLayout"><span class="LabelNeed">门店名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="20" type="text" id="shopName" name="shopName" value="${shopDTO.shopName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="cityId"><span class="LabelNeed">所在城市：</span></label>
                                <input type="hidden" name="cityName" class="CityName" value="${shopDTO.cityName}">
                                <div class="FormLayout FormItemControl">
                                    <select name="cityId" id="cityId" class="CustomSelect LinkInput" data-input="CityName" value="${shopDTO.cityId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach items="${cityDTOList}" var="city">
                                            <option value="${city.id}">${city.cityName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="shopType"><span class="LabelNeed">门店类型：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <select name="shopType" id="shopType" class="CustomSelect LinkInput" value="${shopDTO.shopType}" required>
                                        <option value="">请选择</option>
                                        <option value="0">展厅</option>
                                        <option value="1">仓库</option>
                                        <option value="2">收车点</option>
                                        <option value="3">门店</option>
                                        <option value="4">公司</option>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="shopAddress"><span class="LabelNeed">门店地址：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <textarea class="FormInput" type="text" id="shopAddress" name="shopAddress" required>${shopDTO.shopAddress}</textarea>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="phoneNumber">联系电话：</label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput"  id="phoneNumber" name="phoneNumber" value="${shopDTO.phoneNumber}">
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout"><span class="LabelNeed">营业状态：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <label for="notOpen" class="FormRatio">
                                        <input type="radio" name="isOpened" id="notOpen" value="0" <c:if test="${shopDTO.isOpened == 0 || shopDTO == null}">checked</c:if>>
                                        <span>营业中</span>
                                    </label>
                                    <label for="open" class="FormRatio">
                                        <input type="radio" name="isOpened" id="open" value="1" <c:if test="${shopDTO.isOpened == 1}">checked</c:if>>
                                        <span>未营业</span>
                                    </label>
                                    <label for="clear" class="FormRatio">
                                        <input type="radio" name="isOpened" id="clear" value="2" <c:if test="${shopDTO.isOpened == 2}">checked</c:if>>
                                        <span>装修中</span>
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
