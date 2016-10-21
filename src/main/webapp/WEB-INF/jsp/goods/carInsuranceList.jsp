<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="summer" uri="/summer" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="商品/车险列表"></c:set>
<%@include file="../lib/header.jsp" %>
<c:set var="navOn" value="商品"></c:set>
<%@include file="../lib/nav.jsp" %>

<c:set var="sidebarOn" value="商品/车险列表"></c:set>
<%--<c:set var="newUrl" value="/carGoods/new?status=20"></c:set>--%>
<%--<c:set var="newName" value="新增商品"></c:set>--%>

<input type="hidden" id="MobileSiteUrl" value="${map.mobileSiteUrl}">
<div class="Main ClearFix">
	<div id="SideBar">
		<%@include file="sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/carGoods/list">商品</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车险管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>商品/车险列表</span></li>
			</ul>
			<table class="Table">
				<tr class="THead">
					<th>关联商品</th>
					<th style="width:124px;">商品状态</th>
					<th style="width:124px;">车险状态</th>
					<th>报价状态</th>
					<th style="width:124px;">操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="car">
				<tr>
					<td class="CarInfoWrapper GoodsInfoWrapper ClearFix">
						<%--<a href="${map.imageUrl}${car.carInfoDTO.drivingLicensePhoto}" class="FixImage CarImage FancyBoxImg"--%>
						   <%--data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${car.carInfoDTO.drivingLicensePhoto}"></a>--%>
						<a href="${map.imageUrl}${car.carInfoDTO.carMainPhoto}" class="FixImage CarImage FancyBoxImg"
						   data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${car.carInfoDTO.carMainPhoto}"></a>
						<div class="CarInfo GoodInfo">
							<div class="CarTitle">${car.carInfoDTO.carTitle}</div>
							<div class="CarOtherInfo">
								<div class="CarOtherInfoItem">
									<span><span class="FormatDateShort">${car.carInfoDTO.firstLicenseDate}</span>上牌</span>
									<span>${car.carInfoDTO.runKm/10000}万公里</span>
									<span>${car.carInfoDTO.carColor}</span>
									<span>${car.carInfoDTO.displacement}</span>
								</div>
								<div class="CarOtherInfoItem">
                                    <span>创建：${fn:substring(car.carInfoDTO.createdAt,0,16)}</span>
								</div>
								<div class="CarOtherInfoItem">
									<span>保险状态更新：${fn:substring(car.updateTime,0,16)}</span>
								</div>
							</div>
						</div>
					</td>
					<td>
                        <c:if test="${car.carInfoDTO.carStatus == 10}">已下架</c:if>
                        <c:if test="${car.carInfoDTO.carStatus == 20}">上架中</c:if>
                        <c:if test="${car.carInfoDTO.carStatus == 30}">已锁定</c:if>
                        <c:if test="${car.carInfoDTO.carStatus == 40}">已售出</c:if>
                        <c:if test="${car.carInfoDTO.carStatus == 50}">已交付</c:if>
                    </td>
                    <td>
                        <c:if test="${car.quoterStatus == 1}">报价中</c:if>
                        <c:if test="${car.quoterStatus == 2}">已报价</c:if>
                        <c:if test="${car.quoterStatus == 3}">已确认报价</c:if>
                        <c:if test="${car.quoterStatus == 0}">待报价</c:if>
                    </td>
					<td>
                        <c:if test="${fn:length(car.infoDTOList) == 0}">
                            <c:if test="${car.carDocumentDTO.drivingLicensePhoto == ''}">
                                <div>暂无报价条件</div>
                                请上传车辆行驶证照片
                            </c:if>
                            <c:if test="${car.carDocumentDTO.drivingLicensePhoto != ''}">
                                暂未报价
                            </c:if>
                        </c:if>
                        <c:if test="${fn:length(car.infoDTOList) > 0 }">
                            <div>收到 <span class="Price">${car.finishQuoteNum}</span> 家保险报价</div>
                            <ul class="InsuranceListData">
                                <c:forEach var="info" items="${car.infoDTOList}">
                                    <li>
                                        <div class="InsuranceCompany">${info.quoter.company.name}</div>
                                        <div>报价人:${info.quoter.name}</div>
                                        <div>电话: ${info.quoter.phone}</div>
                                        <div>
                                            <c:if test="${info.quoteStatus == 1}">报价中...</c:if>
                                            <c:if test="${info.quoteStatus == 2}">报价完毕</c:if>
                                        </div>
                                        <div>
                                            <a class="ListBtn ShowInsuranceDetail" data-infoid="${info.id}" href="javascript:;">查看详情</a>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                            <a class="ListBtn ShowInsuranceList" href="javascript:;" data-cartitle="${car.carInfoDTO.carTitle}">查看详情</a>
                        </c:if>
					</td>
					<td class="">
                        <c:if test="${car.carDocumentDTO.drivingLicensePhoto == ''}">
                            <a class="ListBtn" href="/carSource/edit?id=${car.carInfoDTO.id}#EditDrivingLicensePhoto">去上传行驶证</a>
                        </c:if>
                        <c:if test="${car.carDocumentDTO.drivingLicensePhoto != ''}">
                            <div class="NotInsuranceQuoteBtnWrapper">
                                <a class="ListBtn NotInsuranceQuote InsuranceQuoteBtn" data-carid="${car.carInfoDTO.id}"
                                   data-dialog=".DialogNotInsuranceQuote" href="javascript:;"
                                   data-cartitle="${car.carInfoDTO.carTitle}">发起报价</a>
                            </div>
                        </c:if>
					</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/carInsurance/list?${map.params}"></c:set>
			<%@include file="../lib/pagination.jsp" %>
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
			<form action="/carInsurance/submitQuote" class="QuoteForm NotInsuranceQuoteForm">
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
<div class="OverLay DialogOnInsuranceQuote">
	<div class="Dialog">
		<div class="DialogTitle">
			<div class="DialogClose" data-close=".DialogOnInsuranceQuote"><img src="/resources/image/DialogClose.png" alt=""></div>
		</div>
		<div class="DialogContent InsuranceQuoteContentWrapper">
			<h2></h2>
            <ul class="InsuranceListWrapper ClearFix"></ul>
		</div>
	</div>
</div>

<div class="OverLay DialogHasInsuranceQuote">
	<div class="Dialog">
		<div class="DialogTitle">
			<div class="DialogClose" data-close=".DialogHasInsuranceQuote"><img src="/resources/image/DialogClose.png" alt=""></div>
		</div>
		<div class="DialogContent InsuranceQuoteContentWrapper InsuranceQuoteFromContent">
			<form action="/carInsurance/editQuote" id="HasInsuranceQuoteForm">
				<div class="FromInner">
					<div class="Waiting">加载中...</div>
				</div>
				<div class="BtnGroup">
					<a href="javascript:;" class="Btn BtnPrimary SubmitQuote Disabled" data-form="#HasInsuranceQuoteForm">提 交</a>
					<a href="javascript:;" class="Btn BtnPrimarySecondary ChangeReadOnly">修 改</a>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp" %>
