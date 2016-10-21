<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车险"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="交付"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="全部车险订单"></c:set>
<div class="Main">
    <div id="SideBar">
        <%@include file="sideBar.jsp"%>
    </div>
    <div id="dealList" class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/deal/list">交付</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车险订单管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>全部订单</span></li>
            </ul>
            <div class="SearchBox ClearFix">
                <form action="/carInsurance/payList" novalidate class="MainSearchForm">
                    <input id="sortInput" name="sort" type="hidden" value="${map.sort}"/>
                    <input id="scInput" name="order" type="hidden" value="${map.sc}"/>
                    <div class="SearchGroup DatePickerStart">
                        <div class="DatePickerWrapper">
                            <input value="<%= request.getParameter("startTime") != null ? request.getParameter("startTime") : ""%>"
                                   data-date-end-date="0d"
                                   placeholder="下单时间" class="CustomInput DatePicker" name="startTime" id="StartTime"/>
                        </div>
                    </div>
                    <div class="SearchGroup">
                        <div class="DatePickerWrapper">
                            <input value="<%= request.getParameter("endTime") != null ? request.getParameter("endTime") : ""%>"
                                   data-date-end-date="0d" data-start="#StartTime"
                                   placeholder="创建结束时间" class="CustomInput DatePicker" name="endTime"/>
                        </div>
                    </div>
                    <div class="SearchGroup">
                        <select name="carBrandId" id="carBrandId" class="CustomSelect LinkSelect" data-link="carLineId" data-url="/carSource/queryLine?carBrandId=" required value="<%= request.getParameter("carBrandId") %>">
                            <option value="">全部品牌</option>
                            <c:forEach var="carBrand" items="${map.carBrandList}">
                                <option value="${carBrand.id}">${carBrand.brandName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="SearchGroup">
                        <select name="carLineId" id="carLineId" class="CustomSelect LinkedInput"  value="<%= request.getParameter("carLineId") %>">
                            <option value="">全部车系</option>
                        </select>
                    </div>

                    <div class="OtherSearchInfoBorder"></div>
                    <div class="OtherSearchInfo">
                        <div class="SortWrapper">
                            <ul class="SortList">
                                <li>
                                    <a class="SortItemWrapper" href="javascript:;" sort="createdAtByGoods">
                                        <span>创建时间</span>
                                        <c:if test="${map.sort == 'updatedAt' && map.sc == 'asc'}">
                                            <img src="/resources/image/SortAsc.png">
                                        </c:if>
                                        <c:if test="${map.sort == 'updatedAt' && map.sc == 'desc'}">
                                            <img src="/resources/image/SortDesc.png">
                                        </c:if>
                                    </a>
                                </li>
                                <li>
                                    <a class="SortItemWrapper" href="javascript:;" sort="salePrice">
                                        <span>车主售价</span>
                                        <c:if test="${map.sort == 'salePrice' && map.sc == 'asc'}">
                                            <img src="/resources/image/SortAsc.png">
                                        </c:if>
                                        <c:if test="${map.sort == 'salePrice' && map.sc == 'desc'}">
                                            <img src="/resources/image/SortDesc.png">
                                        </c:if>
                                    </a>
                                <li>
                            </ul>
                        </div>
                        <div class="SearchButtonWrapper ClearFix SearchButtonWrapperMore">
                            <input class="CustomInput InputMarginLeft" placeholder="车辆标题/车架号" type="text" name="search" value="${map.search}"/>
                            <button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </form>
            </div>
            <table border="1" class="Table tb45  ">
                <tr class="THead">
                    <th width="100">保险订单号</th>
                    <th>关联商品</th>
                    <th>客户姓名</th>
                    <th>车险订单状态</th>
                    <th>报价状态</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:forEach items="${map.page.list}" var="order">
                    <tr>
                        <td>${order.orderListParamDTO.orderNo}</td>
                        <td>
                            <a href="${map.imageUrl}${order.orderListParamDTO.carMainPhoto}" class="FixImage CarImage FancyBoxImg"
                               data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${order.orderListParamDTO.carMainPhoto}"></a>
                                <%--<img class="productImg fl" src="${map.imageUrl}${order.carMainPhoto}"  >--%>

                            <div class="CarInfo GoodInfoShort">
                                <div class="CarTitle" style="text-align: left">${order.orderListParamDTO.carTitle}</div>
                                <div class="CarOtherInfo">
                                    <div class="CarOtherInfoItem">
                                        <span>${order.orderListParamDTO.firstLicenseDate}上牌</span>
                                        <span>${order.orderListParamDTO.runKm/10000}万公里</span>
                                        <span>${order.orderListParamDTO.carColor}</span>
                                        <span>${order.orderListParamDTO.displacement}</span>
                                    </div>
                                    <div class="CarOtherInfoItem">
                                        <span>创建：${fn:substring(order.orderListParamDTO.createdAt,0,16)}</span>
                                    </div>
                                    <div class="CarOtherInfoItem">
                                        <span>保险状态更新：${fn:substring(order.updateTime,0,16)}</span>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td>${order.orderListParamDTO.buyUserName}</td>
                        <td>
                            <div class="Center">
                                <c:if test="${order.insuranceOrderDTO.orderStatus == 0}">
                                    待处理
                                </c:if>
                                <c:if test="${order.insuranceOrderDTO.orderStatus == 1}">
                                    已购买
                                </c:if>
                                <c:if test="${order.insuranceOrderDTO.orderStatus == 2}">
                                    已取消
                                </c:if>
                            </div>
                        </td>
                        <td>
                            <c:if test="${order.insuranceOrderDTO.orderStatus == 0}">
                                <div>收到 <span class="Price">${order.finishQuoteNum}</span> 家保险报价</div>
                                <c:if test="${order.isChoose == 0}">
                                    <div>
                                        <a class="ListBtn ShowInsuranceListAjax" data-carid="${order.orderListParamDTO.carId}" href="javascript:;" data-cartitle="${order.orderListParamDTO.carTitle}">重新选择</a>
                                    </div>
                                </c:if>
                                <c:if test="${order.isChoose == 1}">
                                    <div>已确认保单 <a class="ListBtn ShowInsuranceListAjax" data-carid="${order.orderListParamDTO.carId}" href="javascript:;" data-cartitle="${order.orderListParamDTO.carTitle}">重新选择</a></div>
                                </c:if>
                            </c:if>
                            <c:if test="${order.insuranceOrderDTO.orderStatus == 2}">
                                <div>收到 <span class="Price">${order.finishQuoteNum}</span> 家保险报价</div>
                            </c:if>
                            <c:if test="${order.insuranceOrderDTO.orderStatus == 1}">
                                <div>已成功购买车险</div>
                                <div>总价： <span class="Price">${order.insuranceOrderDTO.totalPrice}元</span></div>
                                <div>购买时间：${fn:substring(order.insuranceOrderDTO.orderTime,0,16)}</div>
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${order.insuranceOrderDTO.orderStatus == 0}">
                                <c:if test="${order.isChoose == 1}">
                                    <a href="javascript:;" class="ListBtn GetPayInsuranceInfo" data-url="/carInsurance/toOrderPay?id=${order.insuranceOrderDTO.infoId}">立即认购已选车险保单</a>
                                    <br />
                                </c:if>
                                <a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="成功取消车险订单"
                                   data-confirm="你确定要取消车险订单?" data-pending="取消中..."
                                   data-url="/carInsurance/editOrderStatus?id=${order.insuranceOrderDTO.id}&orderStatus=2">取消车险订单</a>
                            </c:if>
                            <c:if test="${order.insuranceOrderDTO.orderStatus == 2}">
                                <a style="margin-right: 0" href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="恢复成功"
                                   data-confirm="你确定要恢复车险订单?" data-pending="恢复中..."
                                   data-url="/carInsurance/editOrderStatus?id=${order.insuranceOrderDTO.id}&orderStatus=0">恢复为待处理订单</a>
                                <br />
                                <a href="javascript:;" class="AjaxBtnConfirm AjaxBtn"
                                   data-msg="删除成功" data-confirm="你确定要删除订单?" data-pending="删除订单"
                                   data-reloadurl="/deal/list?carAction=1" data-url="/deal/cancelOrder?orderId=${order.insuranceOrderDTO.id}&statusId=2">删除订单</a>
                            </c:if>
                            <c:if test="${order.insuranceOrderDTO.orderStatus == 1}">
                                <a style="margin-right: 0" class="ListBtn ShowInsuranceDetail HideBtn" data-infoid="${order.insuranceOrderDTO.infoId}" href="javascript:;">查看保单</a>
                                <br />
                                <a href="javascript:;" class="AjaxBtnConfirm AjaxBtn"
                                   data-msg="删除成功" data-confirm="你确定要删除订单?" data-pending="删除订单"
                                   data-reloadurl="/deal/list?carAction=1" data-url="/deal/cancelOrder?orderId=${order.insuranceOrderDTO.id}&statusId=2">删除订单</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:set var="page" value="${map.page}"></c:set>
            <c:set var="pageUrl" value="/carInsurance/payList"></c:set>
            <%@include file="../lib/pagination.jsp"%>
        </div>
    </div>
</div>
<%@include file="deliverDetail/insuranceQuoteOrderDialogTpl.jsp"%>
<%@include file="../lib/footer.jsp"%>
