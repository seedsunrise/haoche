<%@ page import="com.haoche.bos.util.CurrentUser" %>
<%@ page import="com.haoche.remoting.dto.PageNateDTO" %>
<%@ page import="com.haoche.remoting.dto.CarInfoApplyDTO" %>
<%@ page import="org.springframework.util.StringUtils" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车源入库申请"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="车源"></c:set>
<%@include file="../lib/nav.jsp"%>
<c:set var="sidebarOn" value="车源入库申请" ></c:set>


<%--<c:set var="newUrl" value="/carSource/edit"></c:set>--%>
<%--<c:set var="newName" value="录入车源"></c:set>--%>

<div class="Main">
    <c:if test="${CurrentUser.check('/carInfoApply/list')}">
        <div id="SideBar">
            <%@include file="sideBar.jsp"%>
        </div>
        <div class="ContentWrapper">

            <div class="MainContent">
                <ul class="BreadCrumb">
                    <li><a href="#">入库管理</a> <i class="fa fa-angle-right"></i></li>
                    <li>
	                    <span>车源入库申请</span>
                    </li>
                </ul>
                <div class="SearchBox ClearFix">
                    <form action="/carInfoApply/list" novalidate class="MainSearchForm">
                        <div class="SearchGroup">
                            <div class="SearchButtonWrapper ClearFix">
                                <input class="CustomInput" placeholder="车源标题/寄售方" type="text" name="search" value="${map.search}"/>
                                <button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                    </form>
                </div>

                <table border="1" class="Table">
                    <tr class="THead">
                        <th>车源信息</th>
                        <th>寄售方</th>
						<th>照片信息</th>
	                    <th>备注</th>
	                    <th>当前状态</th>
                        <th>操作</th>
                    </tr>
                    <tbody>
                    <c:forEach var="carInfo" items="${map.page.list}">
                        <tr>
                            <td class="CarInfoWrapper">
                                <div class="CarOtherInfo">
	                                <div class="CarTitle">
		                                <span>
			                                <c:choose>
			                                    <c:when test="${carInfo.modelName eq null}">
				                                    ${carInfo.subBrandName}${carInfo.lineName}
			                                    </c:when>
				                                <c:otherwise>
				                                ${carInfo.modelName}
				                                </c:otherwise>
		                                    </c:choose>
		                                </span>
	                                </div>
                                    <div class="CarOtherInfoItem">
                                        <span>${carInfo.firstLicenseDate}上牌</span><span>${carInfo.runKm/10000}万公里</span><span>${carInfo.salePrice/10000}万元</span>
                                    </div>
                                    <div class="CarOtherInfoItem">
										<span>提交时间：${fn:substring(carInfo.createdAt,0,16)}</span>
                                    </div>
                                </div>
                            </td>
                            <td style="width: 80px">${carInfo.carBusinessName}</td>
							<td>
                                <c:if test="${carInfo.carPhoto != null }" >
                                    <div class="CalculateTotalPic" data-source="${carInfo.carPhoto}"><span></span>张照片</div>
                                </c:if>
                                <c:if test="${carInfo.nameplatePhoto != null }" >
                                    <div class="CalculateTotalPic">铭牌照片</div>
                                </c:if>
                                <c:if test="${carInfo.drivingLicensePhoto != null }" >
                                    <div class="CalculateTotalPic" data-source="${carInfo.drivingLicensePhoto}">行驶证照片x<span></span></div>
                                </c:if>
                                <c:if test="${carInfo.propertyCertificatePhoto != null }" >
                                    <div class="CalculateTotalPic" data-source="${carInfo.propertyCertificatePhoto}">产权证照片x<span></span></div>
                                </c:if>
                                <c:if test="${carInfo.ownerIDCardPhoto != null }" >
                                    <div class="CalculateTotalPic" data-source="${carInfo.ownerIDCardPhoto}">车主身份证照片X<span></span></div>
                                </c:if>
							</td>
							<td>${carInfo.comment}</td>
	                        <td>
		                        <c:if test="${carInfo.status eq 0}">
			                        待审核完善
	                            </c:if>
		                        <c:if test="${carInfo.status eq 1}">
			                        审核完善完毕
		                        </c:if>
	                        </td>
                            <td class="ActionWrapper">
	                            <c:if test="${carInfo.status eq 0}">
		                            <a class="ListBtn" href="/carSource/edit?carInfoApplyId=${carInfo.id}">完善并通过申请</a>
	                            </c:if>

                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:set var="page" value="${map.page}"></c:set>
                <c:set var="pageUrl" value="/carInfoApply/list"></c:set>
                <%@include file="../lib/pagination.jsp"%>
            </div>
        </div>
    </c:if>
</div>
<%@include file="../lib/footer.jsp"%>