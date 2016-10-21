<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div id="productInfo" class="ShowGroupWrapper">
    <p class="h3">商品信息：</p>
    <table border="1" class="Table ">
        <tr class="THead">
            <th>商品信息</th>
            <th>所属店铺</th>
            <th>商品标价</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        <tbody>
        <tr>
            <td>
                <%--<img class="productImg fl" src="${map.imageUrl}${orderInfo.carMainPhoto}"  >--%>
                <a href="${map.imageUrl}${orderInfo.carMainPhoto}" class="FixImage CarImage FancyBoxImg"
                   data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${orderInfo.carMainPhoto}"></a>
                <div class="txtBox">
                    <p>${orderInfo.carTitle}</p>
                    <p class="unHot"><fmt:formatDate value="${orderInfo.firstLicenseDate}" pattern="yyyy-MM-dd" />上牌  <fmt:formatNumber type="number" value="${orderInfo.runKm/10000}" pattern="0.00" maxFractionDigits="2"/>万公里 ${orderInfo.carColor}  ${orderInfo.displacement}  ${orderInfo.abbreviation}<br>
                        ${orderInfo.carBrandName}  ${orderInfo.carCityName}  鉴定完毕：总分${orderInfo.identifyTotalScore}<br>
                        创建:<fmt:formatDate value="${orderInfo.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                        更新:<fmt:formatDate value="${orderInfo.updatedAt}" pattern="yyyy-MM-dd HH:mm" />
                    </p>
                </div>
            </td>
            <td>${orderInfo.shopName}</td>
            <td>车主售价：<span class="hot"><fmt:formatNumber type="number" value="${orderInfo.salePrice/10000}" pattern="0.00" maxFractionDigits="2"/>万元</span><br>
                品质保障服务费：<span class="hot"><fmt:formatNumber type="number" value="${orderInfo.qasFees}" pattern="0.00" maxFractionDigits="2"/>元</span></td>
            <td>
                <c:if test="${orderInfo.carStatus == 10}">已下架</c:if>
                <c:if test="${orderInfo.carStatus == 20}">上架中</c:if>
                <c:if test="${orderInfo.carStatus == 30}">已锁定</c:if>
                <c:if test="${orderInfo.carStatus == 40}">已售出</c:if>
                <c:if test="${orderInfo.carStatus == 50}">已交付</c:if>
            </td>
            <td>
                <%--<a class="ListBtn BtnPreView" data-url="${map.mobileSiteUrl}/car/dts?idt=${orderInfo.carIdentity}" href="javascript:;">查看商品详情</a>--%>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div id="orderTrack" class="ShowGroupWrapper">
    <p class="h3">订单轨迹</p>
    <ul>
        <c:forEach items="${map.orderSop}" var="orderSop">
            <li>
                <p class="time"><span class="blue"><fmt:formatDate value="${orderSop.updatedAt}" pattern="yyyy-MM-dd HH:mm" /></span></p>
                <div class="cont">
                    <c:if test="${orderSop.statusId=='1'}">
                    <p> 生成了订单，订单状态为：“订单提交”。<lable class="opr">操作人：${orderSop.createUserName}</lable></p>
                    </c:if>
                    <c:if test="${orderSop.statusId=='2'}">
                    <p> 订单状态更改为：“已签合同”；客户支付定金：<fmt:formatNumber type="number" value="${orderSop.alreadyPay}" pattern="0.00" maxFractionDigits="2"/>元；客户签署合同。<lable class="opr">操作人：${orderSop.createUserName}</lable></p>
                    <div class="fl unHot">
                        <label>合同照片：</label>
                                        <span class="txt">
                                             <c:if test="${orderSop.contractImage != ''}"  >
                                                 <c:set var="remarkPrints"  value="${ fn:split(orderSop.contractImage,'|') }" />
                                                 <c:forEach var="remarkPrint" items="${ remarkPrints }" >
                                                     <img class="remarkImg FancyBoxImg" href="${map.imageUrl}${remarkPrint}" src="${map.imageUrl}${remarkPrint}" />

                                                 </c:forEach>

                                             </c:if>

                                        </span>
                    </div>
                    <div class="fl unHot">
                        <lable>备注内容：</lable>
                        <span class="txt">${orderSop.content}</span>
                    </div>
                    <div class="fl unHot">
                        <lable>备注照片：</lable>
                                         <span>
                                             <c:if test="${orderSop.image != ''}"  >
                                                 <c:set var="remarkImgs"  value="${ fn:split(orderSop.image,'|') }" />
                                                 <c:forEach var="remarkImg" items="${ remarkImgs }" >
                                                     <img class="remarkImg FancyBoxImg" href="${map.imageUrl}${remarkImg}" src="${map.imageUrl}${remarkImg}" />
                                                 </c:forEach>
                                             </c:if>
                                        </span>
                        </c:if>
                        <c:if test="${orderSop.statusId=='3'}">
                            <p> 订单状态更改为：“待过户”；
                                <c:if test="${orderInfo.orderType == 1}">审批通过且交齐首付；</c:if>
                                客户支付首付：${orderSop.alreadyPay}元。
                                <lable class="opr">操作人：${orderSop.createUserName}</lable></p>
                        </c:if>
                        <c:if test="${orderSop.statusId=='4'}">
                            <p> 订单状态更改为：“已过户”；办理过户手续完成。<lable class="opr">操作人：${orderSop.createUserName}</lable></p>
                        </c:if>
                        <c:if test="${orderSop.statusId=='5'}">
                            <p> 订单状态更改为：“待提车”；
                                <c:if test="${orderInfo.orderType == 1}">放款成功；支付尾款金额：${orderInfo.loanAmount}</c:if>
                                <c:if test="${orderInfo.orderType == 2}">客户补齐尾款：${orderSop.alreadyPay}</c:if>元。
                                <lable class="opr">操作人：${orderSop.createUserName}</lable></p>
                        </c:if>
                        <c:if test="${orderSop.statusId=='6'}">
                            <p> 订单状态更改为：“已提车”；客户提车成功；照片已上传。<lable class="opr">操作人：${orderSop.createUserName}</lable></p>
                            <div class="fl unHot">
                                <label style="float: left">交接单照片：</label>
                                            <span>
                                                 <c:if test="${orderSop.contractImage != ''}"  >
                                                     <c:set var="remarkPrints"  value="${ fn:split(orderSop.contractImage,'|') }" />
                                                     <c:forEach var="remarkPrint" items="${ remarkPrints }" >
                                                         <img class="remarkImg FancyBoxImg" href="${map.imageUrl}${remarkPrint}" src="${map.imageUrl}${remarkPrint}" />
                                                     </c:forEach>
                                                 </c:if>
                                            </span>
                            </div>
                        </c:if>
                        <c:if test="${orderSop.statusId!='2'}" >
                            <div class="fl unHot">
                                <lable>备注内容：</lable>
                                <span class="txt">${orderSop.content}</span>
                            </div>
                            <div class="fl unHot">
                                <lable>备注照片：</lable>
                                    <span>
                                    <c:if test="${orderSop.image != ''}"  >
                                        <c:set var="remarkImgs"  value="${ fn:split(orderSop.image,'|') }" />
                                        <c:forEach var="remarkImg" items="${ remarkImgs }" >
                                            <img class="remarkImg FancyBoxImg" href="${map.imageUrl}${remarkImg}" src="${map.imageUrl}${remarkImg}" />
                                        </c:forEach>
                                    </c:if>
                                    </span>
                            </div>
                        </c:if>
                    </div>
            </li>

        </c:forEach>
    </ul>
</div>
