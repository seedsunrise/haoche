<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="二手车线上在售分析"></c:set>
<c:set var="navOn" value="首页"></c:set>

<%@include file="../../lib/header.jsp"%>
<%@include file="../../lib/nav.jsp"%>

<c:set var="sidebarOn" value="帮助中心" ></c:set>
<input type="hidden" value="${map.onlineSaleStaticUrl}" id="OnlineSaleStaticUrl">
<div class="Main" id="HomeOnlineSaleStatic">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/index">首页</a> <i class="fa fa-angle-right"></i></li>
				<li><a href="javascript:;">工具箱</a> <i class="fa fa-angle-right"></i></li>
				<li><a href="/index/help/documentList?firstLevelMenuId=0">二手车线上销售分析</a></li>
            </ul>
            <div class="ChartSearchWrapper ClearFix">
                <label>请输入车型关键字：</label>
                <div class="SearchButtonWrapper ClearFix">
                    <input class="CustomInput ChartQuery" placeholder='如"520li 领先型"' type="text" value="520li 领先型">
                    <button type="submit" class="Btn BtnPrimary BtnSmall"><i class="fa fa-search"></i></button>
                </div>
                <label class="HomeTimeLabel">时间范围：</label>
                <div class="DatePickerWrapper">
                    <input data-date-end-date="0d"
                           placeholder="" class="CustomInput DatePicker ChartDate"/>
                    <span class="Postscript">(前7天内)</span>
                </div>
            </div>
            <div class="ChartWrapper">
                <h2>总量及均价</h2>
                <div id="TotalChart" class="Chart">
                </div>
            </div>
            <div class="ChartWrapper">
                <h2>按年款分布</h2>
                <div id="ChartByYearType" class="Chart">
                </div>
            </div>
            <div class="ChartWrapper">
                <h2>按上牌年份分布</h2>
                <div id="ChartByRegistrationDate" class="Chart">
                </div>
            </div>
            <div class="ChartWrapper">
                <h2>按所在城市分布</h2>
                <div id="ChartByCity" class="Chart">
                </div>
            </div>
		</div>
	</div>
</div>
<%@include file="../../lib/footerCommon.jsp" %>
<script src='<c:url value="/resources/javascript/lib/echarts.common.min.js" />'></script>
<script src='<c:url value="/resources/javascript/lib/shine.js" />'></script>
<script src='<c:url value="/resources/javascript/app/onlineSaleStatic.js" />'></script>
</body>
</html>
