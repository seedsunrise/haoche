<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="订单详情"></c:set>
<%@include file="../../lib/header.jsp"%>
<c:set var="navOn" value="交付"></c:set>
<%@include file="../../lib/nav.jsp"%>

<c:set var="orderInfo" value="${map.orderInfo}"></c:set>

<c:if test="${orderInfo.orderType == 1}"><c:set var="payWay" value="贷款"></c:set></c:if>
<c:if test="${orderInfo.orderType != 1}"><c:set var="payWay" value="全款"></c:set></c:if>

<c:set var="ordSt" value="${map.orderStatusText.OrderStatusText}"></c:set>
<c:set var="nextAct" value="${map.orderStatusText.NextAction}"></c:set>
<c:set var="nextSt" value="${map.orderStatusText.NextOrderStatusText}"></c:set>

<c:if test="${orderInfo.action==1}">
    <c:set var="sidebarOn" value="待完成订单" ></c:set>
</c:if>
<c:if test="${orderInfo.action==2}">
    <c:set var="sidebarOn" value="已提车订单" ></c:set>
</c:if>
<c:if test="${orderInfo.action!=1&&orderInfo.action!=2 }">
    <c:set var="sidebarOn" value="全部订单" ></c:set>
</c:if>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp"%>
    </div>
    <div id="dealDetail" class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/deal/list">交付</a> <i class="fa fa-angle-right"></i></li>
                <li><span>交付管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>订单详情</span></li>
            </ul>
            <table id="orderStatus" class="tb">
                <tr>
                    <td>
                        <%-- 订单 为 非 已售出 --%>
                        <c:if test="${orderInfo.orderStatus < 6 }">
                            <div class="h2" > ${ordSt}  </div>
                            <p>付款方式：${payWay}</p>
                            <c:if test="${orderInfo.orderType == 1}">
                                <p><a href="javascript:;" class="ShowLoanInfo">客户贷款需求明细</a></p>
                                <div class="OverLay" id="DialogShowLoanInfo">
                                    <div class="Dialog BigDialog" style="min-height: 210px">
                                        <div class="DialogTitle">
                                            <h1>客户贷款需求明细</h1>
                                            <div class="DialogClose" data-close="#DialogShowLoanInfo"><img src="/resources/image/DialogClose.png" alt=""></div>
                                        </div>
                                        <div class="DialogContent DialogPadding">
                                            <table class="Table MarginTop20 FirstTrBorderTop">
                                                <tr>
                                                    <td>金融机构</td>
                                                    <td>首付比例</td>
                                                    <td>贷款期限</td>
                                                    <td>首付金额</td>
                                                    <td>贷款本金</td>
                                                </tr>
                                                <tr>
                                                    <td>${orderInfo.bankName}</td>
                                                    <td>${orderInfo.downPayPer}%</td>
                                                    <td>${orderInfo.loanTerm}</td>
                                                    <td>${orderInfo.downPay}</td>
                                                    <td>${orderInfo.loanAmount}</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${(orderinfo.carstatus != 50) && !(orderInfo.carStatus == 30 && orderInfo.orderStatus == 1)}">
                                <a href="javascript:;" id="callOrdFow" class="Btn BtnBrd">订单跟进</a>
                            </c:if>
                        </c:if>
                        <%-- 已售出--%>
                        <c:if test="${orderInfo.orderStatus >= 6}">
                            <div class="h2" >已提车</div>
                            <p>付款方式：${payWay}</p>
                            <br/><br/><br/>
                        </c:if>

                        <p><a target="_blank" href="/deal/print?orderId=${orderInfo.id}" class="hack">打印合同</a>
                            <c:if test="${orderInfo.action==0}">已取消</c:if>
                            <c:if test="${orderInfo.action!=0 &&orderInfo.orderStatus<6 }">
                                <a href="javascript:;" class="AjaxBtnConfirm AjaxBtn" data-msg="取消成功"
                                   data-confirm="你确定要取消订单?" data-pending="取消订单"
                                   data-reloadUrl="/deal/orderDetail?orderId=${orderInfo.id}"
                                   data-url="/deal/cancelOrder?orderId=${orderInfo.id}&statusId=${orderInfo.orderStatus}">取消订单</a>
                            </c:if>
                        </p>
                    </td>
                    <td >
                        <p class="curFlow ">
                            <span class="unHot">当前订单状态：</span>${ordSt}
                            <c:if test="${orderInfo.orderStatus < 6}"><span class="unHot"> , 下一步动作：</span>${nextAct}</c:if>
                        </p>
                        <div class="orderFlow">
                            <ul>
                                <li class="n1"><i></i><span class="h3">订单提交</span><span class="unHot">签合同，交定金</span></li>
                                <li class="n2"><i></i><span class="h3">已签合同</span>
                                    <c:if test="${orderInfo.orderType == 1}"><span class="unHot hack2">贷款审批<br>交齐首付</span></c:if>
                                    <c:if test="${orderInfo.orderType == 2}"><span class="unHot ">交齐首付</span></c:if>
                                </li>
                                <li class="n3"><i></i><span class="h3">待过户</span><span class="unHot">办理过户手续</span></li>
                                <li class="n4"><i></i><span class="h3">已过户</span>
                                    <c:if test="${orderInfo.orderType == 1}"><span class="unHot">放款成功</span></c:if>
                                    <c:if test="${orderInfo.orderType == 2}"><span class="unHot">补齐尾款</span></c:if>
                                </li>
                                <li class="n5"><i></i><span class="h3">待提车</span><span class="unHot">客户提车</span></li>
                                <li class="n6"><i></i><span class="h3">已提车</span><span class="unHot"></span></li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </table>

            <%-- 车险 保养 美容 加装--%>
            <%@include file="carMaintainInfo.jsp"%>

            <table id="orderInfo" class="tb">
                <tr>
                    <td width="30%"><p class="h3">订单信息：</p>
                        <p>订单号：${orderInfo.orderNo}</p>
                        <p>订单创建时间：<fmt:formatDate value="${orderInfo.createdAt}" pattern="yyyy-MM-dd HH:mm" /></p>
                        <p>最新更新时间：<fmt:formatDate value="${orderInfo.updatedAt}" pattern="yyyy-MM-dd HH:mm" /></p>
                        <p>销售代理人：${orderInfo.saleUserName} </p>
                    </td>
                    <%-- ${orderInfo.saleUserName}  saleUserMobile--%>
                    <td width="40%"> <p class="h3">客户信息：</p>
                        <p>客户姓名：${orderInfo.buyUserName}</p>
                        <p>身份证号：${orderInfo.buyUserIdCardNumber}</p>
                        <p>手机号：${orderInfo.buyUserMobile}</p>
                        <p>地址：${orderInfo.buyUserAddress}</p>
                    </td>
                    <td width="30%"> <p class="h3">付款信息：</p>
                        <p>实付车主售价：<fmt:formatNumber type="number" value="${orderInfo.salePriceReal/10000}" pattern="0.00" maxFractionDigits="2"/>万元</p>
                        <p>品质保障服务费：<fmt:formatNumber type="number" value="${orderInfo.qasFees}" pattern="0.00" maxFractionDigits="2"/>元</p>
                        <%--<p>保险/税：<fmt:formatNumber type="number" value="${orderInfo.insurace}" pattern="0.00" maxFractionDigits="2"/>元</p>--%>
                        <p>金融服务费：<fmt:formatNumber type="number" value="${orderInfo.fsFees}" pattern="0.00" maxFractionDigits="2"/>元</p>
                        <p>实际成交总价：<fmt:formatNumber type="number" value="${orderInfo.totalSalePrice}" pattern="0.00" maxFractionDigits="2"/>元</p>
                        <p>付款方式：${payWay}</p>
                        <p>当前付款总额：<fmt:formatNumber type="number" value="${orderInfo.payTotalNow}" pattern="0.00" maxFractionDigits="2"/>元</p>
                        <p><span class="fb">剩余支付金额：<fmt:formatNumber type="number" value="${(orderInfo.totalSalePrice-orderInfo.payTotalNow)>0?orderInfo.totalSalePrice-orderInfo.payTotalNow:0 }" pattern="0.00" maxFractionDigits="2"/>元</span> </p>
                    </td>
                </tr>
            </table>

            <%--车辆信息和订单轨迹--%>
            <%@include file="carInfoAndOrderHistoryInfo.jsp"%>

        </div>
    </div>

    <%--<div class="demo-result-prompt hs-doc-callout hs-doc-callout-info" style="display: none"></div>--%>
    <div class="OverLay DealOverLay">
        <div class="alertBox Dialog">
            <div class="ordFU">
                <div class="title">
                    <div class="h3"><span class="close DialogClose" data-close=".DealOverLay"><img src="/resources/image/DialogClose.png" alt=""></span>订单跟进</div>
                    <c:if test="${orderInfo.orderStatus ==1 && orderInfo.orderType == 1 }">
                        <div class="orderFlow" >
                            <ul>
                                <li class="n${orderInfo.orderStatus} active"><span class="h3">${ordSt}</span><i></i><span class="unHot">${nextAct}</span></li>
                                <li class="n${orderInfo.nextOrderStatus}"><span class="h3">${nextSt}</span><i></i></li>
                            </ul>
                        </div>
                    </c:if>
                    <c:if test="${orderInfo.orderStatus ==1 && orderInfo.orderType == 2 }">
                        <div class="paySelect">
                            本次支付方式：
                            <label><input id="paySelect1" class="paySel payOn" type="radio" name="radioGroup" checked/>仅支付定金</label>
                            <label><input id="paySelect2" class="paySel" type="radio" name="radioGroup"/>支付车身总价30%</label>
                            <label><input id="paySelect3" class="paySel" type="radio" name="radioGroup"/>支付成交总价</label>
                        </div>
                        <div id="orderFlowHack1" class="orderFlow orderFlowHack ordFl_on" >
                            <ul>
                                <li class="n1 active"><span class="h3">订单提交</span><i></i><span  class="unHot">签合同交定金</span></li>
                                <li class="n2"><span class="h3">已签合同</span><i></i></li>
                            </ul>
                        </div>
                        <div id="orderFlowHack2" class="orderFlow orderFlowHack " >
                            <ul>
                                <li class="n1 active"><span class="h3">订单提交</span><i></i><span  class="unHot">支付商品成交总价30%</span></li>
                                <li class="n3"><span class="h3">待过户</span><i></i></li>
                            </ul>
                        </div>
                        <div id="orderFlowHack3" class="orderFlow orderFlowHack " >
                            <ul>
                                <li class="n1 active"><span class="h3">订单提交</span><i></i><span class="unHot">支付商品实际成交总价</span></li>
                                <li class="n3"><span class="h3">待过户</span><i></i></li>
                            </ul>
                        </div>
                    </c:if>


                    <c:if test="${orderInfo.orderStatus !=1}">
                        <div class="orderFlow" >
                            <ul>
                                <li class="n${orderInfo.orderStatus} active"><span class="h3">${ordSt}</span><i></i><span class="unHot">${nextAct}</span></li>
                                <li class="n${orderInfo.nextOrderStatus}"><span class="h3">${nextSt}</span><i></i></li>
                            </ul>
                        </div>
                    </c:if>
                </div>
                <%--  Begin Cont  --%>
                <form id='mainForm' class="FormHorizontal FormHorizontalWidthFull ValidateForm" method="post" action="/deal/saveOrderFollow"  data-reloadurl="/deal/orderDetail?orderId=${orderInfo.id}&statusId=${orderInfo.orderStatus}" novalidate>

                    <input type="hidden" name="carId" value="${orderInfo.carId}" />
                    <input type="hidden" name="orderId" id="OrderInfoOrderId" value="${orderInfo.id}" />
                    <%--<input type="hidden" name="payTotalNow" value="${orderInfo.payTotalNow}" />--%>
                    <input type="hidden" name="statusId" value="${orderInfo.nextOrderStatus}" />

                    <c:if test="${orderInfo.orderStatus==1}">
                        <div id="ordU-1" class="cont">
                            <c:if test="${orderInfo.orderType == 1}">
                                <table class="Table" >
                                    <tbody>
                                    <tr class="THead">
                                        <th>实际成交总价</th>
                                        <th>付款方式</th>
                                        <th>当前付款总额</th>
                                        <th>剩余支付金额</th>
                                        <th>本阶段付款类型</th>
                                        <th>本阶段应付额度</th>
                                    </tr>
                                    <tr>
                                        <td>${orderInfo.totalSalePrice}元</td>
                                        <td>贷款</td>
                                        <td>${orderInfo.payTotalNow}元</td>
                                        <td>${orderInfo.totalSalePrice-orderInfo.payTotalNow>0?orderInfo.totalSalePrice-orderInfo.payTotalNow:0}元</td>
                                        <td>定金</td>
                                        <td>最低1000元</td>
                                    </tr>
                                    </tbody>
                                </table>

                            </c:if>
                            <c:if test="${orderInfo.orderType == 2}">
                                <table class="Table tableHack" id="tableHack1">
                                    <tbody>
                                    <tr class="THead">
                                        <th>实际成交总价</th>
                                        <th>付款方式</th>
                                        <th>当前付款总额</th>
                                        <th>剩余支付金额</th>
                                        <th>本阶段付款类型</th>
                                        <th>本阶段应付额度</th>
                                    </tr>
                                    <tr>
                                        <td>${orderInfo.totalSalePrice}元</td>
                                        <td>全款</td>
                                        <td>${orderInfo.payTotalNow}元</td>
                                        <td>${orderInfo.totalSalePrice-orderInfo.payTotalNow>0?orderInfo.totalSalePrice-orderInfo.payTotalNow:0}元</td>
                                        <td>定金</td>
                                        <td>最低1000元</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="Table tableHack" id="tableHack2">
                                    <tbody>
                                    <tr class="THead">
                                        <th>实际成交总价</th>
                                        <th>付款方式</th>
                                        <th>当前付款总额</th>
                                        <th>剩余支付金额</th>
                                        <th>本阶段付款类型</th>
                                        <th>本阶段应付额度</th>
                                    </tr>
                                    <tr>
                                        <td>${orderInfo.totalSalePrice}元</td>
                                        <td>全款</td>
                                        <td>${orderInfo.payTotalNow}元</td>
                                        <td>${orderInfo.totalSalePrice-orderInfo.payTotalNow>0?orderInfo.totalSalePrice-orderInfo.payTotalNow:0}元</td>
                                        <td>成交总价30%</td>
                                        <td>最低<span id="shouldPay2"><fmt:formatNumber type="number" value="${orderInfo.totalSalePrice*0.3-orderInfo.payTotalNow}" pattern="0.0" maxFractionDigits="1"/></span>元</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="Table tableHack" id="tableHack3">
                                    <tbody>
                                    <tr class="THead">
                                        <th>实际成交总价</th>
                                        <th>付款方式</th>
                                        <th>当前付款总额</th>
                                        <th>剩余支付金额</th>
                                        <th>本阶段付款类型</th>
                                        <th>本阶段应付额度</th>
                                    </tr>
                                    <tr>
                                        <td>${orderInfo.totalSalePrice}元</td>
                                        <td>全款</td>
                                        <td>${orderInfo.payTotalNow}元</td>
                                        <td>${orderInfo.totalSalePrice-orderInfo.payTotalNow>0?orderInfo.totalSalePrice-orderInfo.payTotalNow:0}元</td>
                                        <td>商品实际成交总价</td>
                                        <td><span id="shouldPay3"><fmt:formatNumber type="number" value="${orderInfo.totalSalePrice-orderInfo.payTotalNow}" pattern="0.0" maxFractionDigits="1"/></span>元
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </c:if>

                            <table class="Table tbStyle  ">
                                <tbody>
                                <tr>
                                    <td ><span class="LabelNeed">客户支付金额</span></td>
                                    <td>
                                        <div class="FormItem ClearFix">
                                            <div class="FormLayout FormItemControl">
                                                <input id="alreadyPay1"  required class="FormInput " name="alreadyPay" type="text" maxlength="30"  placeholder="支付金额不得低于1000" ><span class="spanStyle"><span class="spanStyle">元</span></span>
                                            </div>
                                        </div></td>
                                    <td><input type="checkbox" /></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">客户已签署合同</span></td>
                                    <td>合同打印、校对完成并且客户已签署合同</td>
                                    <td><input type="checkbox"  /></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">签署合同原件</span></td>
                                    <td>
                                        <div class="FormLayout FormItemControl FileUploadWrapper">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="contractImage" value=""  >
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传签署合同</a>
                                            </div>
                                        </div>
                                    </td>
                                    <td><input type="checkbox"/></td>
                                </tr>
                                </tbody>
                            </table>

                        </div>
                    </c:if>
                    <c:if test="${orderInfo.orderStatus==2}">
                        <div id="ordU-2" class="cont">
                            <c:if   test="${orderInfo.orderType == 1}">
                                <table class="Table tbStyle ">
                                    <tbody>
                                    <tr>
                                        <td><span class="LabelNeed">资料提交银行</span></td>
                                        <td>确认银行已收到客户完整资料</td>
                                        <td>
                                            <input type="checkbox" class="CheckBoxAjax CheckAction" data-form="#saveBankReceiveInfoForm" data-check="#BankReceiveInformationIsReceive"
                                                   data-successmsg="资料提交银行信息保存成功" data-errormsg="资料提交银行信息保存失败"
                                                   data-ischeck="9" data-notcheck="1" <c:if test="${orderInfo.bankReceiveInformation == 9}">checked</c:if> />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td ><span class="LabelNeed">银行审批已通过</span></td>
                                        <td colspan="2" style="text-align: left">银行审批已通过</td>
                                    </tr>
                                    <tr>
                                        <td ><span class="LabelNeed">银行放款金额</span></td>
                                        <td>
                                            <div class="FormItem ClearFix">
                                                <div class="FormLayout FormItemControl">
                                                    <input value="${orderInfo.bankLoanAmountReady}" id="loanAmountInput" class="FormInput" required type="text" maxlength="30" name="loanAmount"  placeholder="输入银行放款金额"><span class="spanStyle">元</span>
                                                    <a href="javascript:;" id="UpdateLoanAmountInput">保存放款金额</a>
                                                </div>
                                            </div></td>
                                        <td>
                                            <input type="checkbox" class="CheckBoxAjax CheckAction" data-form="#saveBankApprovalForm" data-check="#bankIsApproval"
                                                   data-successmsg="银行放款信息保存成功" data-errormsg="银行放款信息保存失败"
                                                   data-ischeck="9" data-notcheck="1" <c:if test="${orderInfo.bankIsApproval == 9}">checked</c:if> />
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="Table">
                                    <tr class="THead">
                                        <th>实际成交总价</th>
                                        <th>付款方式</th>
                                        <th>当前付款总额</th>
                                        <th>剩余支付金额</th>
                                        <th>银行放款金额</th>
                                        <th>本阶段付款类型</th>
                                        <th>本阶段应付额度</th>
                                    </tr>
                                    <tbody>
                                    <tr>
                                        <td>${orderInfo.totalSalePrice}元</td>
                                        <td>贷款</td>
                                        <td>${orderInfo.payTotalNow}元</td>
                                        <td>${orderInfo.totalSalePrice-orderorderInfo.payTotalNow>0?orderInfo.totalSalePrice-orderInfo.payTotalNow:0}元</td>
                                        <td><span id="loanAmountSpan"></span>元</td>
                                        <td>首付</td>
                                        <td><span id="shouldPaySpan"></span>元</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </c:if>
                            <c:if   test="${orderInfo.orderType == 2}">
                                <table class="Table">
                                    <tr class="THead">
                                        <th>实际成交总价</th>
                                        <th>付款方式</th>
                                        <th>当前付款总额</th>
                                        <th>剩余支付金额</th>
                                        <th>车主售价30%</th>
                                        <th>本阶段付款类型</th>
                                        <th>本阶段应付额度</th>
                                    </tr>
                                    <tbody>
                                    <tr>
                                        <td>${orderInfo.totalSalePrice-orderInfo.insurace}元</td>
                                        <td>全款</td>
                                        <td>${orderInfo.payTotalNow}元</td>
                                        <td>${orderInfo.totalSalePrice-orderInfo.payTotalNow>0?orderInfo.totalSalePrice-orderInfo.payTotalNow:0}元</td>
                                        <td><fmt:formatNumber type="number" value="${orderInfo.salePriceReal*0.3}"  pattern="0.00" maxFractionDigits="1"/>元</td>
                                        <td>首付</td>
                                        <td><fmt:formatNumber type="number" value="${orderInfo.salePriceReal*0.3 + orderInfo.qasFees - orderInfo.payTotalNow}"  pattern="0.00" maxFractionDigits="1"/>元</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </c:if>
                            <table class="Table tbStyle  ">
                                <tbody>
                                <tr>
                                    <td ><span class="LabelNeed">首付金额</span></td>
                                    <td>
                                        <div class="FormItem ClearFix">
                                            <div class="FormLayout FormItemControl">
                                                <input id="alreadyPay2" class="FormInput" required type="text" maxlength="30" name="alreadyPay"  placeholder="输入首付金额" ><span class="spanStyle"><span class="spanStyle">元</span></span>
                                            </div>
                                        </div></td>
                                    <td><input type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">已收到客户首付</span></td>
                                    <td>确认已收到客户购车首付款</td>
                                    <td><input type="checkbox"/></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${orderInfo.orderStatus==3}">
                        <div id="ordU-3" class="cont">
                            <table class="Table tbStyle">
                                <tr>
                                    <td><span class="LabelNeed">新车牌号选取方式</span></td>
                                    <td colspan="2" style="text-align: left">
                                        <label>
                                            <input class="LinkChange" data-linkchange="#licenseSelectType" type="radio" name="licenseSelectType" value="1" <c:if test="${orderInfo.licenseSelectType == 1}">checked</c:if> />
                                            电话选号
                                        </label>
                                        <label>
                                            <input class="LinkChange" data-linkchange="#licenseSelectType" type="radio" name="licenseSelectType" value="9" <c:if test="${orderInfo.licenseSelectType == 9}">checked</c:if> >
                                            客户自选
                                        </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">选号时间</span></td>
                                    <td>
                                        <div class="FormItem ClearFix" style="margin-bottom: 0">
                                            <div class="FormLayout FormItemControl">
                                                <div class="DateTimePickerWrapper DatePickerStyle">
                                                    <input value='<fmt:formatDate value="${orderInfo.licenseSelectDate}" pattern="yyyy-MM-dd HH:mm" />'
                                                           placeholder="请选择时间" name="licenseSelectDate"
                                                           class="CustomInput DateTimePicker OrderBeginTime LinkChange" data-linkchange="#licenseSelectDate" data-format="yyyy年mm月dd日"/>

                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose">
                                        <input type="checkbox" class="CheckBoxAjax" data-form="#saveCarLicenseTypeAndTimeForm"
                                               data-successmsg="车牌号选取信息保存成功" data-errormsg="车牌号选取信息保存失败"
                                               <c:if test="${orderInfo.licenseSelectDate != null}">checked</c:if> />
                                    </td>

                                </tr>
                            </table>
                            <table class="Table tbStyle">
                                <tr>
                                    <td><span class="LabelNeed">新车牌号</span></td>
                                    <td>
                                        <div class="FormLayout FormItemControl">
                                            <input name="newCarLicense" type="text" class="CustomInput" placeholder="车牌号" required>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose"><input type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">新行驶证</span></td>
                                    <td>
                                        <div class="FormLayout FormItemControl FileUploadWrapper">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="newDrivingLicense" required>
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传行驶证图片</a>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose"><input type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">新登记证</span></td>
                                    <td>
                                        <div class="FormLayout FormItemControl FileUploadWrapper">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="newRegistration" required>
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传登记证图片</a>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose"><input type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">过户发票</span></td>
                                    <td>
                                        <div class="FormLayout FormItemControl FileUploadWrapper">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="transferInvoice" required>
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传过户发票图片</a>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose"><input type="checkbox"/></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">过户成功</span></td>
                                    <td>确认过户成功</td>
                                    <td class="CheckIsChose"><input type="checkbox"/></td>
                                </tr>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${orderInfo.orderStatus==4}">
                        <div id="ordU-4" class="cont">
                            <c:if  test="${orderInfo.orderType == 1}">
                                <table class="Table tbStyle  ">
                                    <tr>
                                        <td><span class="LabelNeed">车辆抵押手续完毕</span></td>
                                        <td>确认客户车辆抵押手续办理完成</td>
                                        <td>
                                            <input type="checkbox" class="CheckBoxAjax CheckAction" data-form="#saveCarMortageForm" data-check="#carMortageProcessIsComplete"
                                                   data-successmsg="车辆抵押信息保存成功" data-errormsg="车辆抵押信息保存失败"
                                                   data-ischeck="9" data-notcheck="1" <c:if test="${orderInfo.carMortageProcessIsComplete == 9}">checked</c:if> />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="LabelNeed">放款成功</span></td>
                                        <td colspan="2" style="text-align: left">已收到${orderInfo.bankName}放款<span id="loanAmountSpan"><fmt:formatNumber type="number" value="${map.loanAmount}"  pattern="0.00" maxFractionDigits="0"/></span>元</td>
                                    </tr>
                                </table>
                            </c:if>
                            <c:if  test="${orderInfo.orderType == 2}">
                                <table class="Table">
                                    <tr class="THead">
                                        <th>实际成交总价</th>
                                        <th>付款方式</th>
                                        <th>当前付款总额</th>
                                        <th>剩余支付金额</th>
                                        <th>本阶段付款类型</th>
                                        <th>本阶段应付额度</th>
                                    </tr>
                                    <tbody>
                                    <tr>
                                        <td>${orderInfo.totalSalePrice}元</td>
                                        <td>全款</td>
                                        <td>${orderInfo.payTotalNow}元</td>
                                        <td>${orderInfo.totalSalePrice-orderInfo.payTotalNow}元</td>
                                        <td>尾款</td>
                                        <td><fmt:formatNumber type="number" value="${orderInfo.totalSalePrice-orderInfo.payTotalNow}" pattern="0.0" maxFractionDigits="1"/>元</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <table class="Table tbStyle  ">
                                    <tr>
                                        <td><span class="LabelNeed">约定尾款支付时间</span></td>
                                        <td colspan="2" style="padding-left: 20px">
                                            <div class="FormItem ClearFix" style="margin-bottom: 0">
                                                <div class="FormLayout FormItemControl">
                                                    <div class="DateTimePickerWrapper DatePickerStyle">
                                                        <input value='<fmt:formatDate value="${orderInfo.finalPaymentDate}" pattern="yyyy-MM-dd HH:mm" />'
                                                               placeholder="请选择时间" name="finalPaymentDate"
                                                               class="CustomInput DateTimePicker OrderBeginTime LinkChange" data-linkchange="#finalPaymentDate" data-format="yyyy年mm月dd日"/>

                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td ><span class="LabelNeed">支付尾款</span></td>
                                        <td>
                                            <div class="FormItem ClearFix">
                                                <div class="FormLayout FormItemControl">
                                                    <input id="alreadyPay4" required class="FormInput LinkChange" value="${orderInfo.finalPayment}"
                                                           data-linkchange="#finalPayment" type="text" maxlength="30"
                                                           name="alreadyPay"  placeholder="本次支付金额应为${orderInfo.totalSalePrice-orderInfo.payTotalNow}元" >
                                                    <span class="spanStyle"><span class="spanStyle">元</span></span>
                                                </div>
                                            </div></td>
                                        <td>
                                            <input type="checkbox" class="CheckBoxAjax " data-form="#saveFinalPaymentForm"
                                                   data-successmsg="尾款支付信息保存成功" data-errormsg="尾款支付信息保存失败"
                                                   <c:if test="${orderInfo.finalPayment != 0}">checked</c:if> />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="LabelNeed">客户支付尾款成功</span></td>
                                        <td>确认客户已支付尾款成功</td>
                                        <td><input type="checkbox"/></td>
                                    </tr>
                                </table>
                            </c:if>
                        </div>
                    </c:if>
                    <c:if test="${orderInfo.orderStatus==5}">
                        <div id="ordU-5" class="cont">
                            <table class="Table tbStyle  ">
                                <tr>
                                    <td><span class="LabelNeed">约定提车时间</span></td>
                                    <td>
                                        <div class="FormItem ClearFix" style="margin-bottom: 0">
                                            <div class="FormLayout FormItemControl">
                                                <div class="DateTimePickerWrapper DatePickerStyle">
                                                    <input value='<fmt:formatDate value="${orderInfo.pickCarTime}" pattern="yyyy-MM-dd HH:mm" />'
                                                           placeholder="请选择时间" name="pickCarTime"
                                                           class="CustomInput DateTimePicker OrderBeginTime LinkChange" data-linkchange="#pickCarTime" data-format="yyyy年mm月dd日"/>

                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="checkbox" class="CheckBoxAjax" data-form="#savePickCarForm"
                                               data-successmsg="约定提车时间保存成功" data-errormsg="约定提车时间保存失败"
                                               <c:if test="${orderInfo.pickCarTime != null}">checked</c:if> />
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">客户交接单</span></td>
                                    <td>
                                        <div class="FormLayout FormItemControl FileUploadWrapper EIR">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="contractImage" required>
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传交接单图片</a>
                                            </div>
                                        </div>
                                    </td>
                                    <td><input type="checkbox" /></td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed">客户提车成功</span></td>
                                    <td>确认客户提车已成功</td>
                                    <td><input type="checkbox" /></td>
                                </tr>
                            </table>
                        </div>
                    </c:if>
                    <%--   Begin bottom ----------------------         --%>
                    <div class="followBottom">
                        <table class="Table tbStyle remarks">
                            <tr>
                                <td ><span class="">备注</span></td>
                                <td colspan="2" class="Relative">
                                    <textarea name="content" class="fl" cols="30" rows="5" placeholder="请输入备注"></textarea>
                                    <div class="FormLayout FormItemControl FileUploadWrapper">
                                        <input class="ImageSourceUrl ImageInput" type="text"  name="image" value=""  >
                                        <div class="PreShowList">
                                            <input type="hidden" name="imagePreFix" id="ImagePreFix" value="${map.imageUrl}">
                                        </div>
                                        <div class="UploadBtnWrapper">
                                            <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" multiple>
                                            <a class="Btn" href="javascript:;">上传图片</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <div class="ActionArea ClearFix">
                            <c:if test="${orderInfo.orderStatus == 3 || orderInfo.orderStatus == 5 }">
                                <button  type="submit" class="Btn BtnPrimary BtnStyle FormBtnSubmit " data-pending="保存中..." >提交</button>
                            </c:if>
                            <c:if test="${orderInfo.orderStatus != 3 && orderInfo.orderStatus != 5 }">
                                <c:if test="${orderInfo.orderStatus ==4 && orderInfo.orderType == 1 }">
                                    <button  type="submit" class="Btn BtnPrimary BtnStyle FormBtnSubmit " data-pending="保存中..." >提交</button>
                                </c:if>
                                <c:if test="${orderInfo.orderStatus !=4 || orderInfo.orderType != 1 }">
                                    <button  type="submit" class="Btn BtnPrimary BtnStyle FormBtnSubmit Disabled" data-pending="保存中..." >提交</button>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                </form>
            </div>
            <%-- End ordFu --%>
        </div>
    </div>
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="hidden" value="${orderInfo.nextOrderStatus}" id="nextOrderStatus">
<input type="hidden" value="${orderInfo.totalSalePrice-orderInfo.payTotalNow}" id="TotalSalePrice-PayTotalNow">
<input type="hidden" value="${orderInfo.orderType}" id="orderType">
<input type="hidden" value="${orderInfo.orderStatus}" id="OrderStatusOrderStatus">
<input type="hidden" value="${orderInfo.salePriceReal*0.3 + orderInfo.qasFees - orderInfo.payTotalNow}" id="TotalSalePrice30-PayTotalNow">

