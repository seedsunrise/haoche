<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="品质整备"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="品质整备"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="品质整备管理" ></c:set>

<div class="Main">
    <c:if test="${CurrentUser.check('/identifyManagement/list')}">
        <div id="SideBar">
            <%@include file="sideBar.jsp"%>
        </div>
        <div class="ContentWrapper">

            <div class="MainContent">
                <ul class="BreadCrumb">
                    <li><a href="#">品质整备</a> <i class="fa fa-angle-right"></i></li>
                    <li><span>鉴定整备管理</span></li>
                </ul>
                <div class="SearchBox ClearFix">
                    <form action="/identifyManagement/list" novalidate class="MainSearchForm">
                        <div class="SearchGroup">
                            <select name="identifyType" id="identifyType" class="CustomSelect" value="<%= request.getParameter("identifyType") %>">
                                <option value="1">在线鉴定</option>
                                <option value="9">离线鉴定</option>
                            </select>
                        </div>
                    </form>
                </div>

                <table border="1" class="Table">
                    <tr class="THead">
                        <th>车源信息</th>
                        <th>车辆状态</th>
                        <th>地区</th>
                        <th>鉴定师</th>
                        <th>操作</th>
                    </tr>
                    <tbody>
                    <c:forEach var="carInfo" items="${map.page.list}">
                        <tr>
                            <td class="CarInfoWrapper">
                                <div class="CarTitle">${carInfo.carTitle}</div>
                                <div class="CarOtherInfo">
                                    <div class="CarOtherInfoItem">
                                        <span>${carInfo.licenseNum}</span><span>${carInfo.carColor}</span><span>VIN:${carInfo.carVin}</span>
                                    </div>
                                    <div class="CarOtherInfoItem">
                                        <span>鉴定时间：${fn:substring(carInfo.identifyTime,0,16)}</span>
                                        <span>整备时间：${fn:substring(carInfo.kerbTime,0,16)}</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <c:if test="${carInfo.isIdentify == 1}">未鉴定</c:if>
                                <c:if test="${carInfo.isIdentify == 0}">鉴定中</c:if>
                                <c:if test="${carInfo.isIdentify == 2}">已鉴定</c:if>
                            </td>
                            <td>${carInfo.carCityName}</td>
                            <td>${carInfo.identifyUserName}</td>
                            <td class="ActionWrapper">
                                <a class="ListBtn" href="/identifyManagement/detail?carInfoId=${carInfo.id}&identifyType=${map.identifyType}&carVin=${carInfo.carVin}">鉴定详情</a>
                                <c:if test="${map.identifyType ==1}">
                                    <a class="ListBtn" target="_blank" href="/print/printCarIdentifyDetail?carInfoId=${carInfo.id}">打印鉴定报告</a>
                                </c:if>

                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:set var="page" value="${map.page}"></c:set>
                <c:set var="pageUrl" value="/identifyManagement/list?identifyType=${map.identifyType}"></c:set>
                <%@include file="../lib/pagination.jsp"%>
            </div>
        </div>
    </c:if>
</div>
<%@include file="../lib/footer.jsp"%>