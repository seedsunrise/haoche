<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<table class="GroupTable">
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">商品及价格信息</div>
        </td>
        <td class="TableGroupContent">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">商品标题：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo">${map.carInfo.carTitle}</span>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">车主售价：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo">${map.carInfo.salePrice}元</span>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">贷款选择<span class="LabelNeedWrapper">（  <span
                    class="LabelNeed">为必填</span>）</span>
                <br>
            </div>
        </td>
        <td class="TableGroupContent">
            <input type="hidden" value="${map.carInfo.salePrice}" id="UserSalePrice">
            <input type="hidden" value="" id="UserDownPayment">
            <input type="hidden" value="" id="UserCapital">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="LabelNeed">选择首付比例：</span></label>
                <div class="FormLayout FormItemControl">
                    <select class="CustomSelect" id="DownPaymentRatio">
                        <option value="0">请选择首付比例</option>
                        <option value="30">30%</option>
                        <option value="40">40%</option>
                        <option value="50">50%</option>
                        <option value="60">60%</option>
                        <option value="70">70%</option>
                    </select>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="LabelNeed">选择贷款期限：</span></label>
                <div class="FormLayout FormItemControl">
                    <select class="CustomSelect" id="PeriodNumber">
                        <option value="0">请选择贷款期限</option>
                        <option value="12">12个月</option>
                        <option value="24">24个月</option>
                        <option value="36">36个月</option>
                    </select>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">首付金额：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo DownPayment"></span>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <input type="hidden" id="CapitalValue">
                <label class="FormLayout"><span class="">贷款本金：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo Capital"></span>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">金融机构<span class="LabelNeedWrapper">（  <span
                    class="LabelNeed">为必填</span>）</span>
                <br>
            </div>
        </td>
        <td class="TableGroupContent">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="LabelNeed">贷款金融：</span></label>
                <div class="FormLayout FormItemControl">
                    <select class="CustomSelect" id="LoadCompany">
                        <option value="">请选择贷款金融</option>
                        <c:forEach items="${map.carLoanChannelList}" var="channel">
                            <option value="${channel.channelId}">${channel.channelName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">年利率：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo" id="channelRateYear"></span>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">月供：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo" id="payments"></span>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">利息：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo" id="totalInterest"></span>
                </div>
            </div>
        </td>
    </tr>
</table>
