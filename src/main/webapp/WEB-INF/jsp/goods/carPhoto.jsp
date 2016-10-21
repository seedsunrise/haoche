<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <title>上传商品图片</title>
    <link href='<c:url value="/resources/css/lib/fancybox.css" />' rel="stylesheet" type="text/css" />
    <link href='<c:url value="/resources/css/lib/vex.css" />' rel="stylesheet"  type="text/css" />
    <link href='<c:url value="/resources/css/app.css" />' rel="stylesheet"  type="text/css" />
    <link href='<c:url value="/resources/css/carPhoto.css" />' rel="stylesheet"  type="text/css" />
    <style>
        .container {
            border: 1px dashed #ccc;
            position: relative;
        }

        .container > div {
            background: #CCC;
            height: 100px;
            position: absolute;
            width: 80px;
        }

        .container > div[data-ss-colspan='2'] { width: 170px; }

        .container .ss-placeholder-child {
            background: transparent;
            border: 1px dashed red;
        }

    </style>
</head>
<body>
<div class="LayoutWrapper" id="CarPhoto">
    <input type="hidden" value="${map.imageUrl}" id="ImagePreFix">
    <h2 class="MainTitle ClearFix">
        <span>上传商品图片</span>
        <a href="javascript:;" class="Btn BtnPrimary SubmitPhotoBtn">保存</a>
    </h2>
    <div class="MainWrapper ClearFix">

        <div class="PhotoWrapper">
            <form action="/carGoods/updateCarPhoto" method="post" id="PhotoForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="carInfoId" value="${map.carPhoto.carInfoId}">
                <div class="FileUploadWrapper">
                    <input class="ImageSourceUrl" type="hidden" id="maintenanceInvoicePhoto" name="maintenanceInvoicePhoto" value="${map.carDocument.maintenanceInvoicePhoto}">
                    <div class="PreShowList ImageWrapper">
                    </div>
                    <div class="UploadBtnWrapper">
                        <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" multiple>
                        <a class="Btn CarPhotoBtn" href="javascript:;">上传图片</a>
                    </div>
                </div>
                <div class="Source">
                    <input type="hidden" class="ValidateRequired" name="leftFrontFace" value="${map.carPhoto.leftFrontFace}" data-error="请上传车前45°照片">
                    <input type="hidden" name="frontFace" value="${map.carPhoto.frontFace}">
                    <input type="hidden" name="leftFace" value="${map.carPhoto.leftFace}">
                    <input type="hidden" name="rearFace" value="${map.carPhoto.rearFace}">
                    <input type="hidden" name="allInteriorFace" value="${map.carPhoto.allInteriorFace}">
                    <input type="hidden" name="meterFace" value="${map.carPhoto.meterFace}">
                    <input type="hidden" name="steeringWheelFace" value="${map.carPhoto.steeringWheelFace}">
                    <input type="hidden" name="middleControlCenter" value="${map.carPhoto.middleControlCenter}">
                    <input type="hidden" name="centralControlLayoutOne" value="${map.carPhoto.centralControlLayoutOne}">
                    <input type="hidden" name="centralControlLayoutTwo" value="${map.carPhoto.centralControlLayoutTwo}">
                    <input type="hidden" name="headlightControl" value="${map.carPhoto.headlightControl}">
                    <input type="hidden" name="windowControl" value="${map.carPhoto.windowControl}">
                    <input type="hidden" name="frontSeatFace" value="${map.carPhoto.frontSeatFace}">
                    <input type="hidden" name="skylight" value="${map.carPhoto.skylight}">
                    <input type="hidden" name="rearSeatSideFace" value="${map.carPhoto.rearSeatSideFace}">
                    <input type="hidden" name="rearSeatFace" value="${map.carPhoto.rearSeatFace}">
                    <input type="hidden" name="rearAirPort" value="${map.carPhoto.rearAirPort}">
                    <input type="hidden" name="engineCabin" value="${map.carPhoto.engineCabin}">
                    <input type="hidden" name="stall" value="${map.carPhoto.stall}">
                    <input type="hidden" name="mainButtonOne" value="${map.carPhoto.mainButtonOne}">
                    <input type="hidden" name="mainButtonTwo" value="${map.carPhoto.mainButtonTwo}">
                    <input type="hidden" name="detectingAppearance" value="${map.carPhoto.detectingAppearance}">
                    <input type="hidden" name="computerFailures" value="${map.carPhoto.computerFailures}">
                    <input type="hidden" name="detectingChassis" value="${map.carPhoto.detectingChassis}">
                </div>
                <div class="ImageGroupWrapper ClearFix"></div>
            </form>
        </div>
    </div>
</div>
<!-- jQuery / jQuery UI -->
<script src='<c:url value="/resources/javascript/lib/jquery-2.2.3.min.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/jquery.fancybox.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/jquery-ui.min.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/jquery.ui.widget.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/jquery.file.upload.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/jquery.shapeshift.min.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/vex.min.js" />'></script>
<%--<script src='<c:url value="/resources/javascript/lib/jquery-gridly.js" />'></script>--%>
<script>vex.defaultOptions.className = 'vex-theme-default';</script>
<script src='<c:url value="/resources/javascript/app/carPhoto.js" />'></script>
</body>
</html>
