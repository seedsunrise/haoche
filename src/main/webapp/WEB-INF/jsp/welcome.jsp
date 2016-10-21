<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="首页"></c:set>
<%@include file="./lib/header.jsp"%>
<%@include file="./lib/nav.jsp"%>
<div class="Main">
	<div id="SideBar">
        <%@include file="./index/sideBar.jsp" %>
	</div>

	<div class="ContentWrapper">
		<div class="MainContent">
			<div class="HomeStatisticWrapper">
				<h2><span class="StaticMainTitle">库存统计</span> <span class="StatisticDate">（更新时间：${map.currentDate}）</span></h2>
				<ul class="ClearFix">
					<li>
						<div class="StaticNum">${map.inventoryStatistics.total} <span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">当前库存</div>
					</li>
					<li>
						<div class="StaticNum">${map.inventoryStatistics.avgInventoryDay}<span class="StaticUnit">/天</span></div>
						<div class="StaticTitle">在库车辆平均库存</div>
					</li>
					<li>
						<div class="StaticNum">${map.inventoryStatistics.identifying}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">鉴定中车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.inventoryStatistics.productCarCount}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">待售车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.inventoryStatistics.lockedCarCount}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">交付中</div>
					</li>
					<li>
						<div class="StaticNum">${map.inventoryStatistics.firstWarningForCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">15天首次预警</div>
					</li>
					<li>
						<div class="StaticNum">${map.inventoryStatistics.secondeWarningForCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">30天二次预警</div>
					</li>
					<li>
						<div class="StaticNum">${map.inventoryStatistics.thirdWarningForCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">50天以上高危预警</div>
					</li>
				</ul>
			</div>

			<div class="HomeStatisticWrapper">
				<h2 class="ClearFix">
					<span class="StaticMainTitle">时间段统计:</span>
					<div class="HomeDateWrapper">
						<a href="/index/statistical?days=7" class="StaticByDays <c:if test="${map.days == 7}">OnStaticByDays</c:if>">七天内</a>
						<a href="/index/statistical?days=30" class="StaticByDays <c:if test="${map.days == 30}">OnStaticByDays</c:if>">一个月内</a>
						<a href="/index/statistical?days=90" class="StaticByDays <c:if test="${map.days == 90}">OnStaticByDays</c:if>">三个月内</a>

						<form action="/index/statistical" class="HomeStaticForm">
							<input type="hidden" name="days" value="${map.days}">
							<div class="DatePickerWrapper DatePickerStart">
								<input value="${map.start}" data-date-end-date="0d"
									   placeholder="开始时间" class="CustomInput DatePicker" name="start" id="Start"/>
							</div>
							<div class="DatePickerWrapper DatePickerEnd">
								<input value="${map.end}" data-date-end-date="0d"  data-start="#Start"
									   placeholder="结束时间" class="CustomInput DatePicker" name="end"/>
							</div>
						</form>
					</div>
				</h2>
				<ul class="ClearFix">
					<li>
						<div class="StaticNum">${map.timeStatistics.newCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">入库车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.timeStatistics.identified}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">鉴定完毕车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.timeStatistics.identifyFailed}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">鉴定退回车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.timeStatistics.recedeCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">已退车车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.timeStatistics.sellingCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">新增待售车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.timeStatistics.lockedCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">新增交付中车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.timeStatistics.soldCar}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">交付完毕车辆</div>
					</li>
					<li>
						<div class="StaticNum">${map.timeStatistics.newBusiness}<span class="StaticUnit">/辆</span></div>
						<div class="StaticTitle">新增车商</div>
					</li>
				</ul>
			<div>
		</div>
	</div>
</div>
<%@include file="./lib/footer.jsp"%>
