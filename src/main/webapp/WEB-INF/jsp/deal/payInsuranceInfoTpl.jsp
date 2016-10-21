<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<input type="hidden" name="id" value="${insuranceOrder.id}" class="InsuranceOrderId">
<input type="hidden" name="infoId" value="${insuranceOrder.infoId}" class="InsuranceInfoId">
<input type="hidden" name="totalPrice" value="${insuranceOrder.totalPrice}" class="InsuranceTotalPrice">
<table class="Table" >
    <tr class="THead">
        <th>交强险及其他</th>
        <th>商业险</th>
        <th>合计</th>
        <th>本阶段付款类型</th>
        <th>本阶段应付额度</th>
    </tr>
    <tr>
        <td>${insuranceOrder.nonCommercialRisk}元</td>
        <td>${insuranceOrder.commercialInsurance}元</td>
        <td>${insuranceOrder.totalPrice}元</td>
        <td>车险</td>
        <td>${insuranceOrder.totalPrice}元</td>
    </tr>
</table>
