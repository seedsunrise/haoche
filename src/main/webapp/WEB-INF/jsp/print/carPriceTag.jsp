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
        .PrintPriceTagWrapper {
            width: 1200px;
            margin: 0 auto;
            border: 1px solid #ddd;
            border-top: none;
            background: #fff;
        }
        .PrintSubject {
            height: 100px;
            line-height: 100px;
            font-size: 26px;;
            color: #1b1b1b;
            margin: 0;
            border-bottom: 2px solid #ff5f52;
        }
        .PrintSubject span {
            position: relative;
            margin-left: 54px;
        }
        .PrintSubject span:before {
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
        .PrintPreShowWrapper {
            width: 215mm;
            height: 321mm;
            float: left;
            background: #808080;
            text-align: center;
        }
        .PrintNoticeTitle {
            margin-top: 30px;
            margin-bottom: 20px;
            color: #fff;
            font-size: 18px;
        }
        .PrintNoticeTitle span {
            font-weight: bolder;
            margin: 0 3px;
        }
        .PrintPreShow {
            width: 210mm;
            height: 297mm;
            /*padding-top: 40px;*/
            margin: 0 auto;
            background: #fff;
        }
        .Action {
            position: relative;
            float: left;
            margin-left: 20px;
        }
        .Action label {
            display: block;
            margin-top: 28px;
            margin-bottom: 20px;
            font-size: 18px;
            color: #0d0d0d;
        }
        .Action textarea {
            width: 340px;
            border: 1px solid #e6e6e6;
            outline: none;
            padding: 10px;
            vertical-align: top;
        }

        .Action textarea:focus {
            border: 1px solid #ffb9b3;
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
            .PrintLayout {
                display: none;
            }
            .PrintAreaWrapper {
                width: 190mm;
                position: relative!important;
                top: 0!important;
                border: none!important;
                margin: 0 auto!important;
            }
            .PrintPriceTagWrapper {
                width: 100%;
                border: none!important;
            }
        }
        .PrintAreaWrapper {
            position: absolute;
            top: 179px;
            margin-left: 87.37px;
        }
    </style>
</head>

<body class="PrintPriceTagWrapper">
<div class="PrintLayout">
    <h2 class="PrintSubject Clearfix">
        <span>打印首页价签</span>
        <a href="javascript:;" class="PrintBtn">打印</a>
    </h2>
    <div class="PreShow Clearfix">
        <div class="PrintPreShowWrapper">
            <div class="PrintNoticeTitle">请使用 <span>普通打印机</span> A4纸进行打印</div>
            <div class="PrintPreShow">
            </div>
        </div>
        <div class="Action">
            <label for="ActionSloganTitle">模板标题内容:</label>
            <div class="InputTitleNotice InputNotice">还可以输入<span>0</span>个字</div>
            <textarea name="" class="ChangeBind" id="ActionSloganTitle" data-notice=".InputTitleNotice" maxlength="9">高品质 有保障</textarea>
            <label for="ActionCarLine">品牌车系:</label>
            <div class="InputCarLineNotice InputNotice">还可以输入<span>0</span>个字</div>
            <textarea name="" class="ChangeBind" id="ActionCarLine" data-notice=".InputCarLineNotice" maxlength="12"></textarea>
            <label for="ActionCarTitle">车型标题:</label>
            <div class="InputCarTitleNotice InputNotice">还可以输入<span>0</span>个字</div>
            <textarea name="" class="ChangeBind" id="ActionCarTitle" data-notice=".InputCarTitleNotice" maxlength="30"></textarea>
            <label for="ActionCarTitle">车架号:</label>
            <div class="InputCarTitleNotice InputNotice">还可以输入<span>0</span>个字</div>
            <textarea name="" class="ChangeBind" id="ActionCarVin" data-notice=".InputCarTitleNotice" maxlength="17"></textarea>
        </div>
    </div>
</div>

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
    .PrintPriceTagWrapper {
        background: #fff;
    }
    .PrintArea {
        background: #fff;
        width: 168mm;
        /*height: 297mm;*/
        margin: 0 auto;
    }
    .PrintArea .Padding {
        height: 40px;
    }
    .PrintArea .PrintMainTitle {
        margin: 0;
        padding: 8px;
        height: 36.8mm;
        color: #fff;
        text-align: center;
        background-color: #333!important;
    }
    .PrintArea .PrintMainTitle span {
        display: block;
        height: 32.6mm;
        line-height: 32.6mm;
        border: 1px solid #fff;
        color: #fff!important;
        font-size: 17.88mm;
        font-weight: bold;
    }
    .CarLevelWrapper {
        margin-top: 7.5mm;
    }
    .CarLevel {
        font-weight: bold;
        font-size: 10.65mm;
        color: #333;
    }
    .CarId {
        float: right;
        height: 26px;
        font-size: 16px;;
        line-height: 26px;
        color: #fff!important;
        background-color: #626262!important;
        border-top-left-radius: 15px;
        border-bottom-right-radius: 15px;
        padding: 0 10px;
    }
    .CarId span {
        color: #fff!important;
    }
    .CarName {
        font-size: 8.45mm;
        color: #333;
    }

    .Tag {
        float: left;
        margin-bottom: 0;
        margin-right: 7.9mm;
        width: 16.1mm;
        font-size: 8.03mm;
        color: #333;
    }
    .PriceWrapper {
        position: relative;
        margin-top: 15px;
    }
    .SellPrice {
        font-size: 85px;
        line-height: 93px;
        font-weight: bold;
        float: left;
        color: #333!important;
    }
    .SellPrice span {
        font-size: 29px;
        font-weight: normal;
    }
    .InitialPaymentWrapper {
        position: absolute;
        right: 0;
        top: 0;
    }
    .SaveNotice {
        clear: both;
        margin-top: -25px;
        float: left;
    }
    .InitialPay {
        position: relative;
        display: block;
        width: 200px;
    }
    .InitialPay .SalePriceWrapper {
        position: absolute;
        top: 3px;
        width: 195px;
        text-align: center;
        font-weight: bold;
        font-size: 40px;
        color: #fff!important;
    }
    .InitialPay .Unit {
        font-weight: normal;
        font-size: 25px;
        color: #fff!important;
    }
    .InitialPay img {
        width: 200px;
    }
    .InitialPayNotice {
        font-size: 24px;
    }
    .SaveNotice .PriceSave {
        position: relative;
        margin-left: 15px;
        font-size: 17px;
        font-weight: bold;
        color: #333!important;
    }
    .SaveNotice .PriceSave:before {
        position: absolute;
        left: -11px;
        top: 0px;
        content: " ";
        width: 1.5mm;
        height: 5mm;
        background: #333!important;
    }
    .SaveNotice .PriceOther {
        margin-left: 10px;
        font-size: 11px;
        color: #808080!important;
    }
    .InitialPayNotice {
        color: #333!important;
        margin-top: 10px;
        display: block;
        font-size: 6.74mm;
    }
    .AssuranceFee {
        margin-top: 22px;
        padding: 10px 0;
        text-align: center;
        font-size: 16px;
        color: #808080!important;
        font-weight: bold;
        border-top: 1px solid #707070;
        border-bottom: 1px solid #707070;
    }
    .AssuranceFee .FeeNotice {
        font-size: 11px;
        font-weight: normal;
        color: #808080!important;
    }
    .BaseInfo {
        list-style: none;
        margin: 0;
        padding: 0;
    }
    .BaseInfo li {
        float: left;
        margin-top: 25px;
        text-align: center;
        height:45px;
        width: 33.333333%;
    }
    .BaseInfo li:first-child {
        text-align: left;
    }
    .BaseInfo li:nth-child(4n) {
        text-align: left;
    }
    .BaseInfo li:nth-child(3n) {
        text-align: right;
    }
    .BaseInfo li label {
        font-size: 16px;
        color: #808080!important;
    }
    .BaseInfo li div {
        font-size: 12px;
        color: #333!important;
    }
    .OtherInfo {
        margin-top: 40px;
        position: relative;
    }
    .Service {
        width: 50%;
        margin-top: 17px;
    }
    .Service ul {
        margin: 0;
        padding: 0;
    }
    .Service h3 {
        margin: 0;
        font-weight: bold;
        color: #333!important;
        font-size: 18px;
        padding-left: 70px;
    }
    .Service h4 {
        margin: 0;
        margin-top: 16px;
        padding-left: 40px;
        font-size: 12px;
        color: #808080!important;
    }
    .BaseService {
        position: relative;
        float: left;
    }
    .BaseService:before {
        position: absolute;
        top: 30px;
        right: 0;
        content: " ";
        width: 1px;
        height: 165px;
        background: #707070!important;
    }
    .IdentifyService {
        float: right;
    }
    .ServiceLogo {
        position: absolute;
        left: 278px;
        width: 86px;
    }
    .BaseService .ServiceGroup li {
        font-family: "SimHei";
        margin-top: 8mm;
        list-style: none;
        font-size: 4.23mm;
        color: #707070!important;
        padding-left: 16px;
        position: relative;
        float: left;
        width: 50%;
    }
    .BaseService .ServiceGroup li:nth-child(2n+1) {
        /*width: 45%;*/
        width: 39%;
    }
    .BaseService .ServiceGroup li:before {
        position: absolute;
        left: 0;
        top: 2px;
        content: " ";
        width: 10px;
        height: 10px;
        border-radius: 10px;
        background: #333!important;
    }
    .BaseService .ServiceGroup li:last-child {
        width: 100%;
    }
    .BaseService .ServiceGroup li:last-child:before {
        display: none;
    }
    .BaseService .ServiceGroup li:last-child span {
        position: relative;
        margin-left: 72px;
    }
    .BaseService .ServiceGroup li:last-child span:before {
        position: absolute;
        left: -16px;
        top: 2px;
        content: " ";
        width: 10px;
        height: 10px;
        border-radius: 10px;
        background: #333!important;
    }
    .IdentifyServiceGroup .IdentifyError {
        float: left;
        width: 6px;
        margin-top: 2px;
    }
    .IdentifyServiceGroup .IdentifyOK {
        float: left;
        width: 10px;
        margin-top: 5px;
    }
    .IdentifyServiceGroup li {
        margin-top: 16px;
        list-style: none;
    }
    .IdentifyServiceGroup .OptionWrapper {
        display: inline-block;
        width: 52%;
        margin-left: 55px;
    }
    .OptionName {
        margin-left: 5px;
        font-size: 2.64mm;
        color: #3d3d3d!important;
    }
    .IdentifyServiceGroup .Total {
        font-size: 12px;
        color: #808080!important;
        display: inline-block;
        width: 30px;
    }
    .IdentifyServiceGroup .IdentifyResult {
        font-size: 12px;
        color: #808080!important;
    }
    @media print {
        body {
            -webkit-print-color-adjust: exact;
        }
        @page {
            size: A4 portrait;
        }
    }
</style>

<div class="PrintAreaWrapper">
    <div class="PrintArea">
        <div class="Padding"></div>
        <h2 class="PrintMainTitle"><span class="SloganTitle">高品质 有保障</span></h2>
        <div class="CarLevelWrapper">
            <div class="CarLevel Clearfix ">
                <span class="CarLine">${map.carInfo.lineName}</span>

            </div>
        </div>
        <div class="CarName CarTitle">${map.carInfo.modelName}</div>
        <div class="">车架号：<span class="CarVin">${map.carInfo.carVin}</span></div>
        <div class="Clearfix">
            <div class="PriceWrapper Clearfix">
                <div class="PriceWrapperInner">
                    <label class="Tag">车主售价</label>
                    <span class="SellPrice">${map.carInfo.salePrice/10000}<span>万元</span></span>
                    <div class="SaveNotice"><span class="PriceSave">劲省<span class="SaveTotal">${(map.carInfo.invoicePrice - map.carInfo.salePrice)/10000 }</span>万元</span><span class="PriceOther">同款新车(含税)：<span>${map.carInfo.invoicePrice/10000 }</span>万元</span></div>
                </div>
                <div class="InitialPaymentWrapper">
                <span class="InitialPay">
                    <img src="/resources/image/initialBg.png"/>
                    <span class="SalePriceWrapper">${map.carInfo.salePrice/10000} <span class="Unit">万元</span></span>
                </span>
                    <span class="InitialPayNotice">首付三成即可拥有</span>
                </div>
            </div>
            <div class="AssuranceFee">
                品质保障服务费：${map.carInfo.servicePrice}元 <span class="FeeNotice">(车主售价x3%,封顶8000元,不含在车主售价内)</span>
            </div>
            <ul class="BaseInfo Clearfix">
                <li>
                    <label class="FormatDate">${map.carInfo.firstLicenseDate}</label>
                    <div>首次上牌</div>
                </li>
                <li>
                    <label>${map.carInfo.runKm/10000}万公里</label>
                    <div>行驶里程</div>
                </li>
                <li>
                    <label>${map.carInfo.displacement}</label>
                    <div>排量</div>
                </li>
                <li>
                    <label>${map.carInfo.abbreviation}</label>
                    <div>变速箱</div>
                </li>
                <li>
                    <label>${map.carInfo.environStandard}</label>
                    <div>环保标准</div>
                </li>
                <%--<c:if test="${map.carInfo.annualInspection > 0}">--%>
                    <%--<li>--%>
                        <%--<label class="FormatUDate">${map.carInfo.annualInspection}</label>--%>
                        <%--<div>年检到期</div>--%>
                    <%--</li>--%>
                <%--</c:if>--%>

                <%--<li style="display: none">--%>
                    <%--<label>${map.carInfo.timeOfMaturity}</label>--%>
                    <%--<div>交强险到期</div>--%>
                <%--</li>--%>
            </ul>
            <div class="OtherInfo Clearfix">
                <img src="/resources/image/PriceTagLogo.png" class="ServiceLogo"/>
                <div class="Service BaseService">
                    <h3 style="padding-left: 47px">七大核心服务</h3>
                    <h4 style="padding-left: 20px">助您买到高品质有保障的二手车</h4>
                    <ul class="ServiceGroup Clearfix">
                        <li>精选车源</li>
                        <li>购车助理</li>
                        <li>品质担保</li>
                        <li>交易保障</li>
                        <li>交付轻松</li>
                        <li>延长质保</li>
                        <li><span>售后服务</span></li>
                    </ul>
                </div>
                <div class="Service IdentifyService">
                    <h3 style="margin-left: 70px">鉴定评估报告</h3>
                    <%--${map.identifyReport}--%>
                    <c:if test="${map.identifyReport != null && map.identifyReport.data != null}">
                        <h4 style="margin-left: 25px">经过244项鉴定,该车总分<span style="font-size: 14px;color: #333!important;font-weight: bold;">${map.identifyReport.data.totalScore}分</span>(满分100分)</h4>
                        <ul class="IdentifyServiceGroup">
                            <c:forEach var="identify" items="${map.identifyReport.data.optionData}">
                                <li>
                                    <div class="OptionWrapper Clearfix">
                                        <c:if test="${identify.abNormalNum == 0}">
                                            <img src="/resources/image/identifyOK.png" class="IdentifyOK"/>
                                        </c:if>
                                        <c:if test="${identify.abNormalNum > 0}">
                                            <img src="/resources/image/identifyError.png" class="IdentifyError"/>
                                        </c:if>
                                        <span class="OptionName">${identify.optionName}</span>
                                    </div>
                                    <span class="Total">${identify.optionNum}项</span>
                                <span class="IdentifyResult">
                                    <c:if test="${identify.abNormalNum == 0}">
                                        正常
                                    </c:if>
                                    <c:if test="${identify.abNormalNum > 0}">
                                        ${identify.abNormalNum}项瑕疵
                                    </c:if>
                                </span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${map.identifyReport.data == null }">
                        <h4 style="margin-left: 105px">此车没有鉴定数据</h4>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
