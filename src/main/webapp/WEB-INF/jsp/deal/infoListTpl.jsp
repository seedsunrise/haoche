<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:forEach var="info" items="${infoList}">
    <li style="min-t height: 146px;">
        <div class="InsuranceCompany">${info.quoter.company.name}</div>
        <div>报价人:${info.quoter.name}</div>
        <div>电话: ${info.quoter.phone}</div>
        <div>
            <c:if test="${info.quoteStatus == 1}">报价中...</c:if>
            <c:if test="${info.quoteStatus == 2}">报价完毕</c:if>
        </div>
        <div>
            <c:if test="${info.quoteStatus == 2}">
                <div>未确认保项</div>
                <div>
                    <a class="ListBtn ShowInsuranceDetail" data-infoid="${info.id}" href="javascript:;">去选择确认保项</a>
                </div>
            </c:if>
            <c:if test="${info.quoteStatus == 3}">
                <div>已确认保项</div>
                <div>
                    <a class="ListBtn ShowInsuranceDetail" data-infoid="${info.id}" href="javascript:;">重新确认保项</a>
                </div>
                <div><label><input data-infoid="${info.id}" type="radio" name="SelectedInsurance" <c:if test="${info.isChoose == 1}">checked</c:if>>选择此项保单</label></div>
            </c:if>
        </div>
    </li>
</c:forEach>
