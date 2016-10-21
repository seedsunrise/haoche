<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:if test="${map.orderType == 1}">
    <c:set var="title" value="全款下单"></c:set>
</c:if>
<c:if test="${map.orderType == 2}">
    <c:set var="title" value="贷款下单"></c:set>
</c:if>
<c:set var="newUrl" value="/carGoods/new"></c:set>
<c:set var="newName" value="新增商品"></c:set>
<c:set var="navOn" value="商品"></c:set>
<%@include file="../lib/header.jsp"%>
<%@include file="../lib/nav.jsp"%>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="Main">
    <div id="SideBar">
        <%@include file="sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <input type="hidden" id="pageNo"/>
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/carGoods/list?status=20">商品</a> <i class="fa fa-angle-right"></i></li>
                <li><span>上架中商品</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${map.orderType == 1}">
                    <li><span>全款下单</span></li>
                </c:if>
                <c:if test="${map.orderType == 2}">
                    <li><span>贷款下单</span></li>
                </c:if>
            </ul>
            <div class="GoodsStepWrapper">
                <c:if test="${map.orderType == 1}">
                    <div class="ShowOrderCarInfoWrapper GoodsStep GoodsArrow GoodsStepOn" data-show=".ChoseInsurancePlan" data-nextstep="0">1、选择保险方案</div>
                    <div class="ShowOrderCarInfoWrapper GoodsStep GoodsArrow" data-show=".InsurancePlanContract" data-nextstep="1">2、填写合同信息</div>
                    <div class="ShowOrderCarInfoWrapper GoodsStep" data-show=".InsurancePlanContractConfirm" data-nextstep="2">3、确认合同信息</div>
                </c:if>
                <c:if test="${map.orderType == 2}">
                    <div class="ShowOrderCarInfoWrapper GoodsStep GoodsArrow GoodsStepOn" data-show=".ChoseLoan" data-nextstep="-1">1、选择贷款方案</div>
                    <div class="ShowOrderCarInfoWrapper GoodsStep GoodsArrow" data-show=".ChoseInsurancePlan" data-nextstep="0">2、选择保险方案</div>
                    <div class="ShowOrderCarInfoWrapper GoodsStep GoodsArrow" data-show=".InsurancePlanContract" data-nextstep="1">3、填写合同信息</div>
                    <div class="ShowOrderCarInfoWrapper GoodsStep" data-show=".InsurancePlanContractConfirm" data-nextstep="2">4、确认合同信息</div>
                </c:if>
            </div>
            <form action="/carGoods/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.carInfo.id}">
                <c:if test="${map.orderType == 2}">
                <div class="OrderCarInfoWrapper ChoseLoan">
                    <%@include file="orderLoanSelect.jsp"%>
                    <div class="FormItem ClearFix BtnCenterWrapper">
                        <a class="Btn BtnPrimary ShowOrderCarInfoWrapper" href="javascript:;" data-show=".ChoseInsurancePlan" data-nextstep="0">下一步</a>
                    </div>
                </div>
                </c:if>

                <div class="OrderCarInfoWrapper ChoseInsurancePlan" <c:if test="${map.orderType == 2}">style="display:none"</c:if>>
                    <%@include file="orderCarSelectIns.jsp"%>
                    <div class="FormItem ClearFix BtnCenterWrapper">
                        <a class="Btn BtnPrimary ShowOrderCarInfoWrapper" href="javascript:;" data-show=".InsurancePlanContract" data-nextstep="1">下一步</a>
                    </div>
                </div>
                <div class="OrderCarInfoWrapper InsurancePlanContract">
                    <%@include file="orderCarWriteContract.jsp"%>
                    <div class="FormItem ClearFix BtnCenterWrapper">
                        <a class="Btn BtnPrimary ShowOrderCarInfoWrapper" href="javascript:;" data-show=".InsurancePlanContractConfirm" data-nextstep="2">提交</a>
                    </div>
                </div>
                <div class="OrderCarInfoWrapper InsurancePlanContractConfirm">
                    <%@include file="orderCarCompleteContract.jsp"%>
                    <div class="FormItem ClearFix BtnCenterWrapper">
                        <c:if test="${map.orderType == 1}">
                            <a class="Btn BtnPrimary SubmitInsuranceCarOrder" href="javascript:;">确认提交</a>
                        </c:if>
                        <c:if test="${map.orderType == 2}">
                            <a class="Btn BtnPrimary SubmitInsuranceCarOrder SubmitLoanCarOrder" href="javascript:;">确认提交</a>
                        </c:if>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp"%>


