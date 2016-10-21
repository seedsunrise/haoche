<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="打印二维码"></c:set>
<%@include file="../lib/header.jsp"%>

<c:set var="carInfo" value="${map.carInfo}"></c:set>
<style>
	.Clearfix:after {
		content: "";
		display: block;
		clear: both;
		visibility: hidden;
		font-size: 0;
		height: 0;
	}

	.Clearfix {
		*display: inline-block;
		_height: 1%;
	}
	.QRCodeWrapper {
		background: #fff;
	}
	.QRCodeLayout {
		width: 1200px;
		margin: 0 auto;
		border: 1px solid #ddd;
		border-top: none;
	}
	.MainTitle {
		height: 100px;
		line-height: 100px;
		font-size: 26px;;
		color: #1b1b1b;
		margin: 0;
		border-bottom: 2px solid #ff5f52;
	}
	.MainTitle span {
		position: relative;
		margin-left: 54px;
	}
	.MainTitle span:before {
		position: absolute;
		top: -1px;
		left: -20px;
		content: " ";
		width: 5px;
		height: 30px;
		background: #ff5f52;
	}
	.PrintQRCode {
		float: right;
		margin-top: 25px;
		margin-right: 30px;
		width: 155px;
		height: 50px;
		line-height: 50px;
		text-align: center;
		font-size: 24px;
		color: #fff;
		font-weight: bold;
		background: #ff5f52;
		border-radius: 25px;
		text-decoration: none;
	}
	.PrintQRCode:hover {
		text-decoration: none;
		opacity: 0.9;
	}
	.QRCodeImageWrapper {
		width: 750px;
		height: 850px;
		float: left;
		background: #808080;
		text-align: center;
	}
	.QRCodeTitle {
		margin-top: 30px;
		margin-bottom: 20px;
		color: #fff;
		font-size: 18px;
	}
	.QRCodeTitle span {
		font-weight: bolder;
		margin: 0 3px;
	}
	.QRAll {
		width: 495px;
		height: 700px;
		padding-top: 40px;
		margin: 0 auto;
		background: #fff;
	}
	.QRLogo {
		display: block;
		margin: 0 auto;
	}
	.CarName {
		/*font-size: 32px;*/
		font-size: 25px;
		color: #0d0d0d;
	}
	.ChassisNumber {
		font-size: 18px;
		color: #808080;
	}
	.Action {
		position: relative;
		float: left;
		margin-left: 30px;
	}
	.Action label {
		display: block;
		margin-top: 28px;
		margin-bottom: 20px;
		font-size: 18px;
		color: #0d0d0d;
	}
	.Action textarea {
		width: 390px;
		border: 1px solid #e6e6e6;
		outline: none;
		padding: 10px;
	}

	.Action textarea:focus {
		border: 1px solid #ffb9b3;
	}
	.PrintArea {
		display: none;
	}
	#ActionCarName, #ActionChassisNumber {
		height: 100px;
	}
	.InputCarNameNotice {
		position: absolute;
		font-size: 14px;
		right: 20px;
		top: 145px;
	}
	.InputChassisNumberNotice {
		position: absolute;
		font-size: 14px;
		right: 20px;
		top: 318px;
	}

	.InputNotice span {
		color: #ffad77;
	}
	@media print {
		@page {
			size: 450px 550px;
			margin: 0;
		}
		body {
			width: 497px;
		}
		.PrintArea {
			display: block!important;
		}
		.QRCodeLayout {
			display: none;
		}
		.QRLogoPrint {
			width: 102px;
			margin-top: 40px;
			margin-bottom: 10px;
			margin-left: 117px;
		}
		.MainImg {
			width: 297px;
			margin-left: 20px;
		}
		.PrintCarName, .PrintChassisNumber{
			width: 330px;
			text-align: center;
		}
		.PrintCarName {
			margin-top: 10px;
			font-size: 15px;
		}
		.PrintChassisNumber{
			margin-top: 10px;
			font-size: 12px;
		}
	}
</style>

<div class="Main">
	<div class="QRCodeLayout">
		<h2 class="MainTitle Clearfix">
			<span>打印二维码</span>
			<a href="javascript:;" class="PrintQRCode">打印</a>
		</h2>
		<div class="QRActionWrapper Clearfix">
			<div class="QRCodeImageWrapper">
				<div class="QRCodeTitle">请使用<span>热敏打印机</span>进行打印</div>
				<div class="QRAll">
					<img src="/resources/image/QRCodeLogo.png" class="QRLogo"/>
					<img src="${carInfo.QRCodeImg}" class="MainImg">
					<div class="CarName">${carInfo.carTitle}</div>
					<div class="ChassisNumber">${carInfo.carVin}</div>
				</div>
			</div>
			<div class="Action">
				<label for="ActionCarName">车辆名称:</label>
				<div class="InputCarNameNotice InputNotice">还可以输入<span>18</span>个字</div>
				<textarea name="" class="ChangeBind" id="ActionCarName" data-notice=".InputCarNameNotice" maxlength="18">${carInfo.carTitle}</textarea>
				<label for="ActionChassisNumber">车架号:</label>
				<div class="InputChassisNumberNotice InputNotice">还可以输入<span>18</span>个字</div>
				<textarea name="" class="ChangeBind" id="ActionChassisNumber" data-notice=".InputChassisNumberNotice" maxlength="17">${carInfo.carVin}</textarea>
			</div>
		</div>
	</div>
	<div class="PrintArea">
		<img src="/resources/image/QRCodeLogo.png" class="QRLogo QRLogoPrint"/>
		<img src="${carInfo.QRCodeImg}" class="MainImg">
		<div class="CarName PrintCarName">${carInfo.carTitle}</div>
		<div class="ChassisNumber PrintChassisNumber">${carInfo.carVin}</div>
	</div>
</div>

<script src='<c:url value="/resources/javascript/lib/jquery-2.2.3.min.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/vex.min.js" />'></script>
<script>vex.defaultOptions.className = 'vex-theme-default';</script>
<script src='<c:url value="/resources/javascript/print/qrcode.js" />'></script>
</body>
</html>
