<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=utf-8" %>
<c:set var="title" value="新增商品"></c:set>
<%--<c:if test="${map.status == 20}">--%>
    <%--<c:set var="sidebarOn" value="上架中的商品" ></c:set>--%>
<%--</c:if>--%>
<%--<c:if test="${map.status != 20}">--%>
    <%--<c:set var="sidebarOn" value="全部商品" ></c:set>--%>
<%--</c:if>--%>

<c:if test="${map.status == 20}">
    <c:set var="newUrl" value="/carGoods/new?status=20"></c:set>
</c:if>
<c:if test="${map.status != 20}">
    <c:set var="newUrl" value="/carGoods/new"></c:set>
</c:if>
<c:set var="newName" value="新增商品"></c:set>
<c:set var="navOn" value="商品管理"></c:set>
<%@include file="../lib/header.jsp"%>
<%@include file="../lib/nav.jsp"%>

<div class="Main">
    <div id="SideBar">
        <%@include file="sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/carGoods/list?status=20">商品</a> <i class="fa fa-angle-right"></i></li>
                <li><span>商品管理</span> <i class="fa fa-angle-right"></i></li>
                <li>
                    <span>
                        <c:if test="${list.emp == null}">新增商品</c:if>
                        <c:if test="${list.emp != null}">编辑商品</c:if>
                    </span>
                </li>
            </ul>
            <div class="GoodsStepWrapper">
                <div class="GoodsStep GoodsStepOn GoodsArrow">1、选择车源</div>
                <div class="GoodsStep  GoodsArrow ">2、完善商品信息</div>
                <div class="GoodsStep ">3、确认商品信息</div>
            </div>

            <form action="/carGoods/new?status=${map.status}" method="get" class="FormHorizontal FormHorizontalWidthFull" novalidate>
                <table class="GroupTable" style="width: 100%">
                    <tr>
						<td>
							<table class="Table">
								<tr class="THead">
									<th>选择</th>
									<th>车源信息</th>
									<th>寄售方</th>
									<th>价格信息</th>
									<th>库存天数</th>
								</tr>
								<tbody>
								<c:forEach items="${map.page}" var="goods" varStatus="status">
									<tr class="SourceTableItem <c:if test="${status.index == 0}">Selected</c:if>">
										<td style="width: 50px;">
                                            <input type="radio" name="id" value="${goods.id}" <c:if test="${status.index == 0}">checked</c:if> />
                                        </td>
                                        <td class="CarInfoWrapper">
                                            <div class="CarTitle">${goods.carTitle}</div>
                                            <div class="CarOtherInfo">
                                                <div class="CarOtherInfoItem">
                                                    <span>${goods.firstLicenseDate}上牌</span><span>${goods.runKm/10000}万公里</span><span>VIN:${goods.carVin}</span>
                                                </div>
                                                <div class="CarOtherInfoItem">
                                                    <span>${goods.licenseNum}</span><span>${goods.carColor}</span><span>${goods.carCityName}</span><span>EN:${goods.engineNo}</span>
                                                </div>
                                                <div class="CarOtherInfoItem">
                                                    <span>接车：${fn:substring(goods.takeCarTime,0,16)}</span>
                                                    <span>更新：${fn:substring(goods.updatedAt,0,16)}</span>
                                                </div>
                                            </div>
										</td>
                                        <td style="width: 80px">${goods.carBusinessName}</td>

                                        <c:if test="${map.status ne 3}">
                                            <c:choose>
                                                <c:when test="${goods.salePrice gt 0}">
                                                    <td class="CarPriceWrapper">
                                                        <div>车主售价：<span class="Price">${goods.salePrice/10000}万元</span></div>
                                                        <div class="ServicePriceWrapper">服务费：<span class="Price">${goods.servicePrice}元</span></div>
                                                    </td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td>暂未定价</td>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
										<td>${goods.inventoryDay}</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</td>
                    </tr>
                </table>
                <div class="FormItem ClearFix">
                    <button type="submit" class="Btn BtnPrimary FormBtnSubmit">下一步</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp"%>
