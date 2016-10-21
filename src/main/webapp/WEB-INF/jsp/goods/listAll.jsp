<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="商品"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="商品"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="全部商品" ></c:set>
<c:set var="newUrl" value="/carGoods/new"></c:set>
<c:set var="newName" value="新增商品"></c:set>

<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/carGoods/list?status=20">商品</a> <i class="fa fa-angle-right"></i></li>
				<li><span>商品管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>全部商品</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/carGoods/list" novalidate class="MainSearchForm">
					<input name="status" type="hidden" value="${map.status}"/>
					<input id="sortInput" name="sort" type="hidden" value="${map.sort}"/>
					<input id="scInput" name="sc" type="hidden" value="${map.sc}"/>
					<div class="SearchGroup">
						<select name="carBrandId" id="carBrandId" class="CustomSelect LinkSelect" data-link="carLineId" data-url="/carSource/queryLine?carBrandId=" required value="<%= request.getParameter("carBrandId") %>">
							<option value="">全部品牌</option>
							<c:forEach var="carBrand" items="${map.carBrandList}">
								<option value="${carBrand.id}">${carBrand.brandName}</option>
							</c:forEach>
						</select>
					</div>
					<div class="SearchGroup">
						<select name="carLineId" id="carLineId" class="CustomSelect LinkedInput"  value="<%= request.getParameter("carLineId") %>">
							<option value="">全部车系</option>
						</select>
					</div>
					<div class="SearchGroup">
						<select name="runKm" id="runKm" class="CustomSelect"  value="<%= request.getParameter("runKm") %>">
							<option value="">里程不限</option>
							<option value="10000">1万公里</option>
							<option value="50000">5万公里</option>
							<option value="100000">10万公里</option>
							<option value="200000">20万公里</option>
						</select>
					</div>
					<div class="SearchGroup">
						<select name="carColor" id="carColor" class="CustomSelect"  value="<%= request.getParameter("carColor") %>">
							<option value="">颜色不限</option>
							<option value="黑色">黑色</option>
							<option value="红色">红色</option>
							<option value="深灰色">深灰色</option>
							<option value="粉红色">粉红色</option>
							<option value="银灰色">银灰色</option>
							<option value="紫色">紫色</option>
							<option value="白色">白色</option>
							<option value="蓝色">蓝色</option>
							<option value="香槟色">香槟色</option>
							<option value="绿色">绿色</option>
							<option value="黄色">黄色</option>
							<option value="咖啡色">咖啡色</option>
							<option value="橙色">橙色</option>
						</select>
					</div>
					<div class="Clear"></div>
					<div class="SearchGroup">
						<div class="DatePickerWrapper DatePickerStart">
							<input value="<%= request.getParameter("firstLicenseDateStart") != null ? request.getParameter("firstLicenseDateStart") : "" %>"
								   data-date-end-date="0d"
								   placeholder="首次上牌时间" class="CustomInput DatePicker" name="firstLicenseDateStart" id="FirstLicenseDateStart"/>
						</div>
					</div>
					<div class="SearchGroup">
						<div class="DatePickerWrapper">
							<input value="<%= request.getParameter("firstLicenseDateEnd") != null ? request.getParameter("firstLicenseDateEnd") : ""%>"
								   data-date-end-date="0d" data-start="#FirstLicenseDateStart"
								   placeholder="首次上牌时间" class="CustomInput DatePicker" name="firstLicenseDateEnd"/>
						</div>
					</div>
					<div class="SearchGroup DatePickerStart">
						<div class="DatePickerWrapper">
							<input value="<%= request.getParameter("createdAtStart") != null ? request.getParameter("createdAtStart") : ""%>"
								   data-date-end-date="0d"
								   placeholder="创建开始时间" class="CustomInput DatePicker" name="createdAtStart" id="CreatedAtStart"/>
						</div>
					</div>
					<div class="SearchGroup">
						<div class="DatePickerWrapper">
							<input value="<%= request.getParameter("createdAtEnd") != null ? request.getParameter("createdAtEnd") : ""%>"
								   data-date-end-date="0d" data-start="#CreatedAtStart"
								   placeholder="创建结束时间" class="CustomInput DatePicker" name="createdAtEnd"/>
						</div>
					</div>

					<div class="OtherSearchInfoBorder"></div>
					<div class="OtherSearchInfo">
						<div class="SortWrapper">
							<ul class="SortList">
								<li>
									<a class="SortItemWrapper" href="javascript:;" sort="createdAtByGoods">
										<span>创建时间</span>
										<c:if test="${map.sort == 'createdAtByGoods' && map.sc == 'asc'}">
											<img src="/resources/image/SortAsc.png">
										</c:if>
										<c:if test="${map.sort == 'createdAtByGoods' && map.sc == 'desc'}">
											<img src="/resources/image/SortDesc.png">
										</c:if>
									</a>
								</li>
								<li>
									<a class="SortItemWrapper" href="javascript:;" sort="salePrice">
										<span>车主售价</span>
										<c:if test="${map.sort == 'salePrice' && map.sc == 'asc'}">
											<img src="/resources/image/SortAsc.png">
										</c:if>
										<c:if test="${map.sort == 'salePrice' && map.sc == 'desc'}">
											<img src="/resources/image/SortDesc.png">
										</c:if>
									</a>
								<li>
							</ul>
						</div>
						<div class="SearchButtonWrapper ClearFix SearchButtonWrapperMore">
							<input class="CustomInput InputMarginLeft" placeholder="车辆标题/车架号" type="text" name="search" value="${map.search}"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>
			<table class="Table">
				<tr class="THead">
					<th>商品信息</th>
					<th style="width:124px;">所属店铺</th>
					<th>价格</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="goods">
					<tr>
						<td class="CarInfoWrapper GoodsInfoWrapper ClearFix">
							<a href="${map.imageUrl}${goods.carMainPhoto}" class="FixImage CarImage FancyBoxImg"
							   data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${goods.carMainPhoto}"></a>
							<div class="CarInfo GoodInfo">
								<div class="CarTitle">${goods.carTitle}
									<span class="CarIdentifyStatus">
									<c:if test="${goods.isIdentify == 1}">未鉴定</c:if>
									<c:if test="${goods.isIdentify == 0}">鉴定中</c:if>
									<c:if test="${goods.isIdentify == 2}">已鉴定</c:if>
									</span>
								</div>
								<div class="CarOtherInfo">
									<div class="CarOtherInfoItem">
										<span>${goods.firstLicenseDate}上牌</span>
										<span>${goods.runKm/10000}万公里</span>
										<span>${carInfo.carColor}</span>
										<span>${goods.displacement}</span>
										<span>${goods.abbreviation}</span>
									</div>
									<div class="CarOtherInfoItem">
										<span>${goods.subBrandName}</span>
										<span>${goods.carCityName}</span>
									</div>
									<div class="CarOtherInfoItem">
										<span>创建：${fn:substring(goods.createdAt,0,16)}</span>
										<span>更新：${fn:substring(goods.updatedAt,0,16)}</span>
									</div>
								</div>
							</div>
						</td>
						<td>${goods.shopName}</td>
						<td class="CarPriceWrapper">
							<div>车主售价：<span class="Price">${goods.salePrice/10000}万元</span></div>
							<div class="ServicePriceWrapper">服务费：<span class="Price">${goods.servicePrice}元</span></div>
						</td>
						<td style="width: 70px">
							<c:if test="${goods.carStatus == 10}">已下架</c:if>
							<c:if test="${goods.carStatus == 20}">上架中</c:if>
							<c:if test="${goods.carStatus == 30}">已锁定</c:if>
							<c:if test="${goods.carStatus == 40}">已售出</c:if>
							<c:if test="${goods.carStatus == 50}">已交付</c:if>
						</td>
						<td class="ActionWrapper">
							<a class="ListBtn BtnPreView" data-url="${map.mobileSiteUrl}/car/dts?idt=${goods.carIdentity}" href="javascript:;">预览</a>
							<c:if test="${CurrentUser.check('/carGoods/edit')}">
								<a class="ListBtn" href="/carGoods/edit?id=${goods.id}">编辑</a>
							</c:if>
							<c:if test="${goods.carStatus == 10 && CurrentUser.check('/carGoods/saleOnOff')}">
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="上架成功" data-confirm="你确定要上架?" data-pending="上架中" data-url="/carGoods/saleOnOff?id=${goods.id}&type=0">上架</a>
							</c:if>
							<c:if test="${goods.carStatus == 20 && CurrentUser.check('/carGoods/saleOnOff')}">
								<div class="SelectWrapper">
									<select name="" id="" class="CustomSelectText PrintSelect">
										<option value="">下架</option>
										<option value=".InSaleOnOff">内部下架</option>
										<option value=".OutSaleOnOff">外部交易</option>
										<option value=".OtherSaleOnOff">其它</option>
									</select>
									<a href="javascript:;" class="ListBtn AjaxBtnInput AjaxBtn InSaleOnOff" style="position: absolute;z-index: -1;opacity: 0" data-msg="下架成功" data-dialogType="input" data-title="请输入您的下架理由" data-pending="下架中" data-url="/carGoods/saleOnOff?id=${goods.id}&type=1&saleOnOffType=1&saleOnOffContent=">下架</a>
									<a href="javascript:;" class="ListBtn AjaxBtnInput AjaxBtn OutSaleOnOff" style="position: absolute;z-index: -1;opacity: 0" data-msg="下架成功" data-dialogType="input" data-title="请输入您的下架理由" data-pending="下架中" data-url="/carGoods/saleOnOff?id=${goods.id}&type=1&saleOnOffType=2&saleOnOffContent=">下架</a>
									<a href="javascript:;" class="ListBtn AjaxBtnInput AjaxBtn OtherSaleOnOff" style="position: absolute;z-index: -1;opacity: 0" data-msg="下架成功" data-dialogType="input" data-title="请输入您的下架理由" data-pending="下架中" data-url="/carGoods/saleOnOff?id=${goods.id}&type=1&saleOnOffType=3&saleOnOffContent=">下架</a>
								</div>
							</c:if>

							<div class="SelectWrapper">
								<select name="" id="" class="CustomSelectText PrintSelect">
									<option value="">打印</option>
									<option value=".PrintPriceTag">打印首页价签</option>
									<option value=".PrintCarParam">打印车辆配置</option>
									<option value=".PrintIdentify">打印鉴定报告</option>
									<option value=".PrintQualityAssurance">打印保修条例</option>
								</select>
								<a target="_blank" href="/print/carPriceTagPage?carInfoId=${goods.id}" class="PrintPriceTag" style="position: absolute;z-index: -1;opacity: 0">打印价签</a>
								<a target="_blank" href="/print/carConfigPage?id=${goods.carModelId}" class="PrintCarParam" style="position: absolute;z-index: -1;opacity: 0">打印车辆参数配置</a>
								<a target="_blank" href="/print/printCarIdentifyDetail?carInfoId=${goods.id}" class="PrintIdentify" style="position: absolute;z-index: -1;opacity: 0">打印鉴定报告</a>
								<a target="_blank" href="/print/printQualityAssurance" class="PrintQualityAssurance" style="position: absolute;z-index: -1;opacity: 0">打印保修条例</a>
							</div>
							<br/>

							<c:if test="${CurrentUser.check('/print/printCarQRCode')}">
								<a class="ListBtn" target="_blank" href="/print/printCarQRCode?carInfoId=${goods.id}">打印二维码</a>
							</c:if>

							<c:if test="${goods.carStatus == 20}">
							<div class="SelectWrapper">
								<select name="" class="CustomSelectText PrintSelect">
									<option value="">下单</option>
									<option value=".PrintPriceTag">全款下单</option>
									<option value=".PrintCarParam">贷款下单</option>
								</select>
								<a target="_blank" href="/deal/getOrderCarAndInsuranceInfo?carId=${goods.id}&orderType=1" class="PrintPriceTag" style="position: absolute;z-index: -1;opacity: 0">贷款下单</a>
								<a target="_blank" href="/deal/getOrderCarAndInsuranceInfo?carId=${goods.id}&orderType=2" class="PrintCarParam" style="position: absolute;z-index: -1;opacity: 0">全款下单</a>
							</div>
							</c:if>

							<%--<c:if test="${goods.insuranceQuoteStatus == 0 && CurrentUser.check('/carInsurance/noticeQuote')}">--%>
								<%--<div class="NotInsuranceQuoteBtnWrapper">--%>
									<%--<a class="ListBtn NotInsuranceQuote InsuranceQuoteBtn" data-carid="${goods.id}" data-dialog=".DialogNotInsuranceQuote" href="javascript:;" data-cartitle="${goods.carTitle}">车险未报价</a>--%>
									<%--<select>--%>
										<%--<c:forEach var="item" items="${map.insuranceList}">--%>
											<%--<option value="${item.id}">${item.quotePersonName} ${item.quotePersonPhone}</option>--%>
										<%--</c:forEach>--%>
									<%--</select>--%>
								<%--</div>--%>
							<%--</c:if>--%>
							<%--<c:if test="${goods.insuranceQuoteStatus == 1 && CurrentUser.check('/carInsurance/noticeQuote')}">--%>
								<%--<a class="ListBtn OnInsuranceQuote InsuranceQuoteBtn" data-dialog=".DialogOnInsuranceQuote" data-cartitle="${goods.carTitle}" data-carid="${goods.id}" href="javascript:;">车险报价中</a>--%>
							<%--</c:if>--%>
							<%--<c:if test="${goods.insuranceQuoteStatus == 2 && CurrentUser.check('/carInsurance/noticeQuote')}">--%>
								<%--<a class="ListBtn HasInsuranceQuote InsuranceQuoteBtn" data-dialog=".DialogHasInsuranceQuote" data-carid="${goods.id}" href="javascript:;">车险已报价</a>--%>
							<%--</c:if>--%>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/carGoods/list?${map.params}"></c:set>
			<%@include file="../lib/pagination.jsp"%>

		</div>
	</div>
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<%@include file="../lib/footer.jsp"%>
