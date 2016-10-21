<%@ page import="com.haoche.remoting.dto.CarInfoDTO" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="录入车源"></c:set>
<c:set var="sidebarOn" value="车源"></c:set>
<c:set var="newUrl" value="/carSource/edit"></c:set>
<c:set var="newName" value="录入车源"></c:set>
<c:set var="navOn" value="车源"></c:set>

<%@include file="../lib/header.jsp" %>
<%@include file="../lib/nav.jsp" %>

<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/emp/list">车源</a> <i class="fa fa-angle-right"></i></li>
				<li><span>库存车源</span> <i class="fa fa-angle-right"></i></li>
				<li>
                    <span>
                        <c:if test="${empty map.carInfoDTO.id}">新增车源</c:if>
                        <c:if test="${ !(empty map.carInfoDTO.id)}">编辑车源</c:if>
                    </span>

				</li>
			</ul>
			<form action="/carSource/update" method="post"
			      class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo carSourcesEditForm"
			      novalidate>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="hidden" name="carInfoApplyId" value="${map.carInfoApplyId}">
				<c:if test="${!empty map.carInfoDTO.id}">
					<input type="hidden" id="carInfoId" name="id" value="${map.carInfoDTO.id}"/>
				</c:if>
				<c:if test="${empty map.carInfoDTO.id}">
					<input type="hidden" id="carInfoId" name="id" value="0"/>
				</c:if>
				<table class="GroupTable">
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">车辆基本信息<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
								<div class="LabelNeedWrapper">注:若数量输入为0，则代表没有；若未填或选择，则代表未填写</div>
							</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label for="carVin" class="FormLayout"><span class="LabelNeed">车辆VIN码：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="carVin" name="carVin"
									       value="${map.carInfoDTO.carVin}" required>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label for="carVin" class="FormLayout">车辆铭牌照片：</label>
								<div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
									<input image-number-limit-msg="车辆铭牌照片" image-number-limit="4" class="ImageSourceUrl"
									       type="hidden" id="nameplatePhoto" name="nameplatePhoto"
									       value="${map.carInfoDTO.nameplatePhoto}">
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
								<label class="FormLayout" for="carBrandId"><span class="LabelNeed">车辆品牌：</span></label>
								<input type="hidden" value="${map.carInfoDTO.brandName}" name="brandName"
								       class="CarBrandName">
								<div class="FormLayout FormItemControl">
									<select name="carBrandId" id="carBrandId"
									        class="CustomSelect LinkedInput LinkSelect" data-link="carSubBrandId"
									        data-url="/system/carsubbrand/getCarSubBrandByCarBrandId?id="
									        data-input="CarBrandName" value="${map.carInfoDTO.carBrandId}" required>
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
								<input type="hidden" value="${map.carInfoDTO.subBrandName}" name="subBrandName"
								       class="CarSubBrandName">
								<div class="FormLayout FormItemControl">
									<select name="carSubBrandId" id="carSubBrandId"
									        class="CustomSelect LinkedInput LinkSelect" data-link="carLineId"
									        data-url="/system/carline/getCarLineListByCarSubBrandId?id="
									        data-input="CarSubBrandName" value="${map.carInfoDTO.carSubBrandId}"
									        required>
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carLineId"><span class="LabelNeed">车辆车系：</span></label>
								<input type="hidden" value="${map.carInfoDTO.lineName}" name="lineName"
								       class="LineName">
								<div class="FormLayout FormItemControl">
									<select name="carLineId" id="carLineId" class="CustomSelect LinkedInput LinkSelect"
									        data-link="carModelId"
									        data-url="/system/carmodel/getCarModelListByCarLineId?id="
									        data-input="LineName" value="${map.carInfoDTO.carLineId}" required>
										<option value="">请选择</option>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carModelId"><span class="LabelNeed">车辆车型：</span></label>
								<input type="hidden" value="${map.carInfoDTO.modelName}" name="modelName"
								       class="ModelName">
								<div class="FormLayout FormItemControl">
									<select name="carModelId" id="carModelId" class="CustomSelect LinkedInput"
									        data-input="ModelName" value="${map.carInfoDTO.carModelId}" required>
										<option value="">请选择</option>
									</select>
								</div>
							</div>

							<div class="FormItem ClearFix">
								<label class="FormLayout"><span class="">车辆配置：</span></label>
								<div class="FormLayout FormItemControl GetCarConfig">
									<span class="SpanInfo">等待选择车型后匹配</span>
									<a href="javascript:;" class="CarConfigBtn BtnPreView ShowCarConfig" data-urlpre="${map.mobileSiteUrl}/car/dts_cfg?mid=">查看配置</a>
									<a href="javascript:;" class="CarConfigBtn UpdateCarConfig">更新配置</a>
									<a href="javascript:;" class="CarConfigBtn NotFoundCarConfigUpdate">获取配置</a>
									<a href="javascript:;" class="ShowGetCarConfigTutorial"></a>
									<a href="javascript:;" class="ShowTutorial">如何获取/更新车辆配置?</a>
								</div>
							</div>

							<div class="FormItem ClearFix">
								<label class="FormLayout" for="firstLicenseDate">首次上牌时间：</label>
								<div class="FormLayout FormItemControl FormDatePickerWrapper">
									<input class="FormInput DatePicker" type="text" data-viewmode="month"
									       id="firstLicenseDate" name="firstLicenseDate" value="${map.carInfoDTO.firstLicenseDate}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="firstLicenseCityId"><span class="">首次上牌城市：</span></label>
								<input type="hidden" value="${map.carInfoDTO.firstLicenseCityName}"
								       name="firstLicenseCityName" class="firstLicenseCityName">
								<div class="FormLayout FormItemControl">
									<select name="firstLicenseCityId" id="firstLicenseCityId"
									        class="CustomSelect LinkedInput" data-input="firstLicenseCityName"
									        value="${map.carInfoDTO.firstLicenseCityId}">
										<option value="">请选择</option>
										<option value="211">福州市</option>
										<option value="101">宁德市</option>
										<%--<c:forEach var="item" items="${map.cityList}">--%>
										<%--<option value="${item.id}">${item.cityName}</option>--%>
										<%--</c:forEach>--%>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="lastLicenseDate">最近一次上牌时间：</label>
								<div class="FormLayout FormItemControl FormDatePickerWrapper">
									<input class="FormInput DatePicker" type="text" id="lastLicenseDate" data-viewmode="month"
									       name="lastLicenseDate" value="${map.carInfoDTO.lastLicenseDate}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carCityId"><span class="">车辆当前所在城市：</span></label>
								<input type="hidden" value="${map.carInfoDTO.carCityName}" name="carCityName"
								       class="carCityName">
								<div class="FormLayout FormItemControl">
									<select name="carCityId" id="carCityId" class="CustomSelect LinkedInput"
									        data-input="carCityName"
									        value="${(empty map.carInfoDTO.carCityId)?0:map.carInfoDTO.carCityId}">
										<option value="0">请选择</option>
										<c:forEach var="item" items="${map.cityList}">
										<option value="${item.id}">${item.cityName}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carColor"><span class="">车身颜色：</span></label>
								<div class="FormLayout FormItemControl">
									<select value="${map.carInfoDTO.carColor}" name="carColor" id="carColor"
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
										<option value="酒红色">酒红色</option>
										<option value="暗红色">暗红色</option>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carInteriorColor"><span class="">内饰颜色：</span></label>
								<div class="FormLayout FormItemControl">
									<select class="CustomSelect" value="${map.carInfoDTO.carInteriorColor}"
									        name="carInteriorColor"
									        id="carInteriorColor" class="carInteriorColor LinkSelect LinkedInput"
									        data-input="carBusinessName">
										<option value="">请选择</option>
										<option value="黑色">黑色</option>
										<option value="米色">米色</option>
										<option value="蓝色">蓝色"</option>
										<option value="香槟色">香槟色</option>
										<option value="咖啡色">咖啡色</option>
										<option value="橙色">橙色</option>
										<option value="黄色">黄色</option>
										<option value="红色">红色</option>
										<option value="棕色">棕色</option>
										<option value="灰色">灰色</option>
										<option value="酒红色">酒红色</option>
										<option value="暗红色">暗红色</option>
									</select>
								</div>
							</div>

							<div class="FormItem ClearFix">
								<label class="FormLayout" for="carBusinessId"><span class="">寄售车商：</span></label>
								<input type="hidden" name="carBusinessName" class="carBusinessName"
								       value="${map.carInfoDTO.carBusinessName}">
								<div class="FormLayout FormItemControl">
									<select value="${map.carInfoDTO.carBusinessId}" name="carBusinessId"
									        id="carBusinessId" class="CustomSelect LinkedInput"
									        data-input="carBusinessName">
										<option value="">请选择</option>
										<c:forEach var="item" items="${map.businessList}">
											<option value="${item.id}">${item.businessName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="licenseNum"><span class="">当前车牌号：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="10" type="text" id="licenseNum"
									       name="licenseNum" value="${map.carInfoDTO.licenseNum}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="firstLicenseCityId"><span class="">车牌当前所属城市：</span></label>
								<input type="hidden" value="${map.carInfoDTO.cardCityName}" name="cardCityName"
								       class="cardCityName">
								<div class="FormLayout FormItemControl">
									<select name="cardCityId" id="cardCityId"
									        class="CustomSelect LinkedInput" data-input="cardCityName"
									        value="${map.carInfoDTO.cardCityId}">
										<option value="">请选择</option>
										<c:forEach var="item" items="${map.cityList}">
											<option value="${item.id}">${item.cityName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="runKmTmp"><span class="">里程：</span></label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" class="HiddenRunKm" id="runKm" name="runKm"
									       value="${map.carInfoDTO.runKm}">
									<input class="FormInput" type="text" type="text" id="runKmTmp" maxlength="5"
									       name="runKmTmp" value="${map.carInfoDTO.runKm/10000}">
									<span class="Unit">万公里</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="displacement"><span class="">排量：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="displacement"
									       name="displacement" value="${map.carInfoDTO.displacement}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="engineNo"><span class="">发动机号：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="engineNo" name="engineNo"
									       value="${map.carInfoDTO.engineNo}">
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">车辆档案信息<span class="LabelNeedWrapper">（ <span
									class="LabelNeed">为必填</span>）</span></div>
							<div class="LabelNeedWrapper">注:若数量输入为0，则代表没有；若未填或选择，则代表未填写</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有产权证：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.propertyCertificate}"
									       name="propertyCertificate">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.propertyCertificate == 1}">BtnPrimary</c:if>"
									     data-show=".ShowPropertyCertificatePhoto">是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.propertyCertificate == 2}">BtnPrimary</c:if>"
									     data-show=".ShowPropertyCertificatePhoto">否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix ShowPropertyCertificatePhoto">
								<label class="FormLayout">产权证照片：</label>
								<div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
									<input image-number-limit-msg="产权证照片" image-number-limit="4" class="ImageSourceUrl"
									       type="hidden" id="propertyCertificatePhoto" name="propertyCertificatePhoto"
									       value="${map.carDocument.propertyCertificatePhoto}">
									<div class="PreShowList">
									</div>
									<div class="UploadBtnWrapper">
										<input class="FileUpload Multiple" type="file" name="upload_file"
										       data-url="/index.php/upload/do_upload_fdfs" multiple>
										<a class="Btn" href="javascript:;">上传图片</a>
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有三包：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isInGuarantee}" name="isInGuarantee">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isInGuarantee == 1}">BtnPrimary</c:if>">
										是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isInGuarantee == 2}">BtnPrimary</c:if>">
										否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有违章：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isIllegal}" name="isIllegal">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isIllegal == 1}">BtnPrimary</c:if>"
									     data-show=".ShowillegalPhoto">是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isIllegal == 2}">BtnPrimary</c:if>"
									     data-show=".ShowillegalPhoto">否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix ShowillegalPhoto">
								<label class="FormLayout">违章照片：</label>
								<div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
									<input image-number-limit-msg="违章照片" image-number-limit="10" class="ImageSourceUrl"
									       type="hidden" id="illegalPhoto" name="illegalPhoto"
									       value="${map.carDocument.illegalPhoto}">
									<div class="PreShowList">
									</div>
									<div class="UploadBtnWrapper">
										<input class="FileUpload Multiple" type="file" name="upload_file"
										       data-url="/index.php/upload/do_upload_fdfs" multiple>
										<a class="Btn" href="javascript:;">上传图片</a>
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有用户手册：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isUserManual}" name="isUserManual">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isUserManual == 1}">BtnPrimary</c:if>">
										是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isUserManual == 2}">BtnPrimary</c:if>">
										否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有行驶证：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isDrivingLicense}"
									       name="isDrivingLicense">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isDrivingLicense == 1}">BtnPrimary</c:if>"
									     data-show=".ShowDrivingLicensePhoto">是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isDrivingLicense == 2}">BtnPrimary</c:if>"
									     data-show=".ShowDrivingLicensePhoto">否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix ShowDrivingLicensePhoto">
								<label class="FormLayout">行驶证照片：</label>
								<div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
									<input image-number-limit-msg="行驶证照片" image-number-limit="4" class="ImageSourceUrl"
									       type="hidden" id="drivingLicensePhoto" name="drivingLicensePhoto"
									       value="${map.carDocument.drivingLicensePhoto}">
									<div class="PreShowList">
									</div>
									<div class="UploadBtnWrapper">
										<input class="FileUpload Multiple" type="file" name="upload_file"
										       data-url="/index.php/upload/do_upload_fdfs" multiple>
										<a class="Btn" href="javascript:;">上传图片</a>
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有购置证：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isPurchaseCertificate}"
									       name="isPurchaseCertificate">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isPurchaseCertificate == 1}">BtnPrimary</c:if>">
										是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isPurchaseCertificate == 2}">BtnPrimary</c:if>">
										否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有保养手册：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isMaintenanceManual}"
									       name="isMaintenanceManual">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isMaintenanceManual == 1}">BtnPrimary</c:if>"
									     data-show=".ShowMaintenanceInvoicePhoto">是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isMaintenanceManual == 2}">BtnPrimary</c:if>"
									     data-show=".ShowMaintenanceInvoicePhoto">否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix ShowMaintenanceInvoicePhoto">
								<label class="FormLayout">4S店保养记录：</label>
								<div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
									<input image-number-limit-msg="4S店保养记录：" image-number-limit="10"
									       class="ImageSourceUrl" type="hidden" id="maintenanceInvoicePhoto"
									       name="maintenanceInvoicePhoto"
									       value="${map.carDocument.maintenanceInvoicePhoto}">
									<div class="PreShowList">
									</div>
									<div class="UploadBtnWrapper">
										<input class="FileUpload Multiple" type="file" name="upload_file"
										       data-url="/index.php/upload/do_upload_fdfs" multiple>
										<a class="Btn" href="javascript:;">上传图片</a>
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有保单：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isPolicy}" name="isPolicy">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isPolicy == 1}">BtnPrimary</c:if>">
										是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isPolicy == 2}">BtnPrimary</c:if>">
										否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout"><span class="">是否能正常过户：</span></label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isNormalTransfer}"
									       name="isNormalTransfer">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isNormalTransfer == 1}">BtnPrimary</c:if>">
										是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isNormalTransfer == 2}">BtnPrimary</c:if>">
										否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" style="font-size: 13px">是否有车主身份证复印件：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isCopyOfID}" name="isCopyOfID">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isCopyOfID == 1}">BtnPrimary</c:if>">
										是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isCopyOfID == 2}">BtnPrimary</c:if>">
										否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout">是否有二手车发票：</label>
								<div class="FormLayout FormItemControl">
									<input type="hidden" value="${map.carDocument.isCarInvoice}" name="isCarInvoice">
									<div class="Btn YesNo Yes <c:if test="${map.carDocument.isCarInvoice == 1}">BtnPrimary</c:if>">
										是
									</div>
									<div class="Btn YesNo No <c:if test="${map.carDocument.isCarInvoice == 2}">BtnPrimary</c:if>">
										否
									</div>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="timeOfMaturity">交强险到期时间：</label>
								<div class="FormLayout FormItemControl FormDatePickerWrapper">
									<input class="FormInput DatePicker" type="text" id="timeOfMaturity" 
									       name="timeOfMaturity"
									       value="${fn:substring(map.carDocument.timeOfMaturity,0,16)}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="annualInspection">年检到期时间：</label>
								<div class="FormLayout FormItemControl FormDatePickerWrapper">
									<input class="FormInput DatePicker" type="text" id="annualInspection"
									       name="annualInspection"
									       value="${fn:substring(map.carDocument.annualInspection,0,16)}">
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfKey">车钥匙数量：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10" id="numberOfKey"
									       name="numberOfKey" value="${map.carDocument.numberOfKey}">
									<span class="Unit">把</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="transferNum">过户次数：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput" type="number" maxlength="10" id="transferNum"
									       name="transferNum MustParseInt" value="${map.carInfoDTO.transferNum}">
									<span class="Unit">次</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">随车工具<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
								<span class="LabelNeedWrapper">注:若数量输入为0，则代表没有；若未填或选择，则代表未填写</span>
							</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfAshtray">烟灰缸：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10" id="numberOfAshtray"
									       name="numberOfAshtray"
									       value="${map.carTools.numberOfAshtray}">
									<span class="Unit">个</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfCigaretteLighter">点烟器：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10"
									       id="numberOfCigaretteLighter"
									       name="numberOfCigaretteLighter"
									       value="${map.carTools.numberOfCigaretteLighter}">
									<span class="Unit">个</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfAidKit">急救包：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10" id="numberOfAidKit"
									       name="numberOfAidKit" value="${map.carTools.numberOfAidKit}">
									<span class="Unit">个</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfTrailerHook">拖车钩：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10"
									       id="numberOfTrailerHook"
									       name="numberOfTrailerHook" value="${map.carTools.numberOfTrailerHook}">
									<span class="Unit">套</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfSpareTire">备用轮胎：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10" id="numberOfSpareTire"
									       name="numberOfSpareTire" value="${map.carTools.numberOfSpareTire}">
									<span class="Unit">个</span>
								</div>
							</div>

							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfJack">千斤顶：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10" id="numberOfJack"
									       name="numberOfJack" value="${map.carTools.numberOfJack}">
									<span class="Unit">个 </span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfNet">网兜：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10" id="numberOfNet"
									       name="numberOfNet" value="${map.carTools.numberOfNet}">
									<span class="Unit">个</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfWarningTriangle">三角警示牌：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10"
									       id="numberOfWarningTriangle"
									       name="numberOfWarningTriangle"
									       value="${map.carTools.numberOfWarningTriangle}">
									<span class="Unit">个</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="numberOfExtinguisher">车载灭火器：</label>
								<div class="FormLayout FormItemControl">
									<input min="0" class="FormInput MustParseInt" type="number" maxlength="10"
									       id="numberOfExtinguisher"
									       name="numberOfExtinguisher" value="${map.carTools.numberOfExtinguisher}">
									<span class="Unit">个</span>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="remarks">备注：</label>
								<div class="FormLayout FormItemControl">
									<textarea class="FormInput" id="remarks"
									          name="remarks">${map.carTools.remarks}</textarea>
								</div>
							</div>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="damageDescription">商品损坏描述：</label>
								<div class="FormLayout FormItemControl">
									<textarea class="FormInput" id="damageDescription"
									          name="damageDescription">${map.carTools.damageDescription}</textarea>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td class="TableGroupTitle">
							<div class="GroupTitle">接车送车信息<span class="LabelNeedWrapper">（  <span
									class="LabelNeed">为必填</span>）</span>
								<br>
							</div>
						</td>
						<td class="TableGroupContent">
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="sendCarName"><span class="">送车人：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="sendCarName"
									       name="sendCarName" value="${map.carInfoDTO.sendCarName}">
								</div>
							</div>
							<%
								CarInfoDTO carInfoDTO = (CarInfoDTO) ((Map) request.getAttribute("map")).get("carInfoDTO");
								if(carInfoDTO!=null){
									Date date = carInfoDTO.getSendCarTime();
									DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
									if (date != null) {
										out.print("<div class=\"FormItem ClearFix\">\n" +
												"\t\t\t\t\t\t\t\t<label class=\"FormLayout\" for=\"sendCarTime\">送车时间：</label>\n" +
												"\t\t\t\t\t\t\t\t<div class=\"FormLayout FormItemControl FormDatePickerWrapper\">\n" +
												"\t\t\t\t\t\t\t\t\t<input class=\"FormInput DatePicker\" type=\"text\" id=\"sendCarTime\"\n" +
												"\t\t\t\t\t\t\t\t\t       name=\"sendCarTime\" value=\"" + dateFormat.format(date) + "\">\n" +
												"\t\t\t\t\t\t\t\t</div>\n" +
												"\t\t\t\t\t\t\t</div>");
									} else {
										out.print("<div class=\"FormItem ClearFix\">\n" +
												"\t\t\t\t\t\t\t\t<label class=\"FormLayout\" for=\"sendCarTime\">送车时间：</label>\n" +
												"\t\t\t\t\t\t\t\t<div class=\"FormLayout FormItemControl FormDatePickerWrapper\">\n" +
												"\t\t\t\t\t\t\t\t\t<input class=\"FormInput DatePicker\" type=\"text\" id=\"sendCarTime\"\n" +
												"\t\t\t\t\t\t\t\t\t       name=\"sendCarTime\" value=\"\">\n" +
												"\t\t\t\t\t\t\t\t</div>\n" +
												"\t\t\t\t\t\t\t</div>");
									}
								}

							%>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="takeCarName"><span class="">接车人：</span></label>
								<div class="FormLayout FormItemControl">
									<input class="FormInput" maxlength="17" type="text" id="takeCarName"
									       name="takeCarName" value="${map.carInfoDTO.takeCarName}">
								</div>
							</div>
							<%
								if(carInfoDTO!=null){
									if (carInfoDTO.getSendCarTime() != null && carInfoDTO.getTakeCarTime() != null) {
										DateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd");
										out.print("<div class=\"FormItem ClearFix\">\n" +
												"\t\t\t\t\t\t\t\t<label class=\"FormLayout\" for=\"takeCarTime\">接车时间：</label>\n" +
												"\t\t\t\t\t\t\t\t<div class=\"FormLayout FormItemControl FormDatePickerWrapper\">\n" +
												"\t\t\t\t\t\t\t\t\t<input class=\"FormInput DatePicker\" type=\"text\" id=\"takeCarTime\"\n" +
												"\t\t\t\t\t\t\t\t\t       name=\"takeCarTime\" value=\"" + dateFormat.format(carInfoDTO.getTakeCarTime()) + "\">\n" +
												"\t\t\t\t\t\t\t\t</div>\n" +
												"\t\t\t\t\t\t\t</div>");
									} else {
										out.print("<div class=\"FormItem ClearFix\">\n" +
												"\t\t\t\t\t\t\t\t<label class=\"FormLayout\" for=\"takeCarTime\">接车时间：</label>\n" +
												"\t\t\t\t\t\t\t\t<div class=\"FormLayout FormItemControl FormDatePickerWrapper\">\n" +
												"\t\t\t\t\t\t\t\t\t<input class=\"FormInput DatePicker\" type=\"text\" id=\"takeCarTime\"\n" +
												"\t\t\t\t\t\t\t\t\t       name=\"takeCarTime\" value=\"\">\n" +
												"\t\t\t\t\t\t\t\t</div>\n" +
												"\t\t\t\t\t\t\t</div>");
									}
								}

							%>
							<%--<%--%>
							<%--out.print(dateFormat.format(carInfoDTO.getTakeCarTime()));--%>
							<%--%>--%>
							<div class="FormItem ClearFix">
								<label class="FormLayout" for="transferNote">备注：</label>
								<div class="FormLayout FormItemControl">
									<textarea class="FormInput" id="transferNote"
									          name="transferNote">${map.carInfoDTO.transferNote}</textarea>
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

