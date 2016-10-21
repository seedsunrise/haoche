<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<table class="GroupTable">
	<tr>
		<td class="TableGroupTitle">
			<div class="GroupTitle">商品基本信息</div>
		</td>
		<td class="TableGroupContent">
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle"><span class="LabelNeed">商品标题：</span></label>
				<div class="FormLayout FormItemControl">
					<input style="width: 300px" class="FormInput" type="text" id="carTitle" name="carTitle" value="${map.carInfo.carTitle}" required>
				</div>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout">所在城市：</label>
				<span class="SpanInfo">${map.carInfo.carCityName}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="shopId"><span class="LabelNeed">门店：</span></label>
				<c:forEach var="item" items="${map.shopList}">
					<c:choose>
						<c:when test="${map.carInfo.shopId == item.id}">
							<input type="hidden" name="shopName" class="shopName" value="${item.shopName}">
							<input type="hidden" id="shopAddress" name="shopAddress" value="${item.shopAddress}">
						</c:when>
					</c:choose>
				</c:forEach>
				<div class="FormLayout FormItemControl">
					<select value="${map.carInfo.shopId}" name="shopId"
					        id="shopId" class="CustomSelect LinkedInput LinkShopAddress"
					        data-input="shopName" required>
						<c:forEach var="item" items="${map.shopList}">
							<option value="${item.id}" data-address="${item.shopAddress}">${item.shopName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td class="TableGroupTitle">
			<div class="GroupTitle">商品档案信息</div>
		</td>
		<td class="TableGroupContent">
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">里程：</label>
				<span class="SpanInfo"><span class="RunKmFormate">${map.carInfo.runKm/10000}</span>万公里</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">排量：</label>
				<span class="SpanInfo">${map.carInfo.displacement}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">档位：</label>
				<span class="SpanInfo">${map.carInfo.abbreviation}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">生产厂商：</label>
				<span class="SpanInfo">${map.carInfo.subBrandName}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">首次上牌城市：</label>
				<span class="SpanInfo">${map.carInfo.firstLicenseCityName}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">外观颜色：</label>
				<span class="SpanInfo">${map.carInfo.carColor}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">内饰颜色：</label>
				<span class="SpanInfo">${map.carInfo.carInteriorColor}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">年检到期日：</label>
				<span class="SpanInfo FormatDate">${map.carDocument.timeOfMaturity}</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="carTitle">交强险到期日：</label>
				<span class="SpanInfo FormatDate">${map.carDocument.annualInspection}</span>
			</div>
		</td>
	</tr>
	<tr>
		<td class="TableGroupTitle">
			<div class="GroupTitle">商品图片信息</div>
		</td>
		<td class="TableGroupContent">
			<div class="FormItem ClearFix GetCarPhotoNumber" data-url="/carGoods/totalCarPhotoNum?carInfoId=${map.carInfo.id}">
				<span>当前已上传<span class="CarPhotoNumber">0</span>张图片 <a target="_blank" href="/carGoods/carPhoto?carInfoId=${map.carInfo.id}">点击进入图片管理页</a> </span>
			</div>
		</td>
	</tr>
	<tr>
		<td class="TableGroupTitle">
			<div class="GroupTitle">商品价格信息</div>
		</td>
		<td class="TableGroupContent">
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="salePriceClone"><span class="LabelNeed">车主售价：</span></label>
				<div class="FormLayout FormItemControl">
					<input type="hidden" id="salePrice" name="salePrice" value="${map.carInfo.salePrice}">
					<input class="FormInput LinkSalePrice LinkPrice" type="number" min="0" id="salePriceClone" name="salePriceClone" value="${map.carInfo.salePrice/10000}" required> <span class="Unit">万元</span>
				</div>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="newCarGuidancePriceClone"><span class="LabelNeed">同款新车(含税)：</span></label>
				<div class="FormLayout FormItemControl">
					<input type="hidden" id="newCarGuidancePrice" name="invoicePrice" value="${map.carInfo.newCarGuidancePrice}">
					<input class="FormInput LinkNewCarGuidancePrice LinkPrice" type="number" min="0" id="newCarGuidancePriceClone" name="newCarGuidancePriceClone" value="${map.carInfo.newCarGuidancePrice/10000}" required> <span class="Unit">万元</span>
				</div>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout">劲省：</label>
				<span class="SpanInfo LinkSavePrice">${(map.carInfo.newCarGuidancePrice-map.carInfo.salePrice)/10000}</span> <span class="Unit">万元</span>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" for="servicePriceClone"><span class="LabelNeed">品质保障服务费：</span></label>
				<div class="FormLayout FormItemControl">
					<input type="hidden" id="servicePrice" name="servicePrice" value="${map.carInfo.servicePrice}">
					<input class="FormInput LinkServicePrice LinkPrice LinkPriceYuan" type="number" id="servicePriceClone" name="servicePriceClone" value="${map.carInfo.servicePrice == 0 ? map.carInfo.salePrice * 0.03 : map.carInfo.servicePrice }" required> <span class="Unit">元</span>
				</div>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout" style="width: 185px">是否提供一年不限公里质保：</label>
				<div class="FormLayout FormItemControl">
					<input type="hidden" value="${map.carInfo.isExtendedWarranty}" name="isExtendedWarranty">
					<div class="Btn YesNoIsExtendedWarranty Yes <c:if test="${map.carInfo.isExtendedWarranty == 0}">BtnPrimary</c:if>">是</div>
					<div class="Btn YesNoIsExtendedWarranty No <c:if test="${map.carInfo.isExtendedWarranty == 1}">BtnPrimary</c:if>">否</div>
				</div>
			</div>
			<div class="FormItem ClearFix">
				<label class="FormLayout">总价：</label>
				<span class="SpanInfo LinkTotalPrice">${(map.carInfo.salePrice + map.carInfo.servicePrice)/10000}</span><span class="Unit">万元</span>
			</div>
			<c:choose>
				<c:when test="${map.carInfo.carStatus eq 20}">
					<input type="hidden" name="type" value="0">
				</c:when>
				<c:otherwise>
					<input type="hidden" name="type" value="1">
				</c:otherwise>
			</c:choose>

		</td>
	</tr>
</table>