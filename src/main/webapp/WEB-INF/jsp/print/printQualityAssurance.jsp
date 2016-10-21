<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
	<link rel="shortcut icon" href="/resources/image/favicon.ico"/>
	<link rel="bookmark" href="/resources/image/favicon.ico"/>
    <link href='<c:url value="/resources/css/app.css" />' rel="stylesheet"  type="text/css" />
    <title>打印保修条例</title>
</head>
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
	.PrintCarParam {
		background: #fff;
	}
	.MainTitle {
		/*display: none;*/
		width: 210mm;
		margin: 0 auto;
		margin-bottom: 50px;
		height: 100px;
		line-height: 100px;
		font-size: 26px;;
		color: #1b1b1b;
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
	.PrintBtn {
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
	.PrintBtn:hover {
		text-decoration: none;
		opacity: 0.9;
	}

	.PrintArea {
		width: 190mm;
		margin: 0 auto;
	}
	.PrintArea img {
		width: 100%;
		display: block;
	}
	@media print  {
		.MainTitle {
			display: none;
		}
		@page {
			margin: 0mm;
			size: A4 portrait;
		}
	}
</style>
<div class="PrintCarParamLayout">
	<h2 class="MainTitle Clearfix">
		<span>打印保修条例</span>
		<a href="javascript:;" class="PrintBtn" onclick="window.print();">打印</a>
	</h2>
	<div class="PrintArea">
		<img src="/resources/image/WarrantyRegulations-1.jpg" />
		<img src="/resources/image/WarrantyRegulations-2.jpg" />
	</div>
</div>
</body>
</html>
