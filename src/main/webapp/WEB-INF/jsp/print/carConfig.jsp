<!DOCTYPE html>
<%@ page contentType="text/html;charset=utf-8" %>
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
    <script src='<c:url value="/resources/javascript/lib/jquery-2.2.3.min.js" />'></script>
    <script src='<c:url value="/resources/javascript/print/printPriceTag.js" />'></script>
    <title>打印首页价签</title>
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
            width: 200mm;
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
        .PrintCarParamLayout {

        }
        .PageTitle {
            position: relative;
            height: 40px;
            line-height: 40px;
            font-size: 25px;
            font-weight: normal;
            color: #d05549;
            margin-left: 55px;
            border-bottom: 1px solid #d05549;
        }
        .PageTitle img {
            width: 45px;
            position: absolute;
            left: -55px;
            top: 6px;
        }
        .PageTip {
            font-size: 20px;
            color: #3c3d3d;
            padding: 23px 0;
            border-bottom: 3px solid #6e6e6e;
            border-top: 3px solid #6e6e6e;
            font-weight: bold;
        }
        .PageTip span {
            /*display: none;*/
            margin-left: 30px;
            font-size: 15px;
            font-weight: normal;
        }
        .BaseParameter .PageTip span {
            /*display: inline-block;*/
        }
        .BaseParameter .PageTip {
            border-top: none;
            margin-top: 50px;
            padding-top: 0;
        }
        .PrintArea {
            width: 200mm;
            margin: 0 auto;
        }
        .RightSlogan {
            float: right;
            font-size: 14px;
            font-weight: normal;
            color: #d05549;
        }
        .ParamGroup {
            margin: 0;
            padding: 0;
        }
        .ParamGroup li {
            list-style: none;
            float: left;
            width: 352px;
            line-height: 39px;
            font-size: 14px;
            color: #6e6e6e;
            border-bottom: 1px solid #969696;

            height:39px;
        }
        .ParamGroup li:nth-child(2n) {
            margin-left: 50px;
        }
        /*.BaseParameter .ParamGroup li:nth-child(2n+1) {*/
        /*margin-left: 50px;*/
        /*}*/
        /*.BaseParameter .ParamGroup li:nth-child(2n) {*/
        /*margin-left: 0;*/
        /*}*/
        /*.BaseParameter .ParamGroup li:first-child {*/
        /*margin-left: 0;*/
        /*width: 100%;*/
        /*}*/
        .ParamGroup span {float:left;}
        .ParamGroup .ParameterValue {
            float: right;
            margin-right: 5px;

            white-space:nowrap; text-overflow:ellipsis;        overflow: hidden;

        }

        .BaseParameter li:first-child .ParameterValue{width:275px;}
        .NoBorder {
            border-bottom: none!important;

        }
        @media print  {
            .MainTitle {
                display: none;
            }
            @page {
                size: A4 portrait;
            }
        }
        #head { height: 10mm; margin-bottom:8mm ; overflow: hidden;
            color:#3c3d3d; font:12px/1.5 "Arial", "Microsoft YaHei", "微软雅黑", "SimSun", "宋体";  }

        #head img { width: 45px;float: left;height: 36px;    }

        #head .headTitle {
            height:36px;border-bottom:2px solid #6e6e6e;margin-left: 55px;box-sizing:border-box;
        }
        #head .t3 { display: inline-block; font-size:25px; line-height: 30px;}
        #head .t4 { display: inline-block; font-size:14px;line-height: 36px; float: right;text-align: right;}
    </style>
</head>
<body>
<div class="PrintCarParamLayout">
    <h2 class="MainTitle Clearfix">
        <span>打印车辆配置(请将边距设为默认)</span>
        <a href="javascript:;" class="PrintBtn">打印</a>
    </h2>
    <div class="PrintArea CarConfigWrapper">
        <div id="head" class="Clearfix">
            <img src='/resources/image/TitleLogoBlack.png' >
            <div class="headTitle"><span class='t4'>专注高品质二手车</span><span class='t3'>车辆参数配置</span></div>
        </div>
        <input type="hidden" value='${carConfig}' id="CarConfig">
    </div>
</div>
<script src='<c:url value="/resources/javascript/lib/jquery-2.2.3.min.js" />'></script>
<script src='<c:url value="/resources/javascript/print/printCarConfig.js" />'></script>
</body>
