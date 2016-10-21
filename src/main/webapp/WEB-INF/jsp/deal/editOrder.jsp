<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="订单编辑"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="交付"></c:set>
<%@include file="../lib/nav.jsp"%>
<%--<c:if test="${order.orderStatus == 1}">--%>
<c:set var="sidebarOn" value="待完成订单" ></c:set>
<%--</c:if>--%>
<div class="Main">
	<div id="SideBar">
		<%@include file="sideBar.jsp"%>
	</div>
	<div id="dealEdit" class="ContentWrapper">
		<div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/deal/list">交付</a> <i class="fa fa-angle-right"></i></li>
                <li><span>交付管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>编辑订单</span></li>
            </ul>
        <form id='mainForm' class="FormHorizontal FormHorizontalWidthFull ValidateForm" method="post"  action="/deal/saveEditOrder" >
                <input type="hidden" name="id" value="${orderEdit.id}" />
            <table class="GroupTable">
                <tr>
                    <td class="TableGroupTitle">
                        <div class="GroupTitle">订单基本信息<span class="LabelNeedWrapper">（  <span class="LabelNeed">为必填</span>）</span></div>
                    </td>
                    <td class="TableGroupContent">
                        <div class="FormItem ClearFix">
                            <label class="FormLayout"><span class="LabelNeed">销售代理人</span></label>
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput"  type="text"  name="saleUserName" value="${orderEdit.saleUserName}" required>
                            </div>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td class="TableGroupTitle">
                        <div class="GroupTitle">客户信息<span class="LabelNeedWrapper">（  <span class="LabelNeed">为必填</span>）</span></div>
                    </td>
                    <td class="TableGroupContent">
                        <div class="FormItem ClearFix">
                            <label class="FormLayout"><span class="LabelNeed">客户姓名</span></label>
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput"  type="text" id="buyUserName" name="buyUserName" value="${orderEdit.buyUserName}" required>
                            </div>
                        </div>
                        <div class="FormItem ClearFix">
                            <label class="FormLayout" ><span class="LabelNeed">身份证号</span></label>
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput"  type="text"  name="buyUserIdCardNumber" value="${orderEdit.buyUserIdCardNumber}" >
                            </div>
                        </div>
                        <div class="FormItem ClearFix">
                            <label class="FormLayout"><span class="LabelNeed">手机号</span></label>
                            <input type="hidden" value="" name="baseCityName" class="BaseCityName">
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput"  type="text"  name="buyUserMobile" value="${orderEdit.buyUserMobile}">
                            </div>
                        </div>
                        <div class="FormItem ClearFix">
                            <label class="FormLayout" ><span class="LabelNeed">通讯地址</span></label>
                            <input type="hidden" value="" name="baseCityName" class="BaseCityName">
                            <div class="FormLayout FormItemControl">
                                <textarea name="buyUserAddress"  cols="28" rows="5" >${orderEdit.buyUserAddress}</textarea>

                           </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="TableGroupTitle">
                        <div class="GroupTitle">付款信息<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
                    </td>
                    <td class="TableGroupContent">
                        <div class="FormItem ClearFix">
                            <label class="FormLayout" ><span class="LabelNeed">实付车主售价</span></label>
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput priceInput" type="text" name='salePriceReal' value="${orderEdit.salePriceReal}" required><span class="spanStyle">元</span>
                            </div>
                        </div>
                        <div class="FormItem ClearFix">
                            <label class="FormLayout" ><span class="LabelNeed">品质保障服务费</span></label>
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput priceInput" type="text"  name="qasFees" value="${orderEdit.qasFees}"><span class="spanStyle">元</span>
                            </div>
                        </div>
                        <div class="FormItem ClearFix">
                            <label class="FormLayout" ><span class="LabelNeed">保险/税合计</span></label>
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput priceInput" type="text"  name="insurace" value="${orderEdit.insurace}"><span class="spanStyle">元</span>
                            </div>
                        </div>

                        <div class="FormItem ClearFix">
                            <label class="FormLayout" ><span class="LabelNeed">金融服务费</span></label>

                            <div class="FormLayout FormItemControl">
                                <c:if test="${orderEdit.orderType == 1}">
                                    <input class="FormInput priceInput" id="fsFees" type="text" name="fsFees"   value="${orderEdit.fsFees}"><span class="spanStyle">元</span>
                                </c:if>
                                <c:if test="${orderEdit.orderType == 2}">
                                    <input id="fsFees" class="FormInput priceInput" type="text" name="fsFees" readonly="readonly" value="${orderEdit.fsFees}"><span class="spanStyle">元</span>
                                </c:if>
                            </div>
                        </div>

                        <div class="FormItem ClearFix">
                            <label class="FormLayout" >实际成交总价</label>
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput priceInput" type="text" name="totalSalePrice"   readonly="readonly"
                                       value="${orderEdit.salePriceReal+orderEdit.qasFees+orderEdit.insurace+orderEdit.fsFees}"/><span class="spanStyle">元</span>
                            </div>
                        </div>

                        <div class="FormItem ClearFix">
                            <label class="FormLayout" ><span class="LabelNeed">支付方式</span></label>
                            <div class="FormLayout FormItemControl">
                                <c:if test="${orderEdit.orderType == 1}">
                                    <span class="spanStyle spanStyle2" ><input type="radio" id="orderType1"  name="orderType" class='checked'value="1" checked />贷款</span>
                                    <span class="spanStyle spanStyle2"><input type="radio"  id="orderType2" name="orderType" value="2"/>全款</span>
                                </c:if>
                                <c:if test="${orderEdit.orderType == 2}">
                                    <span class="spanStyle spanStyle2" ><input type="radio" id="orderType1"  name="orderType" value="1" />贷款</span>
                                    <span class="spanStyle spanStyle2"><input type="radio" id="orderType2" name="orderType" value="2" class='checked' checked/>全款</span>
                                </c:if>
                            </div>

                    </td>
                </tr>
            </table>

            </table>

            <div class="FormItem ClearFix">
                <button  type="submit" class="Btn BtnPrimary BtnStyle FormBtnSubmit" style="margin-left: 313px" data-pending="保存中..." >提交</button>
            </div>
        </form>


		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>