<div class="OverLay DialogGetCarConfig">
	<div class="Dialog" style="min-height: 240px">
		<div class="DialogTitle">
			<h1>获取/更新配置</h1>
			<div class="DialogClose" data-close=".DialogGetCarConfig"><img src="/resources/image/DialogClose.png" alt=""></div>
		</div>
		<div class="DialogContent InsuranceQuoteContentWrapper InsuranceQuoteFromContent">
			<form action="/carInsurance/editQuote" id="HasInsuranceQuoteForm">
				<div class="FormGroup InsuranceQuoteFormGroup ClearFix" style="margin-top: 30px;margin-left: 30px;">
					<label>请在汽车之家网站中查找后输入车型ID:</label>
					<input type="text" class="CustomInput" placeholder="车型ID" id="GetCarConfigInput">
				</div>
				<div class="BtnGroup">
					<a href="javascript:;" class="Btn BtnPrimary GetCarConfigBtn" style="margin-left: 0">提 交</a>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="OverLay DialogGetCarConfigTutorial">
	<div class="Dialog" style="width: 600px">
		<div class="DialogTitle">
			<h1>如何获取/更新车辆配置?</h1>
			<div class="DialogClose" data-close=".DialogGetCarConfigTutorial"><img src="/resources/image/DialogClose.png" alt=""></div>
		</div>
		<div class="DialogContent" style="padding-left: 10px">
			<img src="/resources/image/GetCarConfigTutorial.png" alt="">
		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp" %>
