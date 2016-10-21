<%@ page import="com.haoche.remoting.dto.InsuranceQuoteDTO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <script>
        var ua = navigator.userAgent;
        !function(){
            var sw = window.screen.width;
            //设计图宽度
            var width = 640;
            var half = 320;
            if (isAndroid() && getAndroidVersion() < 4.4 ) {
                if (getAndroidVersion() <= 4.1 ) {
                    var s = 0.5;
//                sw = sw * 2;
//                // 分辨率低，所需scale
//                if (window.devicePixelRatio < 2.5 ){
//                    s = window.devicePixelRatio / 2.1 * 0.5;
//                }
                    var v = parseFloat(RegExp.$1);
                    var c =    v < 4.2 ? Math.ceil(window.devicePixelRatio) : window.devicePixelRatio;
                    var dpi;
                    if (c) {
                        dpi = width / sw * c * 160;
                    } else {
                        dpi = sw <= width ? sw / width * half : width / sw * half;
                    }
                    vp = '<meta name="viewport" content="width=' + "device-width" + ',initial-scale=' + s + ' ,minimum-scale=' + s + ',maximum-scale=' + s + ',user-scalable=no,target-densitydpi=' +  dpi + '">';
                } else {
                    vp = '<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,target-densitydpi=device-dpi">';
                }
            } else {
                var s = sw / width;
                if (isAndroid()) {
                    vp = '<meta name="viewport" content="width=' + width + ',initial-scale=' + s + ' ,minimum-scale=' + s + ',maximum-scale=' + s + ',user-scalable=no,target-densitydpi=device-dpi">';
                } else {
                    vp = '<meta name="viewport" content="width=' + width + ',initial-scale=' + s + ' ,minimum-scale=' + s + ',maximum-scale=' + s + ',user-scalable=no">';
                }
            }
            document.write(vp);
        }();
        function getChromeVersion() {
            var raw = navigator.userAgent.match(/Chrom(e|ium)\/([0-9]+)\./);
            return raw ? parseInt(raw[2], 10) : false;
        }
        function isAndroid() {
            return /android (\d+\.\d+)/i.test(ua) || /android\/(\d+\.\d+)/i.test(ua);
        }
        function getAndroidVersion() {
            var raw = navigator.userAgent.match(/Android (\d+\.\d+)/);
            return raw ? parseFloat(raw[1]) : false;
        }
    </script>
    <sec:csrfMetaTags/>
    <meta name="renderer" content="webkit">
    <link href='<c:url value="/resources/css/lib/vex.css" />' rel="stylesheet"  type="text/css" />
    <link href='<c:url value="/resources/css/lib/swiper.min.css" />' rel="stylesheet"  type="text/css" />
    <link href='<c:url value="/resources/css/insuranceQuote.css" />' rel="stylesheet"  type="text/css" />
    <title>乾坤好车</title>
</head>
<body>
<div class="swiper-container">
    <div class="swiper-wrapper">
    </div>
    <div class="swiper-pagination"></div>
</div>
<input type="hidden" value="${map.insuranceInfoDTO.carDocumentDTO.drivingLicensePhoto}" id="DrivingLicensePhoto">
<input type="hidden" value="${map.imageUrl}" id="ImagePreFix">
<input type="hidden" value="${map.insuranceInfoDTO.detailList}">

