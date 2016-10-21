<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<input type="hidden" value="${map.carInfo.salePrice + map.carInfo.servicePrice}" id="ServicePriceAndSalePrice">
<input type="hidden" value="${map.carInfo.servicePrice}" id="ServicePrice">
<table class="GroupTable">
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">价格信息</div>
        </td>
        <td class="TableGroupContent">
            <c:if test="${map.orderType == 2}">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">首付款：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo DownPayment"></span>
                </div>
            </div>
            </c:if>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">车辆车主售价：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo">${map.carInfo.salePrice}元</span>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">车险合计：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo">
                        <span class="SpanInsuranceTotal InsuranceTotalPrice"></span>
                        <a href="javascript:;" class="ListBtn ShowOrderCarInfoWrapper" data-show=".ChoseInsurancePlan" data-nextstep="0">返回重新选择</a>
                    </span>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">品质保障服务费：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo">${map.carInfo.servicePrice}元</span>
                </div>
            </div>
            <c:if test="${map.orderType == 2}">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">金融服务费：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo">3300元</span>
                </div>
            </div>
            </c:if>
            <c:if test="${map.orderType == 1}">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">全款购车总计：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo OrderTotalPrice"></span>
                </div>
            </div>
            </c:if>
            <c:if test="${map.orderType == 2}">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">按揭购车总计：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo OrderLoanTotalPrice"></span>
                </div>
            </div>
            </c:if>
        </td>
    </tr>
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">客户信息<span class="LabelNeedWrapper">（  <span
                    class="LabelNeed">为必填</span>）</span>
                <br>
            </div>
        </td>
        <td class="TableGroupContent">
            <div class="FormItem ClearFix">
                <label for="BuyUserName" class="FormLayout"><span class="LabelNeed">客户姓名：</span></label>
                <div class="FormLayout FormItemControl">
                    <input class="FormInput LinkInfo" data-linkid="#LinkUserName" maxlength="17" type="text" id="BuyUserName" name="BuyUserName" placeholder="请输入客户姓名" required>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label for="BuyUserMobile" class="FormLayout"><span class="LabelNeed">客户电话：</span></label>
                <div class="FormLayout FormItemControl">
                    <input class="FormInput LinkInfo" data-linkid="#LinksUserMobile" maxlength="17" type="text" id="BuyUserMobile" name="BuyUserMobile" placeholder="请输入11位数字手机号" required>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label for="BuyUserIdCardNumber" class="FormLayout"><span class="LabelNeed">客户身份证号码：</span></label>
                <div class="FormLayout FormItemControl">
                    <input class="FormInput LinkInfo" data-linkid="#LinkUserId" maxlength="17" type="text" id="BuyUserIdCardNumber" name="BuyUserIdCardNumber" placeholder="请输入18位身份证号" required>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label for="BuyUserAddress" class="FormLayout"><span class="LabelNeed">所在地址：</span></label>
                <div class="FormLayout FormItemControl">
                    <input class="FormInput LinkInfo" data-linkid="#LinkUserAddress"  maxlength="17" type="text" id="BuyUserAddress" name="BuyUserAddress" placeholder="请输入真实、准确地址" style="width: 280px;" required>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">销售顾问识别码<span class="LabelNeedWrapper">（  <span
                    class="LabelNeed">为必填</span>）</span>
                <br>
            </div>
        </td>
        <td class="TableGroupContent">
            <div class="FormItem ClearFix">
                <label for="SaleUserMobile" class="FormLayout"><span class="LabelNeed">顾问识别码：</span></label>
                <div class="FormLayout FormItemControl">
                    <input class="FormInput" maxlength="17" type="text" id="SaleUserMobile" name="SaleUserMobile" placeholder="请输入11位顾问识别码（销售顾问的手机号）" style="width: 280px" required>
                </div>
            </div>
        </td>
    </tr>
</table>