<script src='/resources/javascript/lib/jquery.form.js'></script>
<script>
$(function(){
    // 贷款·全款
    $(':radio').click(function(){
        $(':radio').removeClass('checked');
        $(this).addClass('checked');
    })

    $('#orderType1').click(function(){
        $('#fsFees').val(${orderEdit.fsFees}).removeAttr('readonly');
        $('input[name="totalSalePrice"]').val(
                parseInt($('input[name="salePriceReal"]').val()? $('input[name="salePriceReal"]').val() : 0)+
                parseInt($('input[name="qasFees"]').val() ?$('input[name="qasFees"]').val():0 )+
                parseInt($('input[name="insurace"]').val()?$('input[name="insurace"]').val():0)+
                parseInt($('input[name="fsFees"]').val()?$('input[name="fsFees"]').val():0)
        );

    })
    $('#orderType2').click(function(){
        <%--alert(${orderEdit.fsFees})--%>

        $('#fsFees').val(0).attr('readonly',"readonly"  );
        $('input[name="totalSalePrice"]').val(
                parseInt($('input[name="salePriceReal"]').val()? $('input[name="salePriceReal"]').val() : 0)+
                parseInt($('input[name="qasFees"]').val() ?$('input[name="qasFees"]').val():0 )+
                parseInt($('input[name="insurace"]').val()?$('input[name="insurace"]').val():0)+
                parseInt($('input[name="fsFees"]').val()?$('input[name="fsFees"]').val():0)
        );


    })

    function checkNum(obj){
        if(  isNaN( obj.val() ) ) {
            obj.val('').attr('placeholder','请输入合法数字');
            return false;
        }
        return true;
    }

    $('.priceInput').on('change input',function(){
        if ( !checkNum( $(this) ) ){
            $('.FormBtnSubmit').addClass('Disabled');
        }else {
            console.log(1)
            $('input[name="totalSalePrice"]').val(
                    parseInt($('input[name="salePriceReal"]').val()? $('input[name="salePriceReal"]').val() : 0)+
                    parseInt($('input[name="qasFees"]').val() ?$('input[name="qasFees"]').val():0 )+
                    parseInt($('input[name="insurace"]').val()?$('input[name="insurace"]').val():0)+
                    parseInt($('input[name="fsFees"]').val()?$('input[name="fsFees"]').val():0)
            );
            $('.FormBtnSubmit').removeClass('Disabled');
        }
    })


})
</script>
