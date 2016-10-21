<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="summer" uri="/summer" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车险续保"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="车主服务"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="sidebarOn" value="车险续保"></c:set>
<%--<c:set var="newUrl" value="/carGoods/new?status=20"></c:set>--%>
<%--<c:set var="newName" value="新增商品"></c:set>--%>

<input type="hidden" id="MobileSiteUrl" value="${map.mobileSiteUrl}">
<div class="Main ClearFix">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/carGoods/list">商品</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车险管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>车险续保</span></li>
			</ul>
            <div class="SearchBox ClearFix">
                <form action="/carInsurance/renewalList" novalidate>
                    <div class="SearchGroup">
                        <input class="CustomInput" type="text" name="licenseNum" value='<%= request.getParameter("licenseNum") != null ? request.getParameter("licenseNum") : "" %>' placeholder="车牌号"/>
                    </div>
                    <div class="SearchGroup">
                        <div class="SearchButtonWrapper ClearFix">
                            <input class="CustomInput" type="text" name="mobile" value='<%= request.getParameter("licenseNum") != null ? request.getParameter("mobile") : "" %>' placeholder="手机号"/>
                            <button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </form>
            </div>
			<table class="Table">
				<tr class="THead">
					<th>车辆信息</th>
					<th style="width:124px;">车主信息</th>
					<th style="width:124px;">保险状态</th>
					<th style="width:124px;">操作</th>
				</tr>
				<c:forEach items="${map.page.list}" var="car">
				<tr>
					<td class="CarInfoWrapper GoodsInfoWrapper ClearFix" style="width: 305px">
						<a href="${map.imageUrl}${car.userInfo.drivingLicensePhoto}" class="FixImage CarImage FancyBoxImg"
						   data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${car.userInfo.drivingLicensePhoto}"></a>
						<div class="CarInfo GoodInfo">
							<div class="CarTitle">${car.userInfo.licenseNum}
								<a style="font-size: 12px" class="ListBtn" href="/carSource/edit?id=${car.userInfo.mainCarInfoId}#EditDrivingLicensePhoto">查看行驶证</a>
							</div>
							<div class="CarOtherInfo">
								<div class="CarOtherInfoItem">
									<span>VIN:${car.userInfo.carVin}</span>
								</div>
								<div class="CarOtherInfoItem">
                                    <span>
                                    <c:if test="${car.userInfo.mainCarTitle != null}">
                                        ${car.userInfo.mainCarTitle}
                                    </c:if>
                                    <c:if test="${car.userInfo.mainCarTitle == null}">
                                        ${car.userInfo.carModelName}
                                    </c:if>
                                    </span>
								</div>
								<div class="CarOtherInfoItem">
                                    <span>首次上牌时间: <span class="FormatDateShort">${car.userInfo.firstLicenseDate}</span></span>
								</div>
							</div>
						</div>
					</td>
					<td>
                        <div>${car.userInfo.realName}</div>
                        <div>${car.userInfo.mobile}</div>
                        <div>保险生效:<fmt:formatDate value="${car.renewal.orderBeginTime}" type="date" pattern="yyyy-MM-dd HH:mm"/></div>
                        <div><span>提车日期：<fmt:formatDate value="${car.userInfo.takeCarTime}" type="date" pattern="yyyy-MM-dd HH:mm"/></span></div>
                    </td>
                    <td>
                        <div >
                            <c:if test="${car.renewal.renewalStatus == '即将到期'}">
                                <span class="MainStatus StatusAboutToExpire">${car.renewal.renewalStatus}</span>
                            </c:if>
                            <c:if test="${car.renewal.renewalStatus == '已过期'}">
                                <span class="MainStatus StatusExpired">${car.renewal.renewalStatus}</span>
                            </c:if>
                            <c:if test="${car.renewal.renewalStatus == '在保状态'}">
                                <span class="MainStatus StatusOnInsurance">${car.renewal.renewalStatus}</span>
                            </c:if>
                            <c:if test="${car.renewal.renewalStatus == '已续保'}">
                                <span class="MainStatus StatusAlreadyInsurance">${car.renewal.renewalStatus}</span>
                            </c:if>
                            <c:if test="${car.renewal.renewalStatus == '即将到期' || car.renewal.renewalStatus == '已过期'}">
                                <span class="SubStatus">未续保</span>
                            </c:if>
                        </div>
                        <div class="FormatRestTime">${car.renewal.restTime}</div>
						<div>
                            <c:if test="${car.renewal.insuranceTime != null }">
                                <fmt:formatDate value="${car.renewal.insuranceTime}" type="date" pattern="yyyy-MM-dd HH:mm"/>到期
                            </c:if>
                        </div>
                        <div>${car.renewal.quoteStatus}</div>
                    </td>
					<td>
                        <c:if test="${car.renewal.renewalStatus == '已续保'}">
                            <a href="javascript:;"  class="ListBtn GetInsuranceMsg" data-carid="${car.userInfo.mainCarInfoId}">查看续保保单</a>
                        </c:if>
                        <c:if test="${car.renewal.renewalStatus == '在保状态'}">
                            <a href="javascript:;" class="ListBtn GetInsuranceMsg" data-carid="${car.userInfo.mainCarInfoId}">查看当前保单</a>
                        </c:if>
                        <c:if test="${(car.renewal.renewalStatus == '即将到期' || car.renewal.renewalStatus == '已过期') && car.renewal.quoteStatus == '保险未报价'}">
                            <div class="NotInsuranceQuoteBtnWrapper">
                                <a class="ListBtn NotInsuranceQuote InsuranceQuoteBtn" data-carid="${car.userInfo.mainCarInfoId}"
                                   data-dialog=".DialogNotInsuranceQuote" href="javascript:;"
                                   data-cartitle="${car.userInfo.mainCarTitle}">报价</a>
                            </div>
                        </c:if>
                        <c:if test="${(car.renewal.renewalStatus == '即将到期' || car.renewal.renewalStatus == '已过期') && car.renewal.quoteStatus == '保险已报价'}">
                            <div class="NotInsuranceQuoteBtnWrapper">
                                <a class="ListBtn NotInsuranceQuote InsuranceQuoteBtn" data-carid="${car.userInfo.mainCarInfoId}"
                                   data-dialog=".DialogNotInsuranceQuote" href="javascript:;"
                                   data-cartitle="${car.userInfo.mainCarTitle}">再次报价</a>
                            </div>
                            <a class="ListBtn GetRenewalQuoteInfos ShowInsuranceListAjax" data-carid="${car.userInfo.mainCarInfoId}" href="javascript:;" data-cartitle="${car.userInfo.mainCarTitle}">续保</a>
                        </c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/carInsurance/renewalList?${map.params}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>
		</div>
	</div>
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<div class="OverLay DialogNotInsuranceQuote">
    <div class="Dialog">
        <div class="DialogTitle">
            <div class="DialogClose" data-close=".DialogNotInsuranceQuote"><img src="/resources/image/DialogClose.png" alt=""></div>
        </div>
        <div class="DialogContent InsuranceQuoteContentWrapper">
            <h2></h2>
            <form action="/carInsurance/submitRenewalQuote" class="QuoteForm NotInsuranceQuoteForm">
                <input type="hidden" name="carId">
                <div class="FormGroup InsuranceQuoteFormGroup">
                    <label>报价公司</label>
                    <select class="CustomSelect LinkSelect" data-link="quoterId" data-url="/insurance/quoter/selectList?companyId=" name="company">
                        <c:forEach items="${map.companyList}" var="company" >
                            <option value="${company.id}">${company.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="FormGroup InsuranceQuoteFormGroup">
                    <label>选择报价人</label>
                    <select class="CustomSelect" name="quoterId" id="quoterId"></select>
                </div>
                <div class="BtnGroup">
                    <%--<div><a class="ListBtn PreViewInsuranceQuote" data-url="/carInsurance/edit?">预览报价填写单</a></div>--%>
                    <a href="javascript:;" data-form=".NotInsuranceQuoteForm" class="Btn BtnPrimary SubmitInsuranceQuote NotSuccessInsurance">提交报价单</a>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="RenewalDialogWrapper">
    <div class="OverLay DialogOnInsuranceQuote">
        <div class="Dialog">
            <div class="DialogTitle">
                <h1 class="PayInsuranceTitle">选择保项</h1>
                <div class="DialogClose" data-close=".DialogOnInsuranceQuote"><img src="/resources/image/DialogClose.png" alt=""></div>
            </div>
            <div class="DialogContent InsuranceQuoteContentWrapper">
                <h2></h2>
                <form action="/carInsurance/chooseQuote" id="ChoseInsuranceForm">
                    <ul class="InsuranceListWrapper ClearFix"></ul>
                    <div class="BtnGroup" style="padding-bottom: 25px;margin-top: 0">
                        <a href="javascript:;" class="Btn BtnPrimary ChoseInsurance">提 交</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="OverLay DialogHasInsuranceQuote">
        <div class="Dialog">
            <div class="DialogTitle">
                <h1 class="PayInsuranceTitle">确认保项</h1>
                <div class="DialogClose" data-close=".DialogHasInsuranceQuote"><img src="/resources/image/DialogClose.png" alt=""></div>
            </div>
            <div class="DialogContent InsuranceQuoteContentWrapper InsuranceQuoteFromContent">
                <form action="/carInsurance/confirmQuote" id="HasInsuranceQuoteForm">
                    <div class="FromInner">
                        <div class="Waiting">加载中...</div>
                    </div>
                    <div class="BtnGroup">
                        <a href="javascript:;" class="Btn BtnPrimary SubmitQuote ConfirmInsuranceInfo Disabled" data-form="#HasInsuranceQuoteForm">提 交</a>
                        <a href="javascript:;" class="Btn BtnPrimarySecondary ChangeReadOnly">修 改</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="OverLay DialogRenewalPayInsurance">
        <div  class="Dialog PayInsuranceDialog">
            <div class="DialogTitle">
                <h1 class="PayInsuranceTitle">支付车险续保订单</h1>
                <div class="DialogClose" data-close=".DialogRenewalPayInsurance"><img src="/resources/image/DialogClose.png" alt=""></div>
            </div>
            <form action="/carInsurance/orderRenewalPay" novalidate>
                <div class="PayInsuranceInfoWrapper">
                    <div class="AjaxInfo">
                    </div>

                    <table class="Table FormTable">
                        <tr>
                            <td ><span class="LabelNeed">车险生效时间</span></td>
                            <td>
                                <div class="FormItem ClearFix" style="margin-bottom: 0">
                                    <div class="FormLayout FormItemControl">
                                        <div class="DatePickerWrapper">
                                            <input placeholder="请选择时间" name="orderBeginTime" class="CustomInput DatePicker OrderBeginTime" data-format="yyyy-mm-dd"/>
                                        </div>
                                    </div>
                                </div></td>
                            <td><input type="checkbox" /></td>
                        </tr>
                    </table>
                    <div class="ActionArea ClearFix Center">
                        <button type="submit" class="Btn BtnPrimary SubmitInsurancePayInfo  SubmitRenewalInsurancePayInfo Disabled" data-pending="保存中...">提交</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="OverLay DialogShowRenewal">
        <div class="Dialog" style="width: 730px">
            <div class="DialogTitle">
                <h1 class="PayInsuranceTitle">查看保单</h1>
                <div class="DialogClose" data-close=".DialogShowRenewal"><img src="/resources/image/DialogClose.png" alt=""></div>
            </div>
            <div class="DialogContent InsuranceQuoteContentWrapper InsuranceQuoteFromContent">
                <%--<form action="/carInsurance/confirmQuote" id="HasInsuranceQuoteForm">--%>
                    <div class="FromInner" style="padding-bottom: 20px">
                        <div class="Waiting">加载中...</div>
                    </div>
                    <%--<div class="BtnGroup">--%>
                        <%--<a href="javascript:;" class="Btn BtnPrimary SubmitQuote ConfirmInsuranceInfo Disabled" data-form="#HasInsuranceQuoteForm">提 交</a>--%>
                        <%--<a href="javascript:;" class="Btn BtnPrimarySecondary ChangeReadOnly">修 改</a>--%>
                    <%--</div>--%>
                <%--</form>--%>
            </div>
        </div>
    </div>
</div>
<%@include file="../../lib/footer.jsp" %>
