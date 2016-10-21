<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="确认商品"></c:set>

<c:if test="${goods == 0}">
	<c:set var="sidebarOn" value="上架中的商品"></c:set>
</c:if>
<c:if test="${list.workStatus != 0}">
	<c:set var="sidebarOn" value="全部商品"></c:set>
</c:if>

<c:set var="newUrl" value="/carGoods/new"></c:set>
<c:set var="newName" value="新增商品"></c:set>
<c:set var="navOn" value="商品管理"></c:set>
<%@include file="../lib/header.jsp" %>
<%@include file="../lib/nav.jsp" %>

<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/carGoods/list?status=20">商品</a> <i class="fa fa-angle-right"></i></li>
				<li><span>商品管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>新增商品</span></li>
            </ul>
			<div class="GoodsStepWrapper">
				<div class="GoodsStep GoodsArrow">1、选择车源</div>
				<div class="GoodsStep GoodsArrow">2、完善商品信息</div>
				<div class="GoodsStep GoodsStepOn">3、确认商品信息</div>
			</div>
			<div class="DetailWrapper">
				<div class="ShowGroupWrapper">
					<div class="ShowTitle">商品标题及价格信息</div>
					<ul class="ClearFix ShowGroup">
						<li>
							<label>车辆标题：</label>
							<span>${map.carInfo.carTitle}</span>
						</li>
						<li>
							<label>车辆所在城市：</label>
							<span>${map.carInfo.carCityName}</span>
						</li>
						<li>
							<label>车主售价：</label>
							<span>${map.carInfo.salePrice/10000}万元</span>
						</li>
						<li>
							<label>同款新车（含税）：</label>
							<span>${map.carInfo.newCarGuidancePrice/10000}万元</span>
						</li>
						<li>
							<label>劲省：</label>
							<span>${(map.carInfo.newCarGuidancePrice-map.carInfo.salePrice)/10000}万元</span>
						</li>
						<li>
							<label>品质保障服务费：</label>
							<span>${map.carInfo.servicePrice}元</span>
						</li>

					</ul>
				</div>
				<div class="ShowGroupWrapper">
					<div class="ShowTitle">车辆档案信息</div>
					<ul class="ClearFix ShowGroup">
						<li>
							<label>里程：</label>
							<span>${map.carInfo.runKm/10000}万公里</span>
						</li>
						<li>
							<label>首次上牌城市：</label>
							<span>${map.carInfo.firstLicenseCityName}</span>
						</li>
						<li>
							<label>档位：</label>
							<span>${map.carInfo.abbreviation}</span>
						</li>
						<li>
							<label>排量：</label>
							<span>${map.carInfo.displacement}</span>
						</li>
						<li>
							<label>外观颜色：</label>
							<span>${map.carInfo.carColor}</span>
						</li>
						<li>
							<label>内饰颜色：</label>
							<span>${map.carInfo.carInteriorColor}</span>
						</li>
						<li>
							<label>生产厂商：</label>
							<span>${map.carInfo.brandName}(${map.carInfo.subBrandName})</span>
						</li>
						<li>
							<label>年检到期日：</label>
							<span class="FormatDate">${map.carInfo.takeCarTime}</span>
						</li>
						<%--<li>--%>
							<%--<label>交强险到期日：</label>--%>
							<%--<span>${map.carInfo.timeOfMaturity}</span>--%>
						<%--</li>--%>
					</ul>
				</div>
				<div class="ShowGroupWrapper">
					<div class="ShowTitle">实景图片</div>
					<ul class="ClearFix ShowRealImage">
						<c:forEach items="${map.carPhoto}" var="photo">
							<c:if test="${!(empty photo)}">
								<li><img src="${map.imageUrl}${photo}"></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="FormItem ClearFix" style="text-align: center;margin-top: 20px">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<a href="javascript:;" class="Btn BtnPrimary AjaxBtn" data-msg="上架成功" data-confirm="你确定要上架?" data-pending="上架中" data-url="/carGoods/saleOnOff?id=${map.carInfo.id}&type=0">提交并上架</a>
			</div>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp" %>
