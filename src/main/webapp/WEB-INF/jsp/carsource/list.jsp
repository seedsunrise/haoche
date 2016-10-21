<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车源"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="车源"></c:set>
<%@include file="../lib/nav.jsp"%>
<c:choose>
    <c:when test="${map.status eq 1}">
        <c:set var="sidebarOn" value="库存车源" ></c:set>
    </c:when>
    <c:when test="${map.status eq 2}">
        <c:set var="sidebarOn" value="已售出车源" ></c:set>
    </c:when>
    <c:when test="${map.status eq 3}">
        <c:set var="sidebarOn" value="已退车源" ></c:set>
    </c:when>
</c:choose>

<c:set var="newUrl" value="/carSource/edit"></c:set>
<c:set var="newName" value="录入车源"></c:set>

<div class="Main">
    <c:if test="${CurrentUser.check('/carSource/list')}">
        <div id="SideBar">
            <%@include file="sideBar.jsp"%>
        </div>
        <div class="ContentWrapper">

            <div class="MainContent">
                <ul class="BreadCrumb">
                    <li><a href="#">车源</a> <i class="fa fa-angle-right"></i></li>
                    <li>
                        <c:choose>
                            <c:when test="${map.status eq 1}"><span>库存车源</span></c:when>
                            <c:when test="${map.status eq 2}"><span>已售出车源</span></c:when>
                            <c:when test="${map.status eq 3}"><span>已退车源</span></c:when>
                        </c:choose>
                    </li>
                </ul>
                <div class="SearchBox ClearFix">
                    <form action="/carSource/list" novalidate class="MainSearchForm">
                        <input name="status" type="hidden" value="${map.status}"/>
                        <input id="sortInput" name="sort" type="hidden" value="${map.sort}"/>
                        <input id="scInput" name="sc" type="hidden" value="${map.sc}"/>
                        <div class="SearchGroup">
                            <select name="carBusinessId" id="carBusinessId" class="CustomSelect" value="<%= request.getParameter("carBusinessId") %>">
                                <option value="">寄售商</option>
                                <c:forEach var="carBusiness" items="${map.carBusinessList}">
                                    <option value="${carBusiness.id}">${carBusiness.businessName}</option>
                                </c:forEach>

                            </select>
                        </div>
                        <div class="SearchGroup">
                            <select name="carBrandId" id="carBrandId" class="CustomSelect LinkSelect" data-link="carLineId" data-url="/carSource/queryLine?carBrandId=" required value="<%= request.getParameter("carBrandId") %>">
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
                            <select name="runKm" id="runKm" class="CustomSelect"  value="<%= request.getParameter("runKm") %>">
                                <option value="">里程不限</option>
                                <option value="10000">1万公里</option>
                                <option value="50000">5万公里</option>
                                <option value="100000">10万公里</option>
                                <option value="200000">20万公里</option>
                            </select>
                        </div>
                        <div class="SearchGroup">
                            <select name="carColor" id="carColor" class="CustomSelect"  value="<%= request.getParameter("carColor") %>">
                                <option value="">颜色不限</option>
                                <option value="黑色">黑色</option>
                                <option value="红色">红色</option>
                                <option value="深灰色">深灰色</option>
                                <option value="粉红色">粉红色</option>
                                <option value="银灰色">银灰色</option>
                                <option value="紫色">紫色</option>
                                <option value="白色">白色</option>
                                <option value="蓝色">蓝色</option>
                                <option value="香槟色">香槟色</option>
                                <option value="绿色">绿色</option>
                                <option value="黄色">黄色</option>
                                <option value="咖啡色">咖啡色</option>
                                <option value="橙色">橙色</option>
                            </select>
                        </div>
                        <div class="Clear"></div>
                        <div class="SearchGroup">
                            <div class="DatePickerWrapper DatePickerStart">
                                <input value="<%= request.getParameter("firstLicenseDateStart") != null ? request.getParameter("firstLicenseDateStart") : "" %>"
                                       placeholder="首次上牌时间" class="CustomInput DatePicker" data-date-end-date="0d"
                                       name="firstLicenseDateStart" id="FirstLicenseDateStart"/>
                            </div>
                        </div>
                        <div class="SearchGroup">
                            <div class="DatePickerWrapper">
                                <input value="<%= request.getParameter("firstLicenseDateEnd") != null ? request.getParameter("firstLicenseDateEnd") : ""%>"
                                       data-start="#FirstLicenseDateStart" data-date-end-date="0d"
                                       placeholder="首次上牌时间" class="CustomInput DatePicker" name="firstLicenseDateEnd" id="FirstLicenseDateEnd"/>
                            </div>
                        </div>
                        <div class="SearchGroup DatePickerStart">
                            <div class="DatePickerWrapper">
                                <input value="<%= request.getParameter("takeCarTimeStart") != null ? request.getParameter("takeCarTimeStart") : ""%>"
                                       data-date-end-date="0d" placeholder="接车时间" class="CustomInput DatePicker" name="takeCarTimeStart" id="TakeCarTimeStart"/>
                            </div>
                        </div>
                        <div class="SearchGroup">
                            <div class="DatePickerWrapper">
                                <input value="<%= request.getParameter("takeCarTimeEnd") != null ? request.getParameter("takeCarTimeEnd") : ""%>"
                                       data-date-end-date="0d" data-start="#TakeCarTimeStart"
                                       placeholder="接车时间" class="CustomInput DatePicker" name="takeCarTimeEnd"/>
                            </div>
                        </div>
                        <div class="OtherSearchInfoBorder"></div>
                        <div class="OtherSearchInfo">
                            <div class="SortWrapper">
                                <ul class="SortList">
                                    <li>
                                        <a class="SortItemWrapper" href="javascript:;" sort="takeCarTime">
                                            <span>接车时间</span>
                                            <c:if test="${map.sort == 'takeCarTime' && map.sc == 'asc'}">
                                                <img src="/resources/image/SortAsc.png">
                                            </c:if>
                                            <c:if test="${map.sort == 'takeCarTime' && map.sc == 'desc'}">
                                                <img src="/resources/image/SortDesc.png">
                                            </c:if>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="SortItemWrapper" href="javascript:;" sort="salePrice">
                                            <span>车主售价</span>
                                            <c:if test="${map.sort == 'salePrice' && map.sc == 'asc'}">
                                                <img src="/resources/image/SortAsc.png">
                                            </c:if>
                                            <c:if test="${map.sort == 'salePrice' && map.sc == 'desc'}">
                                                <img src="/resources/image/SortDesc.png">
                                            </c:if>
                                        </a>
                                    <li>
                                    <li>
                                        <c:choose>
                                            <c:when test="${map.status eq 1}">
                                                <a class="SortItemWrapper" href="javascript:;" sort="createdAt">
                                                    <span>库存天数</span>
                                                    <c:if test="${map.sort == 'createdAt' && map.sc == 'asc'}">
                                                        <img src="/resources/image/SortAsc.png">
                                                    </c:if>
                                                    <c:if test="${map.sort == 'createdAt' && map.sc == 'desc'}">
                                                        <img src="/resources/image/SortDesc.png">
                                                    </c:if>
                                                </a>
                                            </c:when>
                                            <c:when test="${map.status eq 2}">
                                                <a class="SortItemWrapper" href="javascript:;" sort="saleOutInventoryDays">
                                                    <span>售时库存天数</span>
                                                    <c:if test="${map.sort == 'saleOutInventoryDays' && map.sc == 'asc'}">
                                                        <img src="/resources/image/SortDesc.png">
                                                    </c:if>
                                                    <c:if test="${map.sort == 'saleOutInventoryDays' && map.sc == 'desc'}">
                                                        <img src="/resources/image/SortAsc.png">
                                                    </c:if>
                                                </a>
                                            </c:when>
                                            <c:when test="${map.status eq 3}">
                                                <a class="SortItemWrapper" href="javascript:;" sort="recedeInventoryDays">
                                                    <span>退时库存天数</span>
                                                    <c:if test="${map.sort == 'recedeInventoryDays' && map.sc == 'asc'}">
                                                        <img src="/resources/image/SortDesc.png">
                                                    </c:if>
                                                    <c:if test="${map.sort == 'recedeInventoryDays' && map.sc == 'desc'}">
                                                        <img src="/resources/image/SortAsc.png">
                                                    </c:if>
                                                </a>
                                            </c:when>
                                        </c:choose>
                                    </li>
                                </ul>
                            </div>
                            <div class="SearchButtonWrapper ClearFix SearchButtonWrapperMore">
                                <input class="CustomInput InputMarginLeft" placeholder="车辆标题/车架号" type="text" name="search" value="${map.search}"/>
                                <button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </form>
                </div>

                <table border="1" class="Table">
                    <tr class="THead">
                        <th>车辆信息</th>
                        <th>寄售方</th>
                        <c:if test="${map.status ne 3}">
                            <th>价格信息</th>
                        </c:if>
                        <c:choose>
                            <c:when test="${map.status eq 1}">
                                <th>库存天数</th>
                            </c:when>
                            <c:when test="${map.status eq 2}">
                                <th>售时库存天数</th>
                            </c:when>
                            <c:when test="${map.status eq 3}">
                                <th>退时库存天数</th>
                            </c:when>
                        </c:choose>
                        <c:if test="${map.status eq 2}">
                            <th>实际成交价</th>
                        </c:if>
                        <c:if test="${map.status eq 1 || map.status eq 3 }">
                            <th>当前状态</th>
                        </c:if>
                        <th>操作</th>
                    </tr>
                    <tbody>
                    <c:forEach var="carInfo" items="${map.page.list}">
                        <tr>
                            <td class="CarInfoWrapper">
                                <div class="CarTitle"><a class="CarTitleToDetail" href="/carSource/detail?carInfoId=${carInfo.id}&status=${map.status}">${carInfo.carTitle}</a>
									<span class="CarIdentifyStatus">
									<c:if test="${carInfo.isIdentify == 1}">未鉴定</c:if>
									<c:if test="${carInfo.isIdentify == 0}">鉴定中</c:if>
									<c:if test="${carInfo.isIdentify == 2}">已鉴定</c:if>
									</span>
                                </div>
                                <div class="CarOtherInfo">
                                    <div class="CarOtherInfoItem">
                                        <span>${carInfo.firstLicenseDate}上牌</span><span>${carInfo.runKm/10000}万公里</span><span>VIN:${carInfo.carVin}</span>
                                    </div>
                                    <div class="CarOtherInfoItem">
                                        <span>${carInfo.licenseNum}</span><span>${carInfo.carColor}</span><span>${carInfo.carCityName}</span><span>EN:${carInfo.engineNo}</span>
                                    </div>
                                    <div class="CarOtherInfoItem">
                                        <span>接车：${fn:substring(carInfo.takeCarTime,0,16)}</span>
                                        <span>更新：${fn:substring(carInfo.updatedAt,0,16)}</span>
                                    </div>
                                </div>
                            </td>
                            <td style="width: 80px">${carInfo.carBusinessName}</td>
                            <c:if test="${map.status ne 3}">
                                <c:choose>
                                    <c:when test="${carInfo.salePrice gt 0}">
                                        <td class="CarPriceWrapper">
                                            <div>车主售价：<span class="Price">${carInfo.salePrice/10000}万元</span></div>
                                            <div class="ServicePriceWrapper">服务费：<span class="Price">${carInfo.servicePrice}元</span></div>
                                        </td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>暂未定价</td>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                            <c:choose>
                                <c:when test="${map.status eq 1}">
                                    <td style="width: 80px">${carInfo.inventoryDay}</td>
                                </c:when>
                                <c:when test="${map.status eq 2}">
                                    <td style="width: 80px">${carInfo.saleOutInventoryDays}</td>
                                </c:when>
                                <c:when test="${map.status eq 3}">
                                    <td style="width: 80px">${carInfo.recedeInventoryDays}</td>
                                </c:when>
                            </c:choose>

                            <c:if test="${map.status eq 2}">
                                <td class="CarPriceWrapper">
                                    <div>售价：<span class="Price">${carInfo.realSalePrice/10000}万元</span></div>
                                    <div class="ServicePriceWrapper">服务费：<span class="Price">${carInfo.realServicePrice}元</span></div>
                                    <div class="ServicePriceWrapper">总价：<span class="Price">${(carInfo.realSalePrice+carInfo.realServicePrice)/10000}万元</span></div>
                                </td>
                            </c:if>
                            <c:if test="${map.status eq 1 || map.status eq 3 }">
                                <c:if test="${carInfo.statusDescription == '首次库存预警建议关注'}">
                                    <td class="CarStatusDes CarStatusFirstWarn">${carInfo.statusDescription}</td>
                                </c:if>
                                <c:if test="${carInfo.statusDescription == '状态正常'}">
                                    <td>${carInfo.statusDescription}</td>
                                </c:if>
                                <c:if test="${carInfo.statusDescription == '临近二次库存预警建议适当调整'}">
                                    <td class="CarStatusDes CarStatusSecondWarn">${carInfo.statusDescription}</td>
                                </c:if>
                                <c:if test="${carInfo.statusDescription == '库存高位预警建议立即调整'}">
                                    <td class="CarStatusDes CarStatusLastWarn">${carInfo.statusDescription}</td>
                                </c:if>
                                <c:if test="${carInfo.statusDescription == '已退'}">
                                    <td class="CarStatusDes">${carInfo.statusDescription}</td>
                                </c:if>
                                <c:if test="${carInfo.statusDescription == '已售'}">
                                    <td class="CarStatusDes">${carInfo.statusDescription}</td>
                                </c:if>

                            </c:if>

                            <td class="ActionWrapper">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <c:if test="${CurrentUser.check('/carSource/detail')}">
                                    <a class="ListBtn" href="/carSource/detail?carInfoId=${carInfo.id}&status=${map.status}">详情</a>
                                </c:if>
                                <c:if test="${CurrentUser.check('/carSource/edit') && map.status eq 1}">
                                    <a class="ListBtn" href="/carSource/edit?status=${map.status}&id=${carInfo.id}">编辑</a>
                                    <%--<a class="ListBtn GetCarOperationLog" href="javascript:;" data-url="/carSource/getCarOperationLog?carInfoId=${carInfo.id}" data-cartitle="${carInfo.carTitle}">查看操作纪录</a>--%>
                                </c:if>
                                <c:if test="${CurrentUser.check('/print/printCarQRCode')}">
                                    <a class="ListBtn" target="_blank" href="/print/printCarQRCode?carInfoId=${carInfo.id}">打印二维码</a>
                                    <br />
                                </c:if>

                                    <c:if test="${map.status eq 1 && CurrentUser.check('/carSource/recedeCarSource')}">
                                        <a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn"
                                           data-reloadurl="/carSource/list?${map.params}" data-msg="退车成功"
                                           data-confirm="你确定要退车?" data-pending="退车"
                                           data-url="/carSource/recedeCarSource?carInfoId=${carInfo.id}">退车</a>
                                    </c:if>
                                    <c:if test="${map.status eq 1 && CurrentUser.check('/carSource/updatePrice')}">
                                        <a data-carname="${carInfo.carTitle}" class="ListBtn SetSalePrice" href="javascript:;"
                                           data-carid="${carInfo.id}" data-salprice="${carInfo.salePrice}" data-serviceprice="${carInfo.servicePrice}" >
                                            <c:choose>
                                                <c:when test="${carInfo.salePrice gt 0}">调价</c:when>
                                                <c:otherwise>定价</c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:if>
                                    <c:if test="${map.status ne 1 && CurrentUser.check('/carSource/changeCarStatusToInventory')}">
                                        <a href="javascript:;" class="ListBtn AjaxBtn" data-msg="设置成功" data-pending="设置中..." data-url="/carSource/changeCarStatusToInventory?carInfoId=${carInfo.id}&status=${map.status}">移至库存车源</a>
                                    </c:if>
                                    <c:if test="${carInfo.carStatus le 0 || carInfo.carStatus eq 40 || carInfo.carStatus eq 70 && CurrentUser.check('/carSource/delete')}">
                                        <a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-reloadurl="/carSource/list?${map.params}" data-msg="删除成功" data-confirm="你确定要删除这条数据?" data-pending="删除" data-url="/carSource/delete?carInfoId=${carInfo.id}">删除</a>
                                    </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:set var="page" value="${map.page}"></c:set>
                <c:set var="pageUrl" value="/carSource/list?${map.params}"></c:set>
                <%@include file="../lib/pagination.jsp"%>
            </div>
        </div>
    </c:if>
</div>
<%@include file="../lib/footer.jsp"%>