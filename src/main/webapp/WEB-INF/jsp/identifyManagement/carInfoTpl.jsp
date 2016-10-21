<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<div class="ShowGroupWrapper">
    <div class="ShowTitle">车源基本信息</div>
    <ul class="ClearFix ShowGroup">
        <li>
            <label>车辆VIN码：</label>
            <span>${map.carInfo.carVin}</span>
        </li>
        <li>
            <label>车辆品牌：</label>
            <span>${map.carInfo.brandName}</span>
        </li>
        <li>
            <label>生产厂商：</label>
            <span>${map.carInfo.subBrandName}</span>
        </li>
        <li>
            <label>车辆车系：</label>
            <span>${map.carInfo.lineName}</span>
        </li>
        <li>
            <label>车辆型号：</label>
            <span>${map.carInfo.modelName}</span>
        </li>
        <li>
            <label>首次上牌时间：</label>
            <span class="FormatDateShort">${map.carInfo.firstLicenseDate}</span>
        </li>
        <li>
            <label>首次上牌城市：</label>
            <span>${map.carInfo.firstLicenseCityName}</span>
        </li>
        <li>
            <label>最近一次上牌时间：</label>
            <span  class="FormatDateShort">${map.carInfo.lastLicenseDate}</span>
        </li>
        <li>
            <label>车牌当前所在城市：</label>
            <span  class="FormatDateShort">${map.carInfo.carCityName}</span>
        </li>
        <li>
            <label>车辆当前所在城市：</label>
            <span>${map.carInfo.carCityName}</span>
        </li>
        <li>
            <label>车身颜色：</label>
            <span>${map.carInfo.carColor}</span>
        </li>
        <li>
            <label>内饰颜色：</label>
            <span>${map.carInfo.carInteriorColor}</span>
        </li>
        <li>
            <label>当前车牌号：</label>
            <span>${map.carInfo.licenseNum}</span>
        </li>
        <li>
            <label>里程：</label>
            <span><span class="RunKmFormat">${map.carInfo.runKm}</span>万公里</span>
        </li>
        <li>
            <label>排量：</label>
            <span>${map.carInfo.displacement}</span>
        </li>
        <li>
            <label>发动机号：</label>
            <span>${map.carInfo.engineNo}</span>
        </li>
    </ul>
</div>
<div class="ShowGroupWrapper">
    <div class="ShowTitle">车辆档案</div>
    <ul class="ClearFix ShowGroup">
        <li>
            <label>产权证：</label>
            <span>${map.carDocument.propertyCertificate eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>三包：</label>
            <span>${map.carDocument.isInGuarantee eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>违章：</label>
            <span>${map.carDocument.isIllegal eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>用户手册：</label>
            <span>${map.carDocument.isUserManual eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>行驶证：</label>
            <span>${map.carDocument.isDrivingLicense eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>购置证：</label>
            <span>${map.carDocument.isPurchaseCertificate eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>保养手册：</label>
            <span>${map.carDocument.isMaintenanceManual eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>保单：</label>
            <span>${map.carDocument.isPolicy eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>是否能正常过户：</label>
            <span>${carDocument.isNormalTransfer eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>车主身份证复印件：</label>
            <span>${map.carDocument.isCopyOfID eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>二手车发票：</label>
            <span>${map.carDocument.isCarInvoice eq 1 ? '有' : '无'}</span>
        </li>
        <li>
            <label>交强险到期时间：</label>
            <span class="FormatDate">${map.carDocument.timeOfMaturity}</span>
        </li>
        <li>
            <label>年检到期时间：</label>
            <span class="FormatDate">${map.carDocument.annualInspection}</span>
        </li>
    </ul>
</div>
