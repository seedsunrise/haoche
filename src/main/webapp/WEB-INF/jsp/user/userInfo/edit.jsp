<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="录入车主"></c:set>
<c:set var="sidebarOn" value="车主服务"></c:set>
<c:set var="newUrl" value="/user/userInfo/editPage"></c:set>
<c:set var="newName" value="录入车主"></c:set>
<c:set var="navOn" value="车主服务"></c:set>

<%@include file="../../lib/header.jsp" %>
<%@include file="../../lib/nav.jsp" %>

<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/user/list">车主服务</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车主管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>车主概览</span> <i class="fa fa-angle-right"></i></li>
				<li>
                    <span>
                        <c:if test="${empty map.userInfo}">新增车主</c:if>
                        <c:if test="${ !(empty map.userInfo)}">编辑车主</c:if>
                    </span>
				</li>
			</ul>
			<form action="/user/userInfo/edit" method="post"
			      class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo"
			      novalidate>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="id" value="${map.userInfo.id}"/>
				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">车主基本信息<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
							</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="realName" class="FormLayout"><span class="LabelNeed">车主姓名：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="realName" name="realName"
									       value="${map.userInfo.realName}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="mobile" class="FormLayout"><span class="LabelNeed">手机号：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="11" type="text" id="mobile" name="mobile"
										   value="${map.userInfo.mobile}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="address" class="FormLayout"><span class="">住址：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="40" type="text" id="address" name="address"
										   value="${map.userInfo.address}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="identityCardNum" class="FormLayout"><span class="">身份证号：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="18" type="text" id="identityCardNum" name="identityCardNum"
										   value="${map.userInfo.identityCardNum}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="drivingLicensePhoto" class="FormLayout">行驶证照片：</label>
								<div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
									<input image-number-limit-msg="车辆铭牌照片" image-number-limit="4" class="ImageSourceUrl"
										   type="hidden" id="drivingLicensePhoto" name="drivingLicensePhoto"
										   value="${map.userInfo.drivingLicensePhoto}">
									<div class="PreShowList">
									</div>
									<div class="UploadBtnWrapper">
										<input class="FileUpload Multiple" type="file" name="upload_file"
											   data-url="/index.php/upload/do_upload_fdfs" multiple>
										<a class="Btn" href="javascript:;">上传图片</a>
									</div>
								</div>
							</div>

						</td>
					</tr>
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">车辆基本信息<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
							</div>
						</td>
						<td class="TableGroupContent">
							<input type="hidden" value="${map.userInfo.mainCarInfoId}" name="mainCarInfoId">
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carBrandId"><span class="LabelNeed">车辆品牌：</span></label>
								<input type="hidden" value="${map.userInfo.carBrandName}" name="carBrandName"
									   class="CarBrandName">
								<div class="FormLayout FormItemControl">
									<select name="carBrandId" id="carBrandId"
											class="CustomSelect LinkedInput LinkSelect" data-link="carSubBrandId"
											data-url="/system/carsubbrand/getCarSubBrandByCarBrandId?id="
											data-input="CarBrandName" value="${map.userInfo.carBrandId}" required>
										<option value="">请选择</option>
										<c:forEach var="item" items="${map.carBrandList}">
											<option value="${item.id}">${item.brandName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carSubBrandId"><span
										class="LabelNeed">生产厂商：</span></label>
								<input type="hidden" value="${map.userInfo.carSubBrandName}" name="carSubBrandName"
									   class="CarSubBrandName">
								<div class="FormLayout FormItemControl">
									<select name="carSubBrandId" id="carSubBrandId"
											class="CustomSelect LinkedInput LinkSelect" data-link="carLineId"
											data-url="/system/carline/getCarLineListByCarSubBrandId?id="
											data-input="CarSubBrandName" value="${map.userInfo.carSubBrandId}"
											required>
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carLineId"><span class="LabelNeed">车辆车系：</span></label>
								<input type="hidden" value="${map.userInfo.carLineName}" name="carLineName"
									   class="LineName">
								<div class="FormLayout FormItemControl">
									<select name="carLineId" id="carLineId" class="CustomSelect LinkedInput LinkSelect"
											data-link="carModelId"
											data-url="/system/carmodel/getCarModelListByCarLineId?id="
											data-input="LineName" value="${map.userInfo.carLineId}" required>
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carModelId"><span class="LabelNeed">车辆车型：</span></label>
								<input type="hidden" value="${map.userInfo.carModelName}" name="carModelName"
									   class="ModelName">
								<div class="FormLayout FormItemControl">
									<select name="carModelId" id="carModelId" class="CustomSelect LinkedInput"
											data-input="ModelName" value="${map.userInfo.carModelId}" required>
										<option value="">请选择</option>
									</select>
								</div>
							</div>


							<div class="FormItem ClearFix">
								<label for="carVin" class="FormLayout">车辆缩略图：</label>
								<div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
									<input image-number-limit-msg="车辆铭牌照片" image-number-limit="4" class="ImageSourceUrl"
									       type="hidden" id="nameplatePhoto" name="carMainPhoto"
									       value="${map.userInfo.carMainPhoto}">
									<div class="PreShowList">
										<input type="hidden" name="imagePreFix" id="ImagePreFix"
										       value="${map.imageUrl}">
									</div>
									<div class="UploadBtnWrapper">
										<input class="FileUpload Multiple" type="file" name="upload_file"
										       data-url="/index.php/upload/do_upload_fdfs" multiple>
										<a class="Btn" href="javascript:;">上传图片</a>
									</div>
								</div>
							</div>

							<div class="FormItem ClearFix">
								<label for="licenseNum" class="FormLayout"><span class="LabelNeed">车牌号：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="7" type="text" id="licenseNum" name="licenseNum"
										   value="${map.userInfo.licenseNum}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carColor"><span class="">车身颜色：</span></label>
								<div class="FormLayout FormItemControl">
									<select value="${map.userInfo.carColor}" name="carColor" id="carColor"
											class="CustomSelect" data-input="carColor">
										<option value="">请选择</option>
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
										<option value="棕色">棕色</option>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="carVin" class="FormLayout"><span class="">VIN码：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="carVin" name="carVin"
										   value="${map.userInfo.carVin}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="licenseTime">首次上牌时间：</label>
								<div class="FormLayout FormItemControl FormDatePickerWrapper">
									<input class="FormInput DatePicker DatePickerShort" type="text"
										   id="licenseTime" name="licenseTime" value="<fmt:formatDate value="${map.userInfo.firstLicenseDate}" pattern="yyyy年MM月dd日"/>">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="runKm" class="FormLayout"><span class="">提车时公里数（万公里）：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="number"  id="runKm" name="runKmParameter"
										   value="<fmt:formatNumber type="number" value="${map.userInfo.runKm/10000}" pattern="0.0" maxFractionDigits="1"/>">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="takeTime"><span class="LabelNeed">提车日期：</span></label>
								<div class="FormLayout FormItemControl FormDatePickerWrapper">
									<input class="FormInput DatePicker DatePickerShort" type="text"
										   id="takeTime" name="takeTime" value="<fmt:formatDate value="${map.userInfo.takeCarTime}" pattern="yyyy年MM月dd日"/>" required>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">成交信息<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
							</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="salePriceReal" class="FormLayout"><span class="LabelNeed">实际成交价（元）：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="salePriceReal" name="salePriceReal"
										   value="${empty map.userInfo.salePriceReal ? 0 : map.userInfo.salePriceReal}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="servicePrice" class="FormLayout"><span class="LabelNeed">乾坤服务费（元）：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="servicePrice" name="servicePrice"
										   value="${empty map.userInfo.servicePrice ? 0 : map.userInfo.servicePrice}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="otherFees" class="FormLayout"><span class="LabelNeed">加装及其他（元）：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="number" min="0" id="otherFees" name="otherFees"
										   value="${empty map.userInfo.otherFees ? 0 : map.userInfo.otherFees}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="insurace" class="FormLayout"><span class="LabelNeed">车险（元）：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="number" min="0" id="insurace" name="insurace"
										   value="${empty map.userInfo.insurace ? 0 : map.userInfo.insurace}">
								</div>
							</div>
						</td>
					</tr>
				</table>
				<div class="FormItem ClearFix">
					<button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>

<script type="text/javascript">
	$(function(){
		function inputInt(){
			var input = $(this);
			var regx=/0|[1-9]{1}\d*/;
			var rs = input.val().match(regx);
			input.val(rs);
		}
		$("#salePriceReal").keyup(inputInt);
		$("#servicePrice").keyup(inputInt);
		$("#otherFees").keyup(inputInt);
		$("#insurace").keyup(inputInt);
	});
</script>
