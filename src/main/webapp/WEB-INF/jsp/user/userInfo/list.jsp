<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="title" value="车主管理"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="车主服务"></c:set>
<%@include file="../../lib/nav.jsp" %>
<c:set var="sidebarOn" value="车主概览"></c:set>

<c:set var="newUrl" value="/user/userInfo/editPage"></c:set>
<c:set var="newName" value="录入车主"></c:set>
<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/user/list">车主服务</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车主管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>车主概览</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/user/userInfo/list" class="MainSearchForm" novalidate>
					<input id="sortInput" name="sort" type="hidden" value="${map.sort}"/>
					<input id="scInput" name="direction" type="hidden" value="${map.direction}"/>
					<div class="SearchGroup">
						<div class="DatePickerWrapper DatePickerStart">
							<input value="${map.takeCarTimeStart}"
								   placeholder="提车日期开始" class="CustomInput DatePicker" data-date-end-date="0d"
								   name="takeCarTimeStart" id="takeCarTimeStart"/>
						</div>
					</div>
					<div class="SearchGroup">
						<div class="DatePickerWrapper">
							<input value="${map.takeCarTimeEnd}"
								   data-start="#FirstLicenseDateStart" data-date-end-date="0d"
								   placeholder="提车日期结束" class="CustomInput DatePicker" name="takeCarTimeEnd" id="takeCarTimeEnd"/>
						</div>
					</div>

					<div class="OtherSearchInfo">
						<div class="SortWrapper">
							<ul class="SortList">
								<li>
									<a class="SortItemWrapper" href="javascript:;" sort="takeCarTime">
										<span>提车日期</span>
										<c:if test="${map.sort == 'takeCarTime' && map.direction == 'asc'}">
											<img src="/resources/image/SortAsc.png">
										</c:if>
										<c:if test="${map.sort == 'takeCarTime' && map.direction == 'desc'}">
											<img src="/resources/image/SortDesc.png">
										</c:if>
									</a>
								</li>
							</ul>
						</div>
						<div class="SearchButtonWrapper ClearFix SearchButtonWrapperMore">
							<input class="CustomInput InputMarginLeft" placeholder="客户姓名/手机号" type="text" name="searchNameOrMobile" value="${map.searchNameOrMobile}"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>

			<table border="1" class="Table">
				<tr class="THead">
					<th style="width: 45px">客户ID</th>
					<th>客户基本信息</th>
					<th>车辆基本信息</th>
					<th>成交信息</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:forEach items="${map.page.list}" var="user" varStatus="status">
					<tr>
						<td>${user.id}</td>
						<td class="CarInfoWrapper GoodsInfoWrapper ClearFix" style="width: 360px">
							<a href="${map.imageUrl}${user.drivingLicensePhoto}" class="FixImage CarImage FancyBoxImg"
							   data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${user.drivingLicensePhoto}"></a>
							<div class="CarInfo" <c:if test="${!(user.drivingLicensePhoto eq null) && user.drivingLicensePhoto != ''}">style="margin-left: 130px"</c:if>>
								<div class="CarOtherInfo">
									<div class="CarTitle">
                                        <span>姓名：${user.realName} 电话：${user.mobile}</span>
									</div>
									<div class="CarOtherInfoItem">
                                        <span>身份证：${user.identityCardNum}</span>
									</div>
									<div class="CarOtherInfoItem">
                                        <span>住址:${user.address}</span>
									</div>
								</div>
                        	</div>
						</td>
						<td class="CarInfoWrapper GoodsInfoWrapper ClearFix" style="width: 360px">
							<a href="${map.imageUrl}${user.carMainPhoto}" class="FixImage CarImage FancyBoxImg"
							   data-param="_r_300_X_q_100" data-pre="${map.imageUrl}" data-source="${user.carMainPhoto}"></a>
							<div class="CarInfo " <c:if test="${user.carMainPhoto != ''}">style="margin-left: 130px"</c:if>>
								<div class="CarTitle">${user.carModelName}</div>
								<div class="CarOtherInfo">
									<div class="CarOtherInfoItem">
										<span>VIN：${user.carVin} ${user.licenseNum}</span>
									</div>
									<div class="CarOtherInfoItem">
										<span><fmt:formatDate value="${user.firstLicenseDate}" pattern="yyyy年MM月"/>首次上牌</span>
										<span><fmt:formatNumber type="number" value="${user.runKm/10000}" pattern="0.0" maxFractionDigits="1"/>万公里 ${user.carColor}</span>
									</div>
									<div class="CarOtherInfoItem">
                                        <span>提车日期：<fmt:formatDate value="${user.takeCarTime}" pattern="yyyy年MM月dd日"/></span>
									</div>
								</div>
							</div>
						</td>
						<td class="CarPriceWrapper" style="width: 145px">
							<div>实际成交价：<span class="Price">${user.salePriceReal}元</span></div>
                            <div>乾坤服务费：<span class="Price">${user.servicePrice}元</span></div>
                            <div>加装及其他：<span class="Price">${user.otherFees}元</span></div>
                            <div>车险：<span class="Price">${user.insurace}元</span></div>
						</td>
						<td class="TDAction" style="width: 110px">
							<a href="/user/userInfo/editPage?id=${user.id}" class="ListBtn">编辑</a>
							<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-reloadurl="/user/userInfo/list" data-msg="删除成功" data-confirm="你确定要删除这条数据?" data-pending="删除" data-url="/user/userInfo/delete?userInfoId=${user.id}">删除</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/user/userInfo/list?${map.param}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
