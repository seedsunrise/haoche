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
    <c:if test="${CurrentUser.check('/carSource/detail')}">
        <div id="SideBar">
            <%@include file="sideBar.jsp"%>
        </div>
        <div class="ContentWrapper">
            <div class="MainContent">
                <ul class="BreadCrumb">
                    <li><a href="#">车源</a> <i class="fa fa-angle-right"></i></li>
                    <li>
                        <c:choose>
                            <c:when test="${map.status eq 1}"><span>库存车源</span><i class="fa fa-angle-right"></i></c:when>
                            <c:when test="${map.status eq 2}"><span>已售出车源</span><i class="fa fa-angle-right"></i></c:when>
                            <c:when test="${map.status eq 3}"><span>已退车源</span><i class="fa fa-angle-right"></i></c:when>
                        </c:choose>
                    </li>
                    <li><span>车源详情</span></li>
                </ul>

                <!--详情-->
                <c:set var="carInfo" value="${map.carInfo}"></c:set>
                <c:set var="carDocument" value="${map.carDocument}"></c:set>
                <c:set var="carTools" value="${map.carTools}"></c:set>

                <div class="DetailWrapper">
                    <input type="hidden" id="ImagePreFix" value="${map.imageUrl}">
                    <div class="ShowGroupWrapper">
                        <div class="ShowTitle">车源基本信息</div>
                        <ul class="ClearFix ShowGroup">
                            <li>
                                <label>车辆VIN码：</label>
                                <span>${carInfo.carVin}</span>
                            </li>
                            <li>
                                <label>车辆品牌：</label>
                                <span>${carInfo.brandName}</span>
                            </li>
                            <li>
                                <label>生产厂商：</label>
                                <span>${carInfo.subBrandName}</span>
                            </li>
                            <c:if test="${carInfo.nameplatePhoto != null}">
                                <li class="ImageShowListWrapper ClearFix">
                                    <label>图片：</label>
                                    <div class="ImageShowList" data-source="${carInfo.nameplatePhoto}"></div>
                                </li>
                            </c:if>
                            <li>
                                <label>车辆车系：</label>
                                <span>${carInfo.lineName}</span>
                            </li>
                            <li>
                                <label>车辆型号：</label>
                                <span>${carInfo.modelName}</span>
                            </li>
                            <li>
                                <label>首次上牌时间：</label>
                                <span class="FormatDateShort">${carInfo.firstLicenseDate}</span>
                            </li>
                            <li>
                                <label>首次上牌城市：</label>
                                <span>${carInfo.firstLicenseCityName}</span>
                            </li>
                            <li>
                                <label>最近一次上牌时间：</label>
                                <span  class="FormatDateShort">${carInfo.lastLicenseDate}</span>
                            </li>
                            <li>
                                <label>车牌当前所在城市：</label>
                                <span  class="FormatDateShort">${carInfo.carCityName}</span>
                            </li>
                            <li>
                                <label>车辆当前所在城市：</label>
                                <span>${carInfo.carCityName}</span>
                            </li>
                            <li>
                                <label>车身颜色：</label>
                                <span>${carInfo.carColor}</span>
                            </li>
                            <li>
                                <label>内饰颜色：</label>
                                <span>${carInfo.carInteriorColor}</span>
                            </li>
                            <li>
                                <label>当前车牌号：</label>
                                <span>${carInfo.licenseNum}</span>
                            </li>
                            <li>
                                <label>里程：</label>
                                <span><span class="RunKmFormat">${carInfo.runKm}</span>万公里</span>
                            </li>
                            <li>
                                <label>排量：</label>
                                <span>${carInfo.displacement}</span>
                            </li>
                            <li>
                                <label>发动机号：</label>
                                <span>${carInfo.engineNo}</span>
                            </li>
                            <c:if test="${carDocument.maintenanceInvoicePhoto != null}">
                                <li class="ImageShowListWrapper ClearFix">
                                    <label>4S店保养记录：</label>
                                    <div class="ImageShowList" data-source="${carDocument.maintenanceInvoicePhoto}"></div>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                    <div class="ShowGroupWrapper">
                        <div class="ShowTitle">车辆档案</div>
                        <ul class="ClearFix ShowGroup">
                            <li>
                                <label>产权证：</label>
                                <span>${carDocument.propertyCertificate eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>三包：</label>
                                <span>${carDocument.isInGuarantee eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>违章：</label>
                                <span>${carDocument.isIllegal eq 1 ? '有' : '无'}</span>
                            </li>
                            <c:if test="${carDocument.propertyCertificatePhoto != null}">
                                <li class="ImageShowListWrapper ClearFix">
                                    <label>产权证：</label>
                                    <div class="ImageShowList" data-source="${carDocument.propertyCertificatePhoto}"></div>
                                </li>
                            </c:if>
                            <li>
                                <label>用户手册：</label>
                                <span>${carDocument.isUserManual eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>行驶证：</label>
                                <span>${carDocument.isDrivingLicense eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>购置证：</label>
                                <span>${carDocument.isPurchaseCertificate eq 1 ? '有' : '无'}</span>
                            </li>

                            <c:if test="${carDocument.drivingLicensePhoto != null}">
                                <li class="ImageShowListWrapper ClearFix">
                                    <label>行驶证：</label>
                                    <div class="ImageShowList" data-source="${carDocument.drivingLicensePhoto}"></div>
                                </li>
                            </c:if>
                            <li>
                                <label>保养手册：</label>
                                <span>${carDocument.isMaintenanceManual eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>保单：</label>
                                <span>${carDocument.isPolicy eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>是否能正常过户：</label>
                                <span>${carDocument.isNormalTransfer eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>车主身份证复印件：</label>
                                <span>${carDocument.isCopyOfID eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>二手车发票：</label>
                                <span>${carDocument.isCarInvoice eq 1 ? '有' : '无'}</span>
                            </li>
                            <li>
                                <label>交强险到期时间：</label>
                                <span class="FormatDate">${carDocument.timeOfMaturity}</span>
                            </li>
                            <li>
                                <label>年检到期时间：</label>
                                <span class="FormatDate">${carDocument.annualInspection}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="ShowGroupWrapper">
                        <div class="ShowTitle">随车工具</div>
                        <ul class="ClearFix ShowGroup">
                            <li>
                                <label>烟灰缸：</label>
                                <span>${carTools.numberOfAshtray}个</span>
                            </li>
                            <li>
                                <label>点烟器：</label>
                                <span>${carTools.numberOfCigaretteLighter}个</span>
                            </li>
                            <li>
                                <label>急救包：</label>
                                <span>${carTools.numberOfAidKit}个</span>
                            </li>
                            <li>
                                <label>拖车钩：</label>
                                <span>${carTools.numberOfTrailerHook}套</span>
                            </li>
                            <li>
                                <label>备用车胎：</label>
                                <span>${carTools.numberOfSpareTire}个</span>
                            </li>
                            <li>
                                <label>千斤顶：</label>
                                <span>${carTools.numberOfJack}个</span>
                            </li>
                            <li>
                                <label>网兜：</label>
                                <span>${carTools.numberOfNet}个</span>
                            </li>
                            <li>
                                <label>三角警示牌：</label>
                                <span>${carTools.numberOfWarningTriangle}个</span>
                            </li>
                            <li>
                                <label>备注：</label>
                                <span>${carTools.remarks}</span>
                            </li>
                            <li>
                                <label>商品损坏部分描述：</label>
                                <span>${carTools.damageDescription}</span>
                            </li>
                        </ul>
                    </div>
                    <div class="ShowGroupWrapper">
                        <div class="ShowTitle">价格信息</div>
                        <ul class="ClearFix ShowGroup">
                            <li>
                                <label>车主售价：</label>
                                <span>${carInfo.salePrice/10000}万元</span>
                            </li>
                            <li>
                                <label>品质保障服务费：</label>
                                <span>${carInfo.servicePrice}元</span>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="CarActionWrapper" style="margin-top: 20px;text-align: center">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <c:if test="${map.status eq 1}">
                        <a href="javascript:;" class="Btn BtnPrimary AjaxBtnConfirm AjaxBtn" data-reloadurl="/carSource/list?status=3" data-msg="退车成功" data-confirm="你确定要退车?" data-pending="退车" data-url="/carSource/recedeCarSource?carInfoId=${carInfo.id}">退车</a>
                    </c:if>
                    <c:if test="${map.status eq 1}">
                        <a data-carname="${carInfo.carTitle}" class="Btn SetSalePrice" href="javascript:;"
                           data-carid="${carInfo.id}" data-salprice="${carInfo.salePrice}" data-serviceprice="${carInfo.servicePrice}" >
                            <c:choose>
                                <c:when test="${carInfo.salePrice gt 0}">调价</c:when>
                                <c:otherwise>定价</c:otherwise>
                            </c:choose>
                        </a>
                    </c:if>
                    <c:if test="${map.status ne 1}">
                        <a href="javascript:;" class="Btn AjaxBtn" data-msg="设置成功" data-pending="设置中..." data-url="/carSource/changeCarStatusToInventory?carInfoId=${carInfo.id}&status=${map.status}">移至库存车源</a>
                    </c:if>
                    <c:if test="${carInfo.carStatus le 0 || carInfo.carStatus eq 40 || carInfo.carStatus eq 70}">
                        <a href="javascript:;" class="Btn BtnDanger AjaxBtnConfirm AjaxBtn" data-reloadurl="/carSource/list?status=1}" data-msg="删除成功" data-confirm="你确定要删除这条数据?" data-pending="删除" data-url="/carSource/delete?carInfoId=${carInfo.id}">删除</a>
                    </c:if>
                </div>
            </div>
        </div>
    </c:if>
</div>
<%@include file="../lib/footer.jsp"%>