<form action="/carInsurance/editQuote" class="InsuranceWebWrapper InsuranceForm">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<h2 class="Welcome">
        <span class="Title">
            <span>尊敬的${map.insuranceInfoDTO.quoter.name}，乾坤好车请您报价</span>
        </span>
    </h2>

    <h3 style="margin-top: 57px;margin-bottom: 25px">交强险 车船使用税(元)</h3>
    <c:forEach items="${map.insuranceInfoDTO.detailList}" var="detail">
        <c:if test="${detail.option.type == 0}">
            <div class="Group DetailGroup ClearFix">
                <input type="hidden" value="${detail.id}" class="DetailDataId">
                <input type="hidden" value="${detail.infoId}" class="DetailDataInfoId">
                <input type="hidden" class="IsConfirm" value="${detail.isConfirm}">
                <input type="hidden" class="IsConfirmDeductible" value="${detail.isConfirmDeductible}">
                <label>${detail.option.name}：</label>
                <input type="text" class="CustomInput CalculateItem Price" value="${detail.price}" placeholder="请输入价格">
                <span class='Unit'>元</span>
            </div>
        </c:if>
    </c:forEach>

    <h3>商业险</h3>

    <c:forEach items="${map.insuranceInfoDTO.detailList}" var="detail">
        <c:if test="${detail.option.type == 1}">
            <c:if test="${detail.option.name == '玻璃单独破碎险'}">
                <div class="DetailGroup GlassInsurance">
                    <input type="hidden" value="${detail.id}" class="DetailDataId">
                    <input type="hidden" value="${detail.infoId}" class="DetailDataInfoId">
                    <input type="hidden" value="${detail.isImported}" class="GlassType">
                    <input type="hidden" class="Price" value="${detail.price}">
                    <input type="hidden" class="IsConfirm" value="${detail.isConfirm}">
                    <input type="hidden" class="IsConfirmDeductible" value="${detail.isConfirmDeductible}">
                </div>
            </c:if>
            <c:if test="${detail.option.name != '玻璃单独破碎险'}">
                <div class="DetailGroup">
                    <input type="hidden" value="${detail.id}" class="DetailDataId">
                    <input type="hidden" value="${detail.infoId}" class="DetailDataInfoId">
                    <input type="hidden" class="IsConfirm" value="${detail.isConfirm}">
                    <input type="hidden" class="IsConfirmDeductible" value="${detail.isConfirmDeductible}">
                    <h4>${detail.option.name}</h4>

                    <div class="Group ClearFix">
                            <%--保额--%>
                        <c:if test="${detail.option.extend != ''}">
                            <label>保额：${detail.option.extend}</label>
                        </c:if>
                            <%--保额不计入总价--%>
                        <c:if test="${detail.option.extend == ''}">
                            <input type="text" class="LeftInput Coverage" value="${detail.coverage}" placeholder="保额(元)">
                        </c:if>
                        <input type="text" placeholder="请输入价格" class="CalculateItem Price" value="${detail.price}">
                        <span class="Unit">元</span>
                    </div>

                        <%--是否有不计免赔--%>
                    <c:if test="${detail.option.isNonDeductible == 1}">
                        <div class="Group ClearFix">
                            <label>不计免赔：</label>
                            <input type="text" class="CalculateItem DeductibleCheckPrice" value="${detail.nonDeductible}">
                            <span class="Unit">元</span>
                        </div>
                    </c:if>
                    <div class="Border"></div>
                </div>
            </c:if>
        </c:if>
    </c:forEach>

    <h4>玻璃单独破碎险</h4>
    <div class="Group ClearFix GlassInsuranceWrapper GlassInsuranceWrapperNotImported">
        <label class="CheckImgWrapper">
            <img src="/resources/image/Check.png" class="GlassInsuranceChecked" style="display: none">
            <img src="/resources/image/NotCheck.png" class="GlassInsuranceNotChecked" style="display: none">
            国产：
        </label>
        <input type="number" min="0" placeholder="请输入价格" value="">
        <span class="Unit">元</span>
    </div>
    <div class="Group ClearFix GlassInsuranceWrapper GlassInsuranceWrapperImported">
        <label class="CheckImgWrapper">
            <img src="/resources/image/Check.png" class="GlassInsuranceChecked" style="display: none">
            <img src="/resources/image/NotCheck.png" class="GlassInsuranceNotChecked" style="display: none">
            进口：
        </label>
        <input type="number" min="0" placeholder="请输入价格" value="">
        <span class="Unit">元</span>
    </div>
    <div class="BtnWrapper">
        <button type="submit" class="FormBtnSubmit SubmitInsurance">提 交</button>
    </div>
</form>

<script src='<c:url value="/resources/javascript/lib/jquery-2.2.3.min.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/swiper.min.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/vex.min.js" />'></script>
<script>vex.defaultOptions.className = 'vex-theme-default';</script>
<script src='<c:url value="/resources/javascript/app/insuranceQuoteWeb.js" />'></script>
</body>
</html>