<form id="saveBankReceiveInfoForm" action="/deal/saveBankReceiveInfo" method="post" style="display: none">
    <input type="hidden" name="orderId" value="${orderInfo.id}">
    <input type="hidden" id="BankReceiveInformationIsReceive" name="isReceive" value="${orderInfo.bankReceiveInformation}">
</form>
<form id="saveBankApprovalForm" action="/deal/saveBankApproval" method="post" style="display: none">
    <input type="hidden" name="orderId" value="${orderInfo.id}">
    <input type="hidden" name="bankLoanAmount" id="bankLoanAmountReady" value="${orderInfo.bankLoanAmountReady}">
    <input type="hidden" id="bankIsApproval" name="isApproval" value="${orderInfo.bankIsApproval}">
</form>
<form id="saveCarLicenseTypeAndTimeForm" action="/deal/saveCarLicenseTypeAndTime" method="post" style="display: none">
    <input type="hidden" name="orderId" value="${orderInfo.id}">
    <input type="hidden" name="licenseSelectType" id="licenseSelectType" value="${orderInfo.licenseSelectType}">
    <input type="hidden" id="licenseSelectDate" name="licenseSelectDate" value="${orderInfo.licenseSelectDate}">
</form>
<form id="saveCarMortageForm" action="/deal/saveCarMortage" method="post" style="display: none">
    <input type="hidden" name="orderId" value="${orderInfo.id}">
    <input type="hidden" name="isComplete" id="carMortageProcessIsComplete" value="${orderInfo.carMortageProcessIsComplete}">
</form>
<form id="savePickCarForm" action="/deal/savePickCar" method="post" style="display: none">
    <input type="hidden" name="orderId" value="${orderInfo.id}">
    <input type="hidden" name="pickCarTime" id="pickCarTime" value="${orderInfo.pickCarTime}">
</form>

<form id="saveFinalPaymentForm" action="/deal/saveFinalPayment" method="post" style="display: none">
    <input type="hidden" name="orderId" value="${orderInfo.id}">
    <input type="hidden" name="finalPayment" id="finalPayment" value="${orderInfo.finalPayment}">
    <input type="hidden" name="finalPaymentDate" id="finalPaymentDate" value="${orderInfo.finalPaymentDate}">
</form>

<script src='<c:url value="/resources/dist/all.min.js" />'></script>
<script>vex.defaultOptions.className = 'vex-theme-default';</script>
<script src='<c:url value="/resources/javascript/app/dealDetail.js" />'></script>
</body>
</html>
