<%@ page import="com.haoche.remoting.dto.InsuranceQuoteDTO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="insuranceInfoDTO" value="${map.order}"></c:set>
<%--${map}--%>
<input type="hidden" name="InsuranceDetailId" value="${insuranceInfoDTO.id}"/>
<h2>${map.renewal.carInfoDTO.carTitle}</h2>
<div class="InsuranceQuoterInfo">
    <label>承险公司：</label><span>${map.info.quoter.company.name}</span>
</div>
<div class="InsuranceQuoterInfo">
    <label>报价人手机号：</label><span>${map.info.quoter.name} ${map.info.quoter.phone}</span>
</div>

<h3 class="CompulsoryInsuranceTitle">交强险 车船使用税(元)</h3>
<div class="InsuranceQuoteFormGroup ClearFix">
<c:forEach items="${map.info.detailList}" var="detail">
    <c:if test="${detail.option.type == 0}">
        <div class="InsuranceQuoteFormGroupData">
            <input type="hidden" value="${detail.id}" class="DetailDataId">
            <input type="hidden" value="${detail.infoId}" class="DetailDataInfoId">
            <label class="<c:if test="${detail.option.name == '交强险'}">FirstLabel</c:if>">${detail.option.name}：</label>
            <input type="text" class="CustomInput CalculateItem Price" value="${detail.price}" readonly>
        </div>
    </c:if>
</c:forEach>
</div>

<h3 style="margin-top: 25px">商业险</h3>
<div class="InsuranceQuoteFormGroupTitle">
    <span>保额(元)</span>
    <span>价格(元)</span>
    <span>不计免赔(元)</span>
</div>

<c:forEach items="${map.info.detailList}" var="detail">
    <c:if test="${detail.option.type == 1}">
        <div class="InsuranceQuoteFormGroup InsuranceQuoteFormGroupData ClearFix">
            <input type="hidden" value="${detail.id}" class="DetailDataId">
            <input type="hidden" value="${detail.infoId}" class="DetailDataInfoId">
            <label class="FirstLabel">
                <%--整项是否选中--%>
                <c:if test="${detail.isConfirm == 1}">
                    <input type="checkbox" class="DetailCheck" checked>
                </c:if>
                <c:if test="${detail.isConfirm == 0}">
                    <input type="checkbox" class="DetailCheck">
                </c:if>
                ${detail.option.name}：
            </label>

            <%--保额--%>
            <c:if test="${detail.option.extend != ''}">
                <input type="hidden" class="IsImported" value="detail.isImported">
                <c:if test="${detail.option.name == '玻璃单独破碎险' && detail.isImported == 0}">
                    <span class="InsuranceQuoteItemShow">国产</span>
                </c:if>
                <c:if test="${detail.option.name == '玻璃单独破碎险' && detail.isImported == 1}">
                    <span class="InsuranceQuoteItemShow">进口</span>
                </c:if>
                <c:if test="${detail.option.name != '玻璃单独破碎险'}">
                    <span class="InsuranceQuoteItemShow">${detail.option.extend}</span>
                </c:if>
            </c:if>

            <%--保额不计入总价--%>
            <c:if test="${detail.option.extend == ''}">
                <input type="text" class="CustomInput Coverage" value="${detail.coverage}" readonly>
            </c:if>

            <input type="text" class="CustomInput CalculateItem Price" value="${detail.price}" readonly>

            <%--是否有不计免赔--%>
            <c:if test="${detail.option.isNonDeductible == 0}">
                <span class="InsuranceQuoteItemShow">无</span>
            </c:if>
            <c:if test="${detail.option.isNonDeductible == 1}">
                <c:if test="${detail.isConfirmDeductible == 1}">
                    <input type="checkbox" class="DeductibleCheck" checked>
                </c:if>
                <c:if test="${detail.isConfirmDeductible == 0}">
                    <input type="checkbox" class="DeductibleCheck">
                </c:if>
                <input type="text" class="CustomInput CalculateItem DeductibleCheckPrice" value="${detail.nonDeductible}" readonly>
            </c:if>
        </div>
    </c:if>
</c:forEach>
<div class="InsuranceQuoteFormGroup">
    <div class="InsuranceQuoteItemShowTotal">总计：<span>0</span>元</div>
</div>