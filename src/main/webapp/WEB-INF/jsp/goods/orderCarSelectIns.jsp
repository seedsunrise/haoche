<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>
<input type="hidden" id="HiddenInsuranceTotalPrice">
<input type="hidden" id="BuyPrice" value="${map.carInfo.salePrice}">
<input type="hidden" id="TotalSalePrice">
<input type="hidden" id="CarId" value="${map.carInfo.id}">
<table class="GroupTable">
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">交强险&车船使用税</div>
        </td>
        <td class="TableGroupContent">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">交强险：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo StrongInsurance"></span>
                </div>
            </div>
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">车船使用税：</span></label>
                <div class="FormLayout FormItemControl">
                    <span class="SpanInfo UseInsurance"></span>
                </div>
            </div>
        </td>
    </tr>
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">商业险<span class="LabelNeedWrapper">（  <span
                    class="LabelNeed">为必填</span>）</span>
                <br>
            </div>
        </td>
        <td class="TableGroupContent">
            <div class="FormItem ClearFix">
                <label class="FormLayout"><span class="">选择保险报价单：</span></label>
                <div class="FormLayout FormItemControl">

                    <select id="InsuranceSelect" class="CustomSelect <c:if test="${map.orderType == 2}">NoCustomSelect</c:if>">
                        <c:forEach items="${map.insuranceList}" var="insurance">
                            <option value="${insurance.id}">${insurance.quoter.company.name}&nbsp;&nbsp;&nbsp;${insurance.quoter.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="FormItem ClearFix" style="padding: 0 50px">

                <c:forEach items="${map.insuranceList}" var="insurance">
                    <div class="InsuranceGroupWrapper-${insurance.id}" style="display: none;">
                    <c:forEach items="${insurance.detailList}" var="detail">
                        <c:if test="${detail.option.type == 0}">
                            <input type="hidden" value="${detail.price}" name="${detail.option.name}">
                        </c:if>
                    </c:forEach>
                    </div>
                <table class="Table InsuranceGroup InsuranceGroup-${insurance.id}" data-groupid="${insurance.id}">
                    <tr class="THead">
                        <th>选择购买</th>
                        <th>商业险项目</th>
                        <th>保额（元）</th>
                        <th>价格（元）</th>
                        <th>选择购买不计免赔</th>
                        <th>不计免赔价格（元）</th>
                    </tr>

                    <c:forEach items="${insurance.detailList}" var="detail">
                        <c:if test="${detail.option.type == 1}">
                            <tr class="InsuranceGroupItem" data-detailid="${detail.id}" data-infoid="${detail.infoId}">
                                <td>

                                    <input data-parent=".InsuranceGroup-${insurance.id}" class="MainItemStatus <c:if test="${detail.option.name == '第三者责任险'}">ThirdPartInsurance</c:if>"
                                           type="checkbox" <c:if test="${detail.isConfirm == 1}">checked</c:if> />
                                </td>
                                <td>${detail.option.name}</td>
                                <td>
                                    <c:if test="${detail.option.extend != ''}">
                                        <input type="hidden" class="IsImported" value="${detail.isImported}">
                                        <c:if test="${detail.option.name == '玻璃单独破碎险' && detail.isImported == 0}">
                                            国产
                                        </c:if>
                                        <c:if test="${detail.option.name == '玻璃单独破碎险' && detail.isImported == 1}">
                                            进口
                                        </c:if>
                                        <c:if test="${detail.option.name != '玻璃单独破碎险'}">
                                            ${detail.option.extend}
                                        </c:if>
                                    </c:if>
                                    <c:if test="${detail.option.extend == ''}">
                                        <span class="Coverage">${detail.coverage}</span>
                                    </c:if>
                                </td>
                                <td class="MainPrice" data-price="${detail.price}">${detail.price}</td>
                                <td>
                                    <c:if test="${detail.option.isNonDeductible == 0}">
                                        无
                                    </c:if>
                                    <c:if test="${detail.option.isNonDeductible == 1}">
                                        <c:if test="${detail.isConfirmDeductible == 1}">
                                            <input data-parent=".InsuranceGroup-${insurance.id}" class="SubItemStatus" type="checkbox" checked>
                                        </c:if>
                                        <c:if test="${detail.isConfirmDeductible == 0}">
                                            <input data-parent=".InsuranceGroup-${insurance.id}" class="SubItemStatus" type="checkbox">
                                        </c:if>
                                    </c:if>
                                </td>
                                <td class="SubPrice" data-price="${detail.nonDeductible}">
                                    <c:if test="${detail.option.isNonDeductible == 1}">
                                        ${detail.nonDeductible}
                                    </c:if>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
                </c:forEach>
            </div>
        </td>
    </tr>
    <tr>
        <td class="TableGroupTitle">
            <div class="GroupTitle">车险合计</div>
        </td>
        <td class="TableGroupContent">
            <div class="FormItem ClearFix">
                <label style="margin-left: 50px">交强险&车船使用税合计： <span class="StrongAndBoatPrice"></span></label>
                <label>商业险合计： <span class="OtherPriceTotal"></span></label>
                <label>总计： <span class="InsuranceTotalPrice"></span></label>
            </div>
        </td>
    </tr>
</table>
