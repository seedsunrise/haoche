<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<table class="tb">
    <tr>
        <td width="25%" class="NoPriceStyle"><p class="h3">车辆信息：</p>
            <c:set var="order" value="${map.carInsuranceOrderDTO}" ></c:set>
            <p>车险订单状态：
                <c:if test="${order.insuranceOrderDTO.orderStatus == 0}">
                    待处理
                </c:if>
                <c:if test="${order.insuranceOrderDTO.orderStatus == 1}">
                    已购买
                </c:if>
                <c:if test="${order.insuranceOrderDTO.orderStatus == 2}">
                    已取消
                </c:if>
            </p>
            <c:if test="${order.insuranceOrderDTO.orderStatus == 1}">
            <p>车险总价：${order.insuranceOrderDTO.totalPrice}元</p>
            </c:if>

            <c:if test="${order.insuranceOrderDTO.orderStatus == 0}">
                <c:if test="${order.isChoose == 0 && order.finishQuoteNum > 0}">
                    <p>报价状态：收到 ${order.finishQuoteNum} 份车险报价</p>
                    <c:if test="${orderInfo.orderStatus < 6 }">
                        <p>
                            <a class="BtnOutline ShowInsuranceListAjax" data-carid="${orderInfo.carId}" href="javascript:;" data-cartitle="${orderInfo.carTitle}">重新选择</a>
                        </p>
                    </c:if>
                </c:if>
                <c:if test="${order.isChoose == 0 && order.finishQuoteNum == 0}">
                    <p>报价状态：暂未产出</p>
                </c:if>
                <c:if test="${order.isChoose == 1}">
                    <p>报价状态：已确认车险保单</p>
                    <c:if test="${orderInfo.orderStatus < 6 }">
                    <p>
                        <a class="BtnOutline ShowInsuranceListAjax" data-carid="${orderInfo.carId}" href="javascript:;" data-cartitle="${orderInfo.carTitle}">重新选择</a>
                        <a class="BtnOutline GetPayInsuranceInfo" href="javascript:;" data-url="/carInsurance/toOrderPay?id=${order.insuranceOrderDTO.infoId}">立即认购已选车险保单</a>
                    </p>
                    </c:if>
                </c:if>
            </c:if>
            <%@include file="insuranceQuoteOrderDialogTpl.jsp"%>
        </td>
        <td width="25%" class="MaintainTD">

            <p class="h3">保养：</p>
            <c:if test="${ empty orderInfo.mainTainProject}">
                <p>暂无保养信息
                    <c:if test="${orderInfo.orderStatus < 6 }">
                    <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogMaintain">新增保养</a>
                    </c:if>
                </p>
            </c:if>
            <c:if test="${not empty orderInfo.mainTainProject}">
                <p>保养项目：${orderInfo.mainTainProject}</p>
                <p>保养总价：${orderInfo.mainTainPayTotal}元
                    <c:if test="${orderInfo.mainTainIsPay == 1}">
                        <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogMaintain">修改</a>
                    </c:if>
                </p>
                <p>支付状态：
                    <c:if test="${orderInfo.mainTainIsPay == 1}">
                        未支付
                        <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogMaintainFollow">跟进</a>
                    </c:if>
                    <c:if test="${orderInfo.mainTainIsPay == 9}">
                        已支付
                    </c:if>
                </p>
                <c:if test="${orderInfo.mainTainIsPay == 9}">
                <p>保养状态：
                    <c:if test="${orderInfo.mainTainIsComplete == 1}">
                        未保养
                        <c:if test="${orderInfo.orderStatus < 6 }">
                            <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogMaintainFollow">跟进</a>
                        </c:if>
                    </c:if>
                    <c:if test="${orderInfo.mainTainIsComplete == 9}">
                        已保养
                    </c:if>
                </p>
                </c:if>
            </c:if>
            <div class="OverLay" id="DialogMaintain">
                <div class="Dialog">
                    <div class="DialogTitle">
                        <h1>保养项目</h1>
                        <div class="DialogClose" data-close="#DialogMaintain"><img src="/resources/image/DialogClose.png" alt=""></div>
                    </div>
                    <div class="DialogContent ">
                        <form action="/deal/saveMainTain" method="post" id="DialogMaintainForm" class="AjaxFrom" data-reloadurl="/deal/orderDetail?orderId=${orderInfo.id}" novalidate>
                            <input type="hidden" name="orderId" value="${orderInfo.id}">
                            <input type="hidden" name="mainTainIsPay" value="${orderInfo.mainTainIsPay}">
                            <input type="hidden" name="mainTainIsComplete" value="${orderInfo.mainTainIsComplete}">
                            <input type="hidden" name="mainTainPhoto" value="${orderInfo.mainTainPhoto}">

                            <div class="FormItem ClearFix">
                                <label for="mainTainProject" class="FormLayout MaintainLabel">
                                    <span class="">请请选择保养项目：</span>
                                </label>
                                <div class="MaintainCheckItemList ClearFix" data-maintain="#mainTainProject">
                                    <c:forEach items="${map.maintainProject}" var="item">
                                        <label>
                                            <input type="checkbox" value="${item.name}">${item.name}
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout">
                                    <span>已选择：</span>
                                </label>
                                <input type="text" id="mainTainProject" class="FormInput MaintainPrice ReadOnly Required" data-msg="请选择保养项目" name="mainTainProject" value="${orderInfo.mainTainProject}" readonly>
                            </div>
                            <div class="FormItem ClearFix">
                                <label for="mainTainPayTotal" class="FormLayout">
                                    <span class="">请输入保养总价(元)：</span>
                                </label>

                                <input type="number" min="0" name="mainTainPayTotal" id="mainTainPayTotal" class="FormInput MaintainPrice Required" data-msg="请输入各保养项目的总价"
                                       value="<c:if test="${orderInfo.mainTainPayTotal != 0}">${orderInfo.mainTainPayTotal}</c:if>"
                                       placeholder="请输入各保养项目的总价">
                            </div>
                            <div class="FormGroup BtnCenterWrapper">
                                <button type="submit" class="Btn BtnPrimary AjaxFormBtnSubmit" data-form="#DialogMaintainForm">提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="OverLay" id="DialogMaintainFollow">
                <div class="Dialog BigDialog">
                    <div class="DialogTitle">
                        <h1>保养项目跟进</h1>
                        <div class="DialogClose" data-close="#DialogMaintainFollow"><img src="/resources/image/DialogClose.png" alt=""></div>
                    </div>
                    <div class="DialogContent DialogPadding">
                        <form action="/deal/saveMainTain" method="post" id="DialogMaintainFollowForm" class="AjaxFrom" data-reloadurl="/deal/orderDetail?orderId=${orderInfo.id}" novalidate>
                            <table class="Table MarginTop40">
                                <tr class="THead">
                                    <th>本阶段付款类型</th>
                                    <th>本阶段应付额度（元）</th>
                                </tr>
                                <tr>
                                    <td>保养费用</td>
                                    <td>${orderInfo.mainTainPayTotal}</td>
                                </tr>
                            </table>

                            <table class="Table MarginTop20 FirstTrBorderTop">
                                <tr>
                                    <td><span class="LabelNeed LabelNeedBeforeStyle">项目确认</span></td>
                                    <td colspan="2" class="TDAlignLeft">客户确认保养项目(${orderInfo.mainTainProject})</td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed LabelNeedBeforeStyle">费用支付</span></td>
                                    <td>
                                        <div class="FormItem FormItemNoMarginBottom ClearFix">
                                            <div class="FormLayout FormItemControl">
                                                <input class="FormInput " name="mainTainPayTotal" value="${orderInfo.mainTainPayTotal}"
                                                       type="text" maxlength="30"  placeholder="本次应支付${orderInfo.mainTainPayTotal}元" >
                                                <span class="spanStyle"><span class="spanStyle">元</span>
                                            </span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose">
                                        <input type="checkbox" class="CheckAction" data-check="#mainTainIsPay" data-ischeck="9" data-notcheck="1"
                                               <c:if test="${orderInfo.mainTainIsPay == 9}">checked</c:if>/>
                                    </td>
                                </tr>
                            </table>
                            <table class="Table MarginTop20 FirstTrBorderTop">
                                <tr>
                                    <td style="width:140px;"><span class="LabelNeed LabelNeedBeforeStyle">项目完成</span></td>
                                    <td class="TDAlignLeft">确认保养项目已完成</td>
                                    <td class="CheckIsChose">
                                        <input type="checkbox" class="CheckAction" data-check="#mainTainIsComplete" data-ischeck="9" data-notcheck="1"/></td>
                                </tr>
                                <tr>
                                    <td style="width:140px;"><span class="">施工照片</span></td>
                                    <td colspan="2" >
                                        <div class="FormLayout FormItemControl FileUploadWrapper">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="mainTainPhoto" value="${orderInfo.mainTainPhoto}">
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传施工照片</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <input type="hidden" name="orderId" value="${orderInfo.id}">
                            <input type="hidden" name="mainTainProject" value="${orderInfo.mainTainProject}">
                            <input type="hidden" name="mainTainIsPay" id="mainTainIsPay" value="${orderInfo.mainTainIsPay}">
                            <input type="hidden" name="mainTainIsComplete" id="mainTainIsComplete" value="${orderInfo.mainTainIsComplete}">
                            <div class="FormGroup BtnCenterWrapper BtnWrapperMargin">
                                <button type="submit" class="Btn BtnPrimary AjaxFormBtnSubmit" data-form="#DialogMaintainFollowForm">提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </td>
        <td width="25%" class="MaintainTD">
            <p class="h3">美容：</p>
            <c:if test="${ empty orderInfo.carBeautyProject}">
                <p>暂无美容信息
                    <c:if test="${orderInfo.orderStatus < 6 }">
                    <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogCarBeautiful">新增美容信息</a>
                    </c:if>
                </p>
            </c:if>
            <c:if test="${not empty orderInfo.carBeautyProject}">
                <p>美容项目：${orderInfo.carBeautyProject}</p>
                <p>美容总价：${orderInfo.carBeautyPayTotal}元
                    <c:if test="${orderInfo.carBeautyIsPay == 1}">
                    <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogCarBeautiful">修改</a>
                    </c:if>
                </p>
                <p>支付状态：
                    <c:if test="${orderInfo.carBeautyIsPay == 1}">
                        未支付
                        <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogBeautifulFollow">跟进</a>
                    </c:if>
                    <c:if test="${orderInfo.carBeautyIsPay == 9}">
                        已支付
                    </c:if>
                </p>
                <c:if test="${orderInfo.carBeautyIsPay == 9}">
                    <p>美容状态：
                    <c:if test="${orderInfo.carBeautyIsComplete == 1}">
                        未美容
                        <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogBeautifulFollow">跟进</a>
                    </c:if>
                    <c:if test="${orderInfo.carBeautyIsComplete == 9}">
                        已美容
                    </c:if>
                    </p>
                </c:if>
            </c:if>
            <div class="OverLay" id="DialogCarBeautiful">
                <div class="Dialog">
                    <div class="DialogTitle">
                        <h1>美容项目</h1>
                        <div class="DialogClose" data-close="#DialogCarBeautiful"><img src="/resources/image/DialogClose.png" alt=""></div>
                    </div>
                    <div class="DialogContent ">
                        <form action="/deal/saveCarBeauty" method="post" id="DialogCarBeautifulForm" class="AjaxFrom" data-reloadurl="/deal/orderDetail?orderId=${orderInfo.id}" novalidate>
                            <input type="hidden" name="orderId" value="${orderInfo.id}">
                            <input type="hidden" name="carBeautyIsPay" value="${orderInfo.carBeautyIsPay}">
                            <input type="hidden" name="carBeautyIsComplete" value="${orderInfo.carBeautyIsComplete}">
                            <input type="hidden" name="carBeautyPhoto" value="${orderInfo.carBeautyPhoto}">

                            <div class="FormItem ClearFix">
                                <label for="mainTainProject" class="FormLayout MaintainLabel">
                                    <span class="">请请选择美容项目：</span>
                                </label>
                                <div class="MaintainCheckItemList ClearFix" data-maintain="#carBeautyProject">
                                    <c:forEach items="${map.carBeautyProject}" var="item">
                                        <label>
                                            <input type="checkbox" value="${item.name}">${item.name}
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout">
                                    <span>已选择：</span>
                                </label>
                                <input type="text" id="carBeautyProject" class="FormInput MaintainPrice ReadOnly Required" data-msg="请选择美容项目" name="carBeautyProject" value="${orderInfo.carBeautyProject}" readonly>
                            </div>
                            <div class="FormItem ClearFix">
                                <label for="carBeautyPayTotal" class="FormLayout">
                                    <span class="">请输入美容总价(元)：</span>
                                </label>

                                <input type="number" min="0" name="carBeautyPayTotal" id="carBeautyPayTotal" class="FormInput MaintainPrice Required" data-msg="请输入各美容项目的总价"
                                       value="<c:if test="${orderInfo.carBeautyPayTotal != 0}">${orderInfo.carBeautyPayTotal}</c:if>"
                                       placeholder="请输入各美容项目的总价">
                            </div>
                            <div class="FormGroup BtnCenterWrapper">
                                <button type="submit" class="Btn BtnPrimary AjaxFormBtnSubmit" data-form="#DialogCarBeautifulForm">提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="OverLay" id="DialogBeautifulFollow">
                <div class="Dialog BigDialog">
                    <div class="DialogTitle">
                        <h1>美容项目跟进</h1>
                        <div class="DialogClose" data-close="#DialogBeautifulFollow"><img src="/resources/image/DialogClose.png" alt=""></div>
                    </div>
                    <div class="DialogContent DialogPadding">
                        <form action="/deal/saveCarBeauty" method="post" id="DialogBeautifulFollowForm" class="AjaxFrom" data-reloadurl="/deal/orderDetail?orderId=${orderInfo.id}" novalidate>
                            <table class="Table MarginTop40">
                                <tr class="THead">
                                    <th>本阶段付款类型</th>
                                    <th>本阶段应付额度（元）</th>
                                </tr>
                                <tr>
                                    <td>美容费用</td>
                                    <td>${orderInfo.carBeautyPayTotal}</td>
                                </tr>
                            </table>

                            <table class="Table MarginTop20 FirstTrBorderTop">
                                <tr>
                                    <td><span class="LabelNeed LabelNeedBeforeStyle">项目确认</span></td>
                                    <td colspan="2" class="TDAlignLeft">客户确认美容项目(${orderInfo.carBeautyProject})</td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed LabelNeedBeforeStyle">费用支付</span></td>
                                    <td>
                                        <div class="FormItem FormItemNoMarginBottom ClearFix">
                                            <div class="FormLayout FormItemControl">
                                                <input class="FormInput " name="carBeautyPayTotal" value="${orderInfo.carBeautyPayTotal}"
                                                       type="text" maxlength="30"  placeholder="本次应支付${orderInfo.carBeautyPayTotal}元" >
                                                <span class="spanStyle"><span class="spanStyle">元</span>
                                            </span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose">
                                        <input type="checkbox" class="CheckAction" data-check="#carBeautyIsPay" data-ischeck="9" data-notcheck="1"
                                               <c:if test="${orderInfo.carBeautyIsPay == 9}">checked</c:if>/>
                                    </td>
                                </tr>
                            </table>
                            <table class="Table MarginTop20 FirstTrBorderTop">
                                <tr>
                                    <td style="width:140px;"><span class="LabelNeed LabelNeedBeforeStyle">项目完成</span></td>
                                    <td class="TDAlignLeft">确认美容项目已完成</td>
                                    <td class="CheckIsChose">
                                        <input type="checkbox" class="CheckAction" data-check="#carBeautyIsComplete" data-ischeck="9" data-notcheck="1"/></td>
                                </tr>
                                <tr>
                                    <td style="width:140px;"><span class="">施工照片</span></td>
                                    <td colspan="2" >
                                        <div class="FormLayout FormItemControl FileUploadWrapper">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="carBeautyPhoto" value="${orderInfo.carBeautyPhoto}">
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传施工照片</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <input type="hidden" name="orderId" value="${orderInfo.id}">
                            <input type="hidden" name="carBeautyProject" value="${orderInfo.carBeautyProject}">
                            <input type="hidden" name="carBeautyIsPay" id="carBeautyIsPay" value="${orderInfo.carBeautyIsPay}">
                            <input type="hidden" name="carBeautyIsComplete" id="carBeautyIsComplete" value="${orderInfo.carBeautyIsComplete}">
                            <div class="FormGroup BtnCenterWrapper BtnWrapperMargin">
                                <button type="submit" class="Btn BtnPrimary AjaxFormBtnSubmit" data-form="#DialogBeautifulFollowForm">提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </td>
        <td width="25%" class="MaintainTD"> <p class="h3">精品加装：</p>
            <c:if test="${ empty orderInfo.highQualityAddProject}">
                <p>暂无加装信息
                    <c:if test="${orderInfo.orderStatus < 6 }">
                    <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogCarHighQuality">新增加装信息</a>
                    </c:if>
                </p>
            </c:if>
            <c:if test="${not empty orderInfo.highQualityAddProject}">
                <p>加装项目：${orderInfo.highQualityAddProject}</p>
                <p>加装总价：${orderInfo.highQualityAddPayTotal}元
                    <c:if test="${orderInfo.highQualityAddIsPay == 1}">
                    <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogCarHighQuality">修改</a>
                    </c:if>
                </p>
                <p>支付状态：
                    <c:if test="${orderInfo.highQualityAddIsPay == 1}">
                        未支付
                        <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogHighQualityAddProjectFollow">跟进</a>
                    </c:if>
                    <c:if test="${orderInfo.highQualityAddIsPay == 9}">
                        已支付
                    </c:if>
                </p>
                <c:if test="${orderInfo.highQualityAddIsPay == 9}">
                    <p>加装状态：
                        <c:if test="${orderInfo.highQualityAddIsComplete == 1}">
                            未加装
                            <a class="BtnOutline OpenDialog" href="javascript:;" data-open="#DialogHighQualityAddProjectFollow">跟进</a>
                        </c:if>
                        <c:if test="${orderInfo.highQualityAddIsComplete == 9}">
                            已加装
                        </c:if>
                    </p>
                </c:if>
            </c:if>
            <div class="OverLay" id="DialogCarHighQuality">
                <div class="Dialog">
                    <div class="DialogTitle">
                        <h1>加装项目</h1>
                        <div class="DialogClose" data-close="#DialogCarHighQuality"><img src="/resources/image/DialogClose.png" alt=""></div>
                    </div>
                    <div class="DialogContent ">
                        <form action="/deal/saveHighQualityAdd" method="post" id="DialogCarHighQualityForm" class="AjaxFrom" data-reloadurl="/deal/orderDetail?orderId=${orderInfo.id}" novalidate>
                            <input type="hidden" name="orderId" value="${orderInfo.id}">
                            <input type="hidden" name="highQualityAddIsPay" value="${orderInfo.highQualityAddIsPay}">
                            <input type="hidden" name="highQualityAddIsComplete" value="${orderInfo.highQualityAddIsComplete}">
                            <input type="hidden" name="highQualityAddPhoto" value="${orderInfo.highQualityAddPhoto}">

                            <div class="FormItem ClearFix">
                                <label for="mainTainProject" class="FormLayout MaintainLabel">
                                    <span class="">请请选择加装项目：</span>
                                </label>
                                <div class="MaintainCheckItemList ClearFix" data-maintain="#highQualityAddProject">
                                    <c:forEach items="${map.highQualityAddProject}" var="item">
                                        <label>
                                            <input type="checkbox" value="${item.name}">${item.name}
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout">
                                    <span>已选择：</span>
                                </label>
                                <input type="text" id="highQualityAddProject" class="FormInput MaintainPrice ReadOnly Required" data-msg="请选择加装项目" name="highQualityAddProject" value="${orderInfo.highQualityAddProject}" readonly>
                            </div>
                            <div class="FormItem ClearFix">
                                <label for="carBeautyPayTotal" class="FormLayout">
                                    <span class="">请输入加装总价(元)：</span>
                                </label>

                                <input type="number" min="0" name="highQualityAddPayTotal" id="highQualityAddPayTotal" class="FormInput MaintainPrice Required" data-msg="请输入各加装项目的总价"
                                       value="<c:if test="${orderInfo.highQualityAddPayTotal != 0}">${orderInfo.highQualityAddPayTotal}</c:if>"
                                       placeholder="请输入各加装项目的总价">
                            </div>
                            <div class="FormGroup BtnCenterWrapper">
                                <button type="submit" class="Btn BtnPrimary AjaxFormBtnSubmit" data-form="#DialogCarHighQualityForm">提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="OverLay" id="DialogHighQualityAddProjectFollow">
                <div class="Dialog BigDialog">
                    <div class="DialogTitle">
                        <h1>加装项目跟进</h1>
                        <div class="DialogClose" data-close="#DialogHighQualityAddProjectFollow"><img src="/resources/image/DialogClose.png" alt=""></div>
                    </div>
                    <div class="DialogContent DialogPadding">
                        <form action="/deal/saveHighQualityAdd" method="post" id="DialogHighQualityAddProjectFollowForm" class="AjaxFrom" data-reloadurl="/deal/orderDetail?orderId=${orderInfo.id}" novalidate>
                            <table class="Table MarginTop40">
                                <tr class="THead">
                                    <th>本阶段付款类型</th>
                                    <th>本阶段应付额度（元）</th>
                                </tr>
                                <tr>
                                    <td>加装费用</td>
                                    <td>${orderInfo.highQualityAddPayTotal}</td>
                                </tr>
                            </table>

                            <table class="Table MarginTop20 FirstTrBorderTop">
                                <tr>
                                    <td><span class="LabelNeed LabelNeedBeforeStyle">项目确认</span></td>
                                    <td colspan="2" class="TDAlignLeft">客户确认加装项目(${orderInfo.highQualityAddProject})</td>
                                </tr>
                                <tr>
                                    <td><span class="LabelNeed LabelNeedBeforeStyle">费用支付</span></td>
                                    <td>
                                        <div class="FormItem FormItemNoMarginBottom ClearFix">
                                            <div class="FormLayout FormItemControl">
                                                <input class="FormInput " name="highQualityAddPayTotal" value="${orderInfo.highQualityAddPayTotal}"
                                                       type="text" maxlength="30"  placeholder="本次应支付${orderInfo.highQualityAddPayTotal}元" >
                                                <span class="spanStyle"><span class="spanStyle">元</span>
                                            </span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="CheckIsChose">
                                        <input type="checkbox" class="CheckAction" data-check="#highQualityAddIsPay" data-ischeck="9" data-notcheck="1"
                                               <c:if test="${orderInfo.highQualityAddIsPay == 9}">checked</c:if>/>
                                    </td>
                                </tr>
                            </table>
                            <table class="Table MarginTop20 FirstTrBorderTop">
                                <tr>
                                    <td style="width:140px;"><span class="LabelNeed LabelNeedBeforeStyle">项目完成</span></td>
                                    <td class="TDAlignLeft">确认加装项目已完成</td>
                                    <td class="CheckIsChose">
                                        <input type="checkbox" class="CheckAction" data-check="#highQualityAddIsComplete" data-ischeck="9" data-notcheck="1"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:140px;"><span class="">施工照片</span></td>
                                    <td colspan="2" >
                                        <div class="FormLayout FormItemControl FileUploadWrapper">
                                            <input class="ImageSourceUrl ImageInput" type="text"  name="highQualityAddPhoto" value="${orderInfo.highQualityAddPhoto}">
                                            <div class="PreShowList">
                                                <input type="hidden" name="imagePreFix"  value="${map.imageUrl}">
                                            </div>
                                            <div class="UploadBtnWrapper">
                                                <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                                <a class="Btn" href="javascript:;">上传施工照片</a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <input type="hidden" name="orderId" value="${orderInfo.id}">
                            <input type="hidden" name="highQualityAddProject" value="${orderInfo.highQualityAddProject}">
                            <input type="hidden" name="highQualityAddIsPay" id="highQualityAddIsPay" value="${orderInfo.highQualityAddIsPay}">
                            <input type="hidden" name="highQualityAddIsComplete" id="highQualityAddIsComplete" value="${orderInfo.highQualityAddIsComplete}">
                            <div class="FormGroup BtnCenterWrapper BtnWrapperMargin">
                                <button type="submit" class="Btn BtnPrimary AjaxFormBtnSubmit" data-form="#DialogHighQualityAddProjectFollowForm">提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </td>
    </tr>
</table>