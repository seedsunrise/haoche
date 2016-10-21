<form id='mainForm' method="post" action="/deal/saveOrderFollow" >

    <input type="hidden" name="carId" value="${orderInfo.carId}" />
    <input type="hidden" name="orderId" value="${orderInfo.id}" />
    <input type="hidden" name="statusId" value="${orderInfo.nextOrderStatus}" />
    <input type="hidden" name="image" value="asd" />
    <input id="payOpt3" class="FormInput" name="alreadyPay" type="text" maxlength="30"  placeholder="支付金额不得低于1000元"><span class="spanStyle"><span class="spanStyle">元</span></span>
    <textarea name="content" class="fl" cols="30" rows="5" placeholder="这是一条备注"></textarea>
    <button  id='ordFowSubmit' class="Btn BtnPrimary BtnStyle" data-pending="保存中..." >提交</button>
    </form>

<c:if test="${orderInfo.orderStatus==2}">
    <div id="ordU-2" class="cont">
        <c:if   test="${orderInfo.orderType == 1}">
            <table class="Table tbStyle ">
                <tbody>

                <tr>
                    <td ><span class="LabelNeed">银行审批已通过</span></td>
                    <td>银行审批已通过</td>
                    <td><input type="checkbox"/></td>
                </tr>
                <tr>
                    <td ><span class="LabelNeed">银行放款金额</span></td>
                    <td>
                        <div class="FormItem ClearFix">
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput" type="text" maxlength="30" name="bankLoanAmount"  placeholder="输入银行放款金额"><span class="spanStyle"><span class="spanStyle">元</span></span>
                            </div>
                        </div></td>
                    <td><input type="checkbox"/></td>
                </tr>
                </tbody>
            </table>
        </c:if>
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
                <td>xx</td>
                <td>${payWay}</td>
                <td>${orderInfo.payTotalNow}元</td>
                <td>xx</td>
                <td>首付</td>
                <td>xx</td>
            </tr>
            </tbody>
        </table>
        <table class="Table tbStyle  ">
            <tbody>
            <tr>
                <td ><span class="LabelNeed">首付金额</span></td>
                <td>
                    <div class="FormItem ClearFix">
                        <div class="FormLayout FormItemControl">
                            <input class="FormInput" type="text" maxlength="30" name="alreadyPay"  placeholder="首付金额不得低于XX元"><span class="spanStyle"><span class="spanStyle">元</span></span>
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
        <table class="Table tbStyle  ">
            <tbody>
            <tr>
                <td><span class="LabelNeed">过户成功</span></td>
                <td>确认过户成功</td>
                <td><input type="checkbox"/></td>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>
<c:if test="${orderInfo.orderStatus==4}">
    <div id="ordU-4" class="cont">
        <c:if  test="${orderInfo.orderType == 1}">
            <table class="Table tbStyle  ">
                <tbody>

                <tr>
                    <td><span class="LabelNeed">放款成功</span></td>
                    <td>已收到XX放款XX万元</td>
                    <td><input type="checkbox" /></td>
                </tr>
                </tbody>
            </table>
        </c:if>
        <c:if  test="${orderInfo.orderType != 1}">
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
                    <td>xx</td>
                    <td>${payWay}</td>
                    <td>${orderInfo.payTotalNow}</td>
                    <td>xx</td>
                    <td>尾款</td>
                    <td>xx</td>
                </tr>
                </tbody>
            </table>
            <table class="Table tbStyle  ">
                <tbody>
                <tr>
                    <td ><span class="LabelNeed">支付尾款</span></td>
                    <td>
                        <div class="FormItem ClearFix">
                            <div class="FormLayout FormItemControl">
                                <input class="FormInput" type="text" maxlength="30" name="alreadyPay"  placeholder="本次支付金额应为XX元"><span class="spanStyle"><span class="spanStyle">元</span></span>
                            </div>
                        </div></td>
                    <td><input type="checkbox"/></td>
                </tr>
                <tr>
                    <td><span class="LabelNeed">客户支付尾款成功</span></td>
                    <td>确认客户已支付尾款成功</td>
                    <td><input type="checkbox"/></td>
                </tr>
                </tbody>
            </table>
        </c:if>
    </div>
</c:if>
<c:if test="${orderInfo.orderStatus==5}">
    <div id="ordU-5" class="cont">
        <table class="Table tbStyle  ">
            <tbody>
            <tr>
                <td><span class="LabelNeed">客户提车成功</span></td>
                <td>确认客户提车已成功</td>
                <td><input type="checkbox" /></td>
            </tr>
            </tbody>
        </table>
    </div>
</c:if>
