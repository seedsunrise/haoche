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
    <script src='<c:url value="/resources/javascript/lib/jquery-scrolltofixed-min.js" />'></script>
	<script src='<c:url value="/resources/javascript/print/printContract.js" />'></script>
	<title>打印成交合同</title>
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
			height: 605mm;
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
			height: 582mm;
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
				width: 210mm;
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
			margin-left: 9px;
            text-align: center;
			/*margin-left: 87.37px;*/
		}
	</style>
</head>

<body class="PrintPriceTagWrapper">
<div class="PrintLayout">
	<h2 class="PrintSubject Clearfix">
		<span>打印成交合同</span>
		<a href="javascript:;" class="PrintBtn">打印</a>
	</h2>
	<div class="PreShow Clearfix">
		<div class="PrintPreShowWrapper">
			<div class="PrintNoticeTitle">请使用 <span>普通打印机</span> A4纸进行打印</div>
			<div class="PrintPreShow">
			</div>
		</div>
		<div class="Action">
			<label for="ActionCustomer">乙方姓名:</label>
			<div class="InputCustomerNotice InputNotice">还可以输入<span>0</span>个字</div>
			<textarea name="" class="ChangeBind" id="ActionCustomer" data-notice=".InputCustomerNotice" maxlength="6">${map.orderInfo.buyUserName}</textarea>
			<label for="ActionCustomerId">身份证号:</label>
			<div class="InputIdNotice InputNotice">还可以输入<span>0</span>个字</div>
			<textarea name="" class="ChangeBind" id="ActionCustomerId" data-notice=".InputIdNotice" maxlength="18">${map.orderInfo.buyUserIdCardNumber}</textarea>
			<label for="ActionCustomerMobile">联系电话:</label>
			<div class="InputMobileNotice InputNotice">还可以输入<span>0</span>个字</div>
			<textarea name="" class="ChangeBind" id="ActionCustomerMobile" data-notice=".InputMobileNotice" maxlength="11">${map.orderInfo.buyUserMobile}</textarea>
			<label for="ActionAddress">通信地址:</label>
			<div class="InputAddressNotice InputNotice">还可以输入<span>0</span>个字</div>
            <textarea name="" class="ChangeBind" id="ActionAddress" data-notice=".InputAddressNotice" maxlength="17">${map.orderInfo.buyUserAddress}</textarea>
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

    .PrintAreaWrapper {
        width: 210mm;
    }
	.PrintArea {
		font-family: SimSun;
		background: #fff;
		/*width: 182.9mm;*/
        width: 185.9mm;
		/*height: 297mm;*/
		margin: 0 auto;
        text-align: left;
        font-size: 12px;
        line-height: 12px;
        color: #252525;
	}
	.PrintArea h2{
		margin-top: 109px;
		font-family: 黑体;
		font-size: 28px;
		line-height: 30px;
		color: #252525;
		font-weight: bold;
		text-align: center;
	}
    .ContractNum {
        margin-top: 34px;
        margin-bottom: 8.9mm;
        text-align: right;
        padding-right: 25.3mm;
        font-size: 10px;
        line-height: 10px;
        color: #252525;
    }
    .TitleTD {
        width: 18.7mm;
    }
    .ContentTD {
        width: 39.7mm;
    }
    .ContentTDSeoncd {
        width: 43.2mm;
    }
    .ContentTDThird {
        width: 45.1mm;
    }
    table {
        margin-bottom: 2.8mm;
    }
    table tr {
        height: 7.8mm;
        border: 1px solid #1f1e22;
        border-right: 0;
    }
    table tr td {
        border-right: 1px solid #1f1e22;
        vertical-align: middle;
        padding-left: 3.6mm;
    }
    .Item {
        margin-bottom: 2.3mm;
    }
    .SubItem {
        display: inline-block;
        width: 75.2mm;
    }
    .SubItem:nth-child(2n+1) {
        margin-right: 12.5mm;
    }
    .UnderLineWrapper {
        display: inline-block;
        width: 57.2mm;
        border-bottom: 1px solid #1f1e22;
    }
    .TitleFirst {
        margin-top: 3.7mm;
        margin-bottom: 4mm;
    }
    .Title {
        margin-bottom: 3.2mm;
    }
    .PageFirst {
        height: 297mm;
    }
    .PageSecond {
        height: 256mm;
    }
    .PageSecond .UnderLineWrapper {
        border-bottom: none;
    }
    .ContractNumShow {
        display: inline-block;
        width: 26mm;
        border-bottom: 1px solid #1f1e22;
    }
    .Earnest {
        display: inline-block;
        width: 25mm;
        border-bottom: 1px solid #1f1e22;
    }
    .EarnestBig {
        display: inline-block;
        width: 25mm;
        border-bottom: 1px solid #1f1e22;
    }
    .ItemRight {
        width: 100%;
        text-align: right;
    }
    h3 {
        margin-top: 15.4mm;
        margin-bottom: 6.2mm;
        font-family: 黑体;
        font-size: 28px;
        line-height: 20px;
        color: #252525;
        font-weight: bold;
        text-align: center;
    }
    .WordIndent {
        /*text-indent: 22px;*/
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
		<div class="PageFirst">
			<h2>汽车交易合同</h2>
			<div class="ContractNum">合同编号：QKHC-JY-<span class="ContractNumShow"></span></div>
            <div class="Item">甲方(或甲方委托人）： <span style="border-bottom: 1px solid #1f1e22; padding: 0 10px">福州乾坤车城电子商务有限公司</span></div>
            <div class="Item">
                <div class="SubItem">
                    <label>通讯地址：</label>
                    <span class="UnderLineWrapper" style="margin-bottom: 6.9mm">福州台江区鳌江路3号乾坤车城</span>
                </div>
                <div class="SubItem">
                    <label>联系电话：</label>
                    <span class="UnderLineWrapper">0591-83610276</span>
                </div>
            </div>
            <div class="Item">
                <div class="SubItem">
                    <label>乙方(购买方）：</label>
                    <span class="UnderLineWrapper Customer" style="width: 49.6mm;border: none">${map.orderInfo.buyUserName}</span>
                </div>
                <div class="SubItem">
                    <label>身份证号：</label>
                    <span class="UnderLineWrapper CustomerId" >${map.orderInfo.buyUserIdCardNumber}</span>
                </div>
            </div>
            <div class="Item">
                <div class="SubItem">
                    <label>通讯地址：</label>
                    <span class="UnderLineWrapper Address">${map.orderInfo.buyUserAddress}</span>
                </div>
                <div class="SubItem">
                    <label>联系电话：</label>
                    <span class="UnderLineWrapper CustomerMobile">${map.orderInfo.buyUserMobile}</span>
                </div>
            </div>
            <div class="Item WordIndent">甲方系车辆所有者或指定代理销售方，为车辆交易的卖方。乙方为车辆交易的购买方。现经甲、乙双方协商一致，就甲乙双方交</div>
            <div class="Item">易汽车事宜达成如下条款。</div>
            <div class="TitleFirst">一、交易标的为以下型号汽车</div>
            <table>
                <tbody>
                    <tr>
                        <td class="TitleTD">车牌号</td>
                        <td class="ContentTD CarNum"></td>
                        <td class="TitleTD">车辆型号</td>
                        <td class="ContentTDSeoncd CarType"></td>
                        <td class="TitleTD">初登日期</td>
                        <td class="ContentTDThird FirstDate"></td>
                    </tr>
                    <tr>
                        <td>车身颜色</td>
                        <td class="CarColor"></td>
                        <td>发动机号</td>
                        <td class="EngineNo"></td>
                        <td>车架号</td>
                        <td class="ChassisNumber"></td>
                    </tr>
                    <tr>
                        <td>车身价格</td>
                        <td></td>
                        <td colspan="4">（大写）：<span class="TotalMoneyBig"></span></td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td colspan="5"></td>
                    </tr>
                </tbody>
            </table>
            <div class="Item">说明：上述车身价格不含保险、按揭贷款服务费、利息等费用。</div>
            <div class="Title"> 二、甲方保证该寄售车辆为无泡水、无火烧、无重大事故车辆，如果描述不符，甲方承担由此引起的所有费用及法律责任。</div>
            <div class="Title">三、甲方保证该车的来源合法，手续齐全、真实有效，并承担因该车和手续不合法引起的法律责任。</div>
            <div class="Title">方保证该车辆所有权完全属于其所有，并不存在设定抵押权，也不存在被司法机关采取依法查封等权利限制措施情形。</div>
            <div class="Title">依照双方之间的协商约定，受乙方委托，甲方代理乙方办理车辆过户变更登记、办理银行按揭贷款以及办理车辆保险</div>
            <div class="Title">（交强险和商业险）等手续，以上费用及税费按照实际发生金额由乙方承担。</div>
            <div class="Title">四、甲方提供购车服务内容包括：</div>
            <div class="Title">1、精选车源：精选全国5年以内10万公里以下的优质二手车源，保证无重大事故，无泡水，无火烧等情况。</div>
            <div class="Title">2、品质担保：240项车况检测，真实车况报告，若查出重大事故、泡水、火烧15天包退，支持4S店验车，选购车辆更加</div>
            <div class="Title">便捷透明。</div>
            <div class="Title">3、购车助理：服务经理提供专业购车咨询，车况与服务讲解，办理交车手续。</div>
            <div class="Title">4、交易保障：买家将车款支付给乾坤好车，过户完成后，乾坤好车再付款给卖家，保证资金与车辆交接安全。</div>
            <div class="Title">5、交付轻松：全国乾坤好车多网点提供过户提档与异地运车服务。</div>
            <div class="Title">6、售后服务：提供车辆终身咨询与24小时道路救援，乾坤好车认证维修厂服务保障。</div>
            <div class="Title">五、乙方购买车辆付款方式：□一次性付款   □按揭付款   □先全款后按揭付款。</div>
            <div class="Title">六、乙方应当于本协议签订之时，向甲方支付购车定金<span class="Earnest"></span>元，（大写：<span class="EarnestBig"></span>），同时，乙方应当于车</div>
            <div class="Title">辆交付前付清剩余车款，否则视为乙方违约。</div>
            <div class="Title">七、车辆保险方式：由甲方代办乙方购买车辆保险。</div>
            <div class="Title">代办保险说明：乙方需购买商业险全险，并由甲方代办，费用以保单发票为准并由乙方自理。</div>
            <div class="Title">八、自本协议签订后，买卖双方不得以任何借口拒绝不买或不卖。如一方违约，违约方按定金金额向守约方支付违约金。</div>
            <div class="Title">九、甲乙双方均已对定购车辆的外观、主要配置及以上信息确认无疑，并同意按上述条件购买车辆，所购车辆均符合国家</div>
            <div class="Title">相关标准。</div>
		</div>
        <div class="PageSecond">
            <div class="Title">十、甲方承诺乙方购买的车辆无泡水、无火烧、无重大事故。如甲方鉴定失误终身可退，乙方可在不限时间内将所购车辆退还给</div>
            <div class="Title">甲方，甲方负责将乙方购车款全额退还。</div>
            <div class="Title">十一、本合同一式两份，甲乙双方各执一份，自双方签字盖章之日起生效。</div>
            <div class="Title">十二、本合同非经双方同意不得变更，非经公司盖章认可的正式文件，不作为本公司合同之附件。</div>
            <div class="Title">十三、其他违约责任及特别约定明细详见合同背面。</div>
            <div class="Title">另附：其他费用明细单，除上述服务费外。</div>
            <div class="Item" style="margin-top: 16.8mm">
                <div class="SubItem">
                    <label>甲方（代理人）：</label>
                    <span class="UnderLineWrapper" style="width: 48mm">福州乾坤车城电子商务有限公司</span>
                </div>
                <div class="SubItem">
                    <label>乙方（代理人）：</label>
                    <span class="UnderLineWrapper" style="width: 48mm"></span>
                </div>
            </div>
            <div class="Item">
                <div class="SubItem ItemRight">
                    <label>身份证（代理人）：</label>
                    <span class="UnderLineWrapper"style="margin-right: 84px;width: 45mm;"></span>
                </div>
            </div>
            <div class="Item">
                <div class="SubItem">
                    <label>联系电话（代理人）：</label>
                    <span class="UnderLineWrapper" style="width: 41.3mm"></span>
                </div>
                <div class="SubItem">
                    <label>联系电话（代理人）：</label>
                    <span class="UnderLineWrapper"style="width: 41.3mm"></span>
                </div>
            </div>
            <div class="Item">
                <div class="SubItem">
                    <label>签约日期：</label>
                    <span class="UnderLineWrapper"></span>
                </div>
                <div class="SubItem">
                    <label>签约日期：</label>
                    <span class="UnderLineWrapper"></span>
                </div>
            </div>
            <h3>违约责任及其他特别约定</h3>
            <div class="Title">一、乙方购买的上述车辆甲方须承诺无违章、产权清晰合法，没有涉及任何因经济纠纷、债权债务而遭受司法机关限制权益等，甲方</div>
            <div class="Title">应当提供完整、合法、有效车辆相关过户手续。</div>
            <div class="Title">二、车辆买卖交易成功本协议签订日期为准，乙方在提车后使用过程中所遇到的任何违章、事故等问题由乙方负责。</div>
            <div class="Title">三、特别告知：汽车交易发票由旧机动车交易市场开具，发票金额可能与车身价格不一致。</div>
            <div class="Title">四、甲方为乙方代办车辆过户上牌手续。</div>
            <div class="Title">1.如乙方委托甲方开车办理车辆过户上牌手续，乙方必须先办理车辆交强险及商业险。如在办理过户上牌手续过程中车辆发生事故，</div>
            <div class="Title">且事故责任属甲方全责时，甲方有义务退还乙方所购买车辆的所有费用，同时乙方车辆的交强险及商业险的权益一并转让给甲方。</div>
            <div class="Title">2.如乙方不购买商业险，可在甲方的陪同下，乙方自行开车办理过户上牌手续，如在办理过户上牌手续过程中车辆发生事故，所有责</div>
            <div class="Title">任由乙方承担。</div>
            <div class="Title">五、违约责任：</div>
            <div class="Title">1、由于罢工、自然灾害、交通、天气、战争等非正常情况造成乙方所购车辆未能按时到车的，甲方可免除违约责任，但甲方应在此</div>
            <div class="Title">类情形发生后5日内书面与乙方联系申请延期到车（如因乙方通讯方式变动原因造成甲方无法通知或送达的，默认乙方同意延期到车</div>
            <div class="Title">时间），延长期限最长不超过三个月，逾期部分甲方应当以乙方已付款部分金额的日万分之五向乙方支付违约金。如果乙方不同意延</div>
            <div class="Title">期交车，双方办理解除合同手续，甲方应将乙方已付款全额退还乙方，互不追究违约责任。</div>
            <div class="Title">2、乙方应按照本合同约定及车辆买卖合同约定支付代理服务费及购车款比例，如乙方逾期付款，按逾期应付款金额日万分之五向甲</div>
            <div class="Title">方支付逾期付款违约金，逾期超过3天，甲方有权终止买卖协议，并有权没收乙方车身价10%的违约金。</div>
            <div class="Title">3、本合同签订之后，乙方不得无故解除合同，乙方擅自解除合同的，视同乙方违约，甲方有权终止买卖协议，并有权没收乙方车身</div>
            <div class="Title">价10%的违约金。</div>
            <div class="Title">4、按揭付款相关特别约定：</div>
            <div class="Title">1）、乙方办理按揭付款，若因乙方未及时提供资料或乙方其他自身原因导致贷款批复时间自订单签订日起超过7个工作日，甲方有权</div>
            <div class="Title">不履约，并有权没收乙方定金及代理服务费，乙方不得追究甲方违约责任。</div>
            <div class="Title">2）、乙方办理按揭付款的，需在接到甲方可办理上牌的通知后两日内向甲方提交身份证、暂住证等上牌所需材料，若乙方逾期提交</div>
            <div class="Title">上牌材料，需根据逾期天数，按照100元/天向甲方支付补偿金。</div>
        </div>
	</div>
</div>
</body>
</html>

