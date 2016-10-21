<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<div class="OverLay DialogOnInsuranceQuote">
    <div class="Dialog">
        <div class="DialogTitle">
            <h1 class="PayInsuranceTitle">选择保项</h1>
            <div class="DialogClose" data-close=".DialogOnInsuranceQuote"><img src="/resources/image/DialogClose.png" alt=""></div>
        </div>
        <div class="DialogContent InsuranceQuoteContentWrapper">
            <h2></h2>
            <form action="/carInsurance/chooseQuote" id="ChoseInsuranceForm">
                <ul class="InsuranceListWrapper ClearFix"></ul>
                <div class="BtnGroup" style="padding-bottom: 25px;margin-top: 0">
                    <a href="javascript:;" class="Btn BtnPrimary ChoseInsurance">提 交</a>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="OverLay DialogHasInsuranceQuote">
    <div class="Dialog">
        <div class="DialogTitle">
            <h1 class="PayInsuranceTitle">确认保项</h1>
            <div class="DialogClose" data-close=".DialogHasInsuranceQuote"><img src="/resources/image/DialogClose.png" alt=""></div>
        </div>
        <div class="DialogContent InsuranceQuoteContentWrapper InsuranceQuoteFromContent">
            <form action="/carInsurance/confirmQuote" id="HasInsuranceQuoteForm">
                <div class="FromInner">
                    <div class="Waiting">加载中...</div>
                </div>
                <div class="BtnGroup">
                    <a href="javascript:;" class="Btn BtnPrimary SubmitQuote ConfirmInsuranceInfo Disabled" data-form="#HasInsuranceQuoteForm">提 交</a>
                    <a href="javascript:;" class="Btn BtnPrimarySecondary ChangeReadOnly">修 改</a>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="OverLay DialogPayInsurance">
    <div  class="Dialog PayInsuranceDialog">
        <div class="DialogTitle">
            <h1 class="PayInsuranceTitle">支付车险订单</h1>
            <div class="DialogClose" data-close=".DialogPayInsurance"><img src="/resources/image/DialogClose.png" alt=""></div>
        </div>
        <form action="/carInsurance/orderPay" novalidate>
            <div class="PayInsuranceInfoWrapper">
                <div class="AjaxInfo">
                </div>

                <table class="Table FormTable">
                    <tr>
                        <td ><span class="LabelNeed">客户支付金额</span></td>
                        <td>
                            <div class="FormItem ClearFix" style="margin-bottom: 0">
                                <div class="FormLayout FormItemControl">
                                    <input name="orderPrice" class="FormInput PayInsurancePrice" type="text" maxlength="30"  placeholder="" data-price=""><span class="spanStyle"><span class="spanStyle">元</span></span>
                                </div>
                            </div></td>
                        <td><input type="checkbox" /></td>
                    </tr>
                    <tr>
                        <td><span class="LabelNeed">车险保单已出</span></td>
                        <td style="text-align: left">校对已出车险保单且无错误</td>
                        <td><input type="checkbox"  /></td>
                    </tr>
                    <tr>
                        <td ><span class="LabelNeed">车险生效时间</span></td>

                        <td>
                            <div class="FormItem ClearFix" style="margin-bottom: 0">
                                <div class="FormLayout FormItemControl">
                                    <div class="DatePickerWrapper">
                                        <input placeholder="请选择时间" name="orderBeginTime" class="CustomInput DatePicker OrderBeginTime" data-format="yyyy-mm-dd"/>
                                    </div>
                                </div>
                            </div></td>
                        <td><input type="checkbox" /></td>
                    </tr>
                    <tr>
                        <td><span class="LabelNeed">车险保单上传</span></td>
                        <td>
                            <div class="FormLayout FormItemControl FileUploadWrapper">
                                <input class="ImageSourceUrl ImageInput  InsuranceOrderPic" name="orderPic" type="text" value="">

                                <div class="PreShowList">
                                    <%--<input type="hidden" name="imagePreFix"  value="${map.imageUrl}">--%>
                                </div>
                                <div class="UploadBtnWrapper">
                                    <input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" >
                                    <a class="Btn" href="javascript:;">上传车险保单</a>
                                </div>
                            </div>
                        </td>
                        <td><input type="checkbox"/></td>
                    </tr>
                </table>
                <table class="Table FormTable">
                    <tr>
                        <td>备注</td>
                        <td colspan="2" class="Relative">
                            <textarea name="orderMemo" class="fl PayOrderMemo" cols="30" rows="5" placeholder="这是一条备注"></textarea>
                        </td>
                    </tr>
                </table>
                <div class="ActionArea ClearFix Center">
                    <button type="submit" class="Btn BtnPrimary SubmitInsurancePayInfo Disabled" data-pending="保存中...">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
