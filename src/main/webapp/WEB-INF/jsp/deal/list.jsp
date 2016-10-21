<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="交付"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="交付"></c:set>
<%@include file="../lib/nav.jsp"%>

<div class="Main">
    <div id="SideBar">
        <%@include file="sideBar.jsp"%>
    </div>
    <div id="dealList" class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/deal/list">交付</a> <i class="fa fa-angle-right"></i></li>
                <li><span>交付管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>待完成订单</span></li>
            </ul>
            <div class="SearchBox DealSearchBox ClearFix" >
                <form action="/deal/list" id="mainForm" class="MainSearchForm">
                    <input type="hidden" value=${map.carAction} name="carAction">
                    <div class="SearchGroup">
                        <div class="DatePickerWrapper DatePickerStart">
                            <input value="<%= request.getParameter("startTime") != null ? request.getParameter("startTime") : ""%>"
                                   data-date-end-date="0d"
                                   placeholder="下单时间" class="CustomInput DatePicker" name="startTime" id="startTime"/>
                        </div>
                    </div>
                    <div class="SearchGroup">
                        <div class="DatePickerWrapper">
                            <input value="<%= request.getParameter("endTime") != null ? request.getParameter("endTime") : ""%>"
                                   data-date-end-date="0d" data-start="#startTime"
                                   placeholder="下单时间" class="CustomInput DatePicker" name="endTime" id="endTime"/>
                        </div>
                    </div>
                    <div class="SearchGroup">
                        <select name="carBrandId" id="carBrandId" class="CustomSelect LinkSelect" data-link="carLineId" data-url="/carSource/queryLine?carBrandId="  value="<%= request.getParameter("carBrandId") %>">
                            <option value="">全部品牌</option>
                            <c:forEach var="carBrand" items="${map.carBrandList}">
                                <option value="${carBrand.id}">${carBrand.brandName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="SearchGroup">
                        <select name="carLineId" id="carLineId" class="CustomSelect LinkedInput"  value="<%= request.getParameter("carLineId") %>">
                            <option value="">全部车系</option>
                        </select>
                    </div>
                    <div class="SearchGroup">
                        <select name="payType" id="payType" class="CustomSelect"  value="<%= request.getParameter("payType") %>">
                            <option value="0" selected>付款类型</option>
                            <option value="1" >贷款</option>
                            <option value="2">全款</option>
                        </select>
                    </div>

                    <div class="OtherSearchInfoBorder"></div>
                    <div class="OtherSearchInfo">
                        <div class="SortWrapper">
                            <input id="sortInput" name="sort" type="hidden" value="${map.paramDTO.sort}"/>
                            <input id="scInput" name="order" type="hidden" value="${map.paramDTO.order}"/>
                            <ul class="SortList">
                                <li>
                                    <a class="SortItemWrapper" href="javascript:;" sort="createdAt">
                                        <span>下单时间</span>
                                        <c:if test="${map.paramDTO.sort == 'createdAt' && map.paramDTO.order == 'asc'}">
                                            <img src="/resources/image/SortAsc.png">
                                        </c:if>
                                        <c:if test="${map.paramDTO.sort == 'createdAt' && map.paramDTO.order == 'desc'}">
                                            <img src="/resources/image/SortDesc.png">
                                        </c:if>
                                    </a>
                                </li>
                                <li>
                                    <a class="SortItemWrapper" href="javascript:;" sort="totalSalePrice">
                                        <span>实际成交总价</span>
                                        <c:if test="${map.paramDTO.sort == 'totalSalePrice' && map.paramDTO.order == 'asc'}">
                                            <img src="/resources/image/SortAsc.png">
                                        </c:if>
                                        <c:if test="${map.paramDTO.sort == 'totalSalePrice' && map.paramDTO.order == 'desc'}">
                                            <img src="/resources/image/SortDesc.png">
                                        </c:if>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="SearchButtonWrapper ClearFix SearchButtonWrapperMore">
                            <input class="CustomInput InputMarginLeft" placeholder="车辆标题/订单号/客户姓名" type="text" name="search"
                                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : ""%>" />
                            <button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
                        </div>
                    </div>

                    <div class="StatusGroup">
                        <c:if test="${map.carAction != 2 }">
                            <input type="hidden" name="orderStatusSearch" value="0" />
                            <span class="StatusGroupLabel">订单状态：</span>
                            <label><input type="checkbox" class="checkAll" data-val="0" >全部</label>
                            <label><input type="checkbox" class="checkSingle" data-val="1">订单提交</label>
                            <label><input type="checkbox" class="checkSingle" data-val="2">已签合同</label>
                            <label><input type="checkbox" class="checkSingle" data-val="3">待过户</label>
                            <label><input type="checkbox" class="checkSingle" data-val="4" >已过户</label>
                            <label><input type="checkbox" class="checkSingle" data-val="5" >待提车</label>
                            <c:if test="${map.carAction == 0 }">
                                <lable><input type="checkbox" data-val="6" >已提车</lable>
                                <lable><input type="checkbox" data-val="7" >已取消</lable>
                            </c:if>
                        </c:if>
                    </div>
                </form>
            </div>
            <table border="1" class="Table tb45  ">
                <tr class="THead">
                    <th width="120">订单号</th>
                    <th>商品信息</th>
                    <th>客户</th>
                    <th>价格</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:forEach items="${map.page.list}" var="order">
                    <tr>
                        <td>${order.orderNo}</td>
                        <td>
                            <a href="${map.imageUrl}${order.carMainPhoto}" class="FixImage CarImage FancyBoxImg"
                               data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${order.carMainPhoto}"></a>
                            <%--<img class="productImg fl" src="${map.imageUrl}${order.carMainPhoto}"  >--%>
                            <div class="txtBox">
                                <p>${order.carTitle}</p>
                                <p class="unHot"><fmt:formatDate value="${order.firstLicenseDate}" pattern="yyyy-MM-dd" />上牌
                                    <fmt:formatNumber type="number" value="${order.runKm/10000}" pattern="0.00" maxFractionDigits="2"/>万公里  ${order.carColor}<br>
                                    下单时间：<fmt:formatDate value="${order.createdAt}" pattern="yyyy-MM-dd HH:mm" /> <br>
                                    状态更新：<fmt:formatDate value="${order.updatedAt}" pattern="yyyy-MM-dd HH:mm" />
                                </p>
                            </div>
                        </td>
                        <td>${order.buyUserName}</td>
                        <td>车主售价：<fmt:formatNumber type="number" value="${order.salePrice/10000}" pattern="0.00" maxFractionDigits="2"/>万元<br/>
                            品质保障服务费：${order.qasFees}元<br/>
                            金融/保险/税合计：${(order.fsFees+order.insurace)}元<br/>
                            实际成交总价：<span class="hot">${order.totalSalePrice}元
                        </td>
                        <td><c:if test="${order.action!=0}">
                            付款方式：<c:if test="${order.orderType == 1}">贷款</c:if><c:if test="${order.orderType == 2}">全款</c:if>  <br/>
                            订单状态：<c:choose>
                                <c:when test="${order.orderStatus=='1'}"> 订单提交 </c:when>
                                <c:when test="${order.orderStatus=='2'}"> 已签合同 </c:when>
                                <c:when test="${order.orderStatus=='3'}"> 待过户 </c:when>
                                <c:when test="${order.orderStatus=='4'}"> 已过户 </c:when>
                                <c:when test="${order.orderStatus=='5'}"> 待提车 </c:when>
                                <c:when test="${order.orderStatus=='6'}"> 已提车 </c:when>
                            </c:choose> <br/>
                            下一步动作：<c:choose>
                                <c:when test="${order.nextOrderStatus=='2'}"> 签合同，交定金 </c:when>
                                <c:when test="${order.nextOrderStatus=='3'}"> 贷款审批，交齐首付 </c:when>
                                <c:when test="${order.nextOrderStatus=='4'}"> 办理过户手续 </c:when>
                                <c:when test="${order.nextOrderStatus=='5'}"> 放款成功 </c:when>
                                <c:when test="${order.nextOrderStatus=='6'}"> 客户提车 </c:when>
                            </c:choose>
                            </c:if>
                            <c:if test="${order.action==0}">订单状态：已取消</c:if>

                            <br/>当前已付总额：${order.payTotalNow}元</td>

                        <td>
                            <a href="/deal/orderDetail?orderId=${order.id}">订单详情</a>
                            <br/><a target="_blank" href="/deal/print?orderId=${order.id}">打印合同</a>
                            <c:if test="${order.orderStatus == 1}"><br/><a href="/deal/editOrder?orderId=${order.id}">编辑</a></c:if>
                            <c:if test="${order.action!=0 &&order.orderStatus<6 }"><br/>
                                <a href="javascript:;" class="AjaxBtnConfirm AjaxBtn" data-msg="取消成功"
                                   data-confirm="你确定要取消订单?" data-pending="取消订单"
                                   data-reloadUrl="/deal/list?carAction=1"
                                   data-url="/deal/cancelOrder?orderId=${order.id}&statusId=${order.orderStatus}">取消订单</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:set var="page" value="${map.page}"></c:set>
            <c:set var="pageUrl" value="/deal/list?${map.param}"></c:set>
            <%@include file="../lib/pagination.jsp"%>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp"%>
<script>
    $(function(){
        var  str = window.location.search,
             index= str.indexOf('orderStatusSearch'),
             $checkBoxs = $('.StatusGroup input:checkbox');
        $checkBoxs.removeAttr('checked');
        if( index == -1){
            $checkBoxs.eq(0).attr('checked',true);
        }else{
            $checkBoxs.eq( str.substring(index+18)).attr('checked',true);  // 18 是orderStatusSearch长度+1
        }
//        console.log(str.substring(str.indexOf('orderStatusSearch')+18))

        // 左侧 菜单 当前项高亮
        var carAction = ${map.carAction};
        $('.SideBarMainTitle').removeClass('SideBarOn');
        if (isNaN(carAction) || carAction ==1 ){
            $('.SideBarMainTitle').eq(0).addClass('SideBarOn');
        }
        if (carAction ==2 ){
            $('.SideBarMainTitle').eq(1).addClass('SideBarOn');
        }
        if ( carAction ==0 ){
            $('.SideBarMainTitle').eq(2).addClass('SideBarOn');
        }
        // 默认复选框
        // 排序复选框
        $('.StatusGroup input:checkbox').click(function(){
            console.log("change");
            var $single = $('.checkSingle');
            var $ods = $("[name='orderStatusSearch']");
            if( $(this).hasClass('checkAll')){
                if ( $(this).attr('checked')){
                    return false;
                }else{
                    $single.removeAttr('checked');
                    $ods.val(0);
                }
            }else{
                $('.checkAll').removeAttr('checked');
                $ods.val($(this).data('val'));
            }
            $('.MainSearchForm').submit();
        })
 });
</script>