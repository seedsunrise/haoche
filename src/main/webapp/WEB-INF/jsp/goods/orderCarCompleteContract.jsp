<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<div class="ConfirmInsuranceDetailWrapper">
    <h2>商品基本信息</h2>
    <div class="ConfirmCarInfo ClearFix">
        <div class="PhotoWrapper ClearFix">
            <a href="${map.imageUrl}${map.carInfo.carMainPhoto}" class="FixImage CarImage FancyBoxImg"
               data-param="_r_184_X_q_123" data-pre="${map.imageUrl}" data-source="${map.carInfo.carMainPhoto}"></a>
        </div>
        <div class="InfoWrapper">
            <h3>${map.carInfo.carTitle}</h3>
            <div>VIN:${map.carInfo.carVin}</div>
            <table class="Table" style="margin-top: 15px">
                <tr>
                    <th>首次上牌</th>
                    <th>排量</th>
                    <th>里程</th>
                    <th style="border-right: 1px solid #e6ebef;">颜色</th>
                </tr>
                <tr>
                    <td><span class="FormatDateShort">${map.carInfo.firstLicenseDate}</span></td>
                    <td>${map.carInfo.displacement}</td>
                    <td>${map.carInfo.runKm/10000}万公里</td>
                    <td>外: ${map.carInfo.carColor}  内: ${map.carInfo.carInteriorColor}</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="ConfirmPriceWrapper ClearFix">
        <div class="PriceInfoLeft">
            <h2>价格信息:</h2>
            <div>
                <label>车主售价: </label>
                <span class="PriceSpan">${map.carInfo.salePrice}元</span>
            </div>
            <c:if test="${map.orderType == 2}">
            <div>
                <label>按揭金额: </label>
                <span class="PriceSpan Capital"></span>
            </div>
            <div>
                <label>月供金额: </label>
                <span class="PriceSpan EachMonthPayments"></span>
            </div>
            </c:if>

            <div>
                <label>保险合计: </label>
                <span class="PriceSpan InsuranceTotalPrice"></span>
            </div>

            <div>
                <label>品质保障服务费: </label>
                <span class="PriceSpan">${map.carInfo.servicePrice}元</span>
            </div>

            <c:if test="${map.orderType == 2}">
            <div>
                <label>金融服务费: </label>
                <span class="PriceSpan">3300元</span>
            </div>
            </c:if>

            <c:if test="${map.orderType == 1}">
            <div>
                <label>全款购车总计: </label>
                <span class="PriceSpan OrderTotalPrice"></span>
            </div>
            </c:if>
            <c:if test="${map.orderType == 2}">
                <div>
                    <label>贷款购车总计: </label>
                    <span class="PriceSpan OrderLoanTotalPrice"></span>
                </div>
            </c:if>
        </div>
        <div class="PriceInfoRight">
            <h2>客户信息：</h2>
            <div>姓名：<span id="LinkUserName"></span></div>
            <div>电话：<span id="LinksUserMobile"></spani></div>
            <div>身份证： <span id="LinkUserId"></span></div>
            <div>地址：<span id="LinkUserAddress"></span></div>
        </div>
    </div>
</div>


