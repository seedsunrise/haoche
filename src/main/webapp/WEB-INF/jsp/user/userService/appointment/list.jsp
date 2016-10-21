<%@ page import="com.haoche.bos.util.CurrentUser" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="title" value="服务预约列表"></c:set>
<%@include file="../../../lib/header.jsp" %>
<c:set var="navOn" value="车主服务"></c:set>
<%@include file="../../../lib/nav.jsp" %>
<c:set var="sidebarOn" value="服务预约列表"></c:set>

<div class="Main">
	<div id="SideBar">
		<%@include file="../../sideBar.jsp" %>
	</div>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/user/list">车主服务</a> <i class="fa fa-angle-right"></i></li>
				<li><span>服务预约</span> <i class="fa fa-angle-right"></i></li>
				<li><span>服务预约列表</span></li>
			</ul>
			<table border="1" class="Table">
				<div class="SearchBox ClearFix">
					<form action="/userservice/appointment/list" novalidate class="MainSearchForm">
						<input id="sortInput" name="sort" type="hidden" value="${sort}"/>
						<input id="scInput" name="sc" type="hidden" value="${map.sc}"/>
						<div class="Clear"></div>
						<div class="SearchGroup DatePickerStart">
							<div class="DatePickerWrapper">
								<input value="<%= request.getParameter("appointmentDateStart") != null ? request.getParameter("appointmentDateStart") : ""%>"
									   end-date="0d" placeholder="预约开始时间" class="CustomInput DatePicker"
									   name="appointmentDateStart" id="appointmentDateStart"/>
							</div>
						</div>
						<div class="SearchGroup">
							<div class="DatePickerWrapper">
								<input value="<%= request.getParameter("appointmentDateEnd") != null ? request.getParameter("appointmentDateEnd") : ""%>"
									   end-date="0d" data-start="#appointmentDateStart"
									   placeholder="预约结束时间" class="CustomInput DatePicker" name="appointmentDateEnd"/>
							</div>
						</div>
						<div class="SortWrapper" style="margin-left: 20px;width: 100px;">
							<select name="status" id="status" class="CustomSelect"
									value="<%= request.getParameter("status") %>">
								<option value="">所有预约</option>
								<option value="0">待审核</option>
								<option value="1">已审核</option>
								<option value="2">服务中</option>
								<option value="3">已完成</option>
								<option value="4">已取消</option>
							</select>
						</div>
						<div class="OtherSearchInfoBorder"></div>
						<div class="OtherSearchInfo">
							<div class="SortWrapper">
								<ul class="SortList">
									<li>
										<a class="SortItemWrapper" href="javascript:;" sort="appointmentTime">
											<span>预约时间</span>
											<c:if test="${map.sort == 'appointmentTime' && map.sc == 'asc'}">
												<img src="/resources/image/SortAsc.png">
											</c:if>
											<c:if test="${map.sort == 'appointmentTime' && map.sc == 'desc'}">
												<img src="/resources/image/SortDesc.png">
											</c:if>
										</a>
									</li>
								</ul>
							</div>
							<div class="SearchButtonWrapper ClearFix SearchButtonWrapperMore">
								<input class="CustomInput InputMarginLeft" placeholder="客户姓名或电话" type="text" name="search" value="${map.search}"/>
								<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
							</div>
						</div>
					</form>
				</div>
				<tr class="THead">
					<th style="width: 25px">ID</th>
                    <th>预约客户姓名</th>
					<th style="width: 90px">联系电话</th>
					<th>预约项目</th>
					<th style="width: 150px">预约时间</th>
					<th style="width: 120px">状态及付款信息</th>
					<th style="width: 100px;">操作</th>
				</tr>
				<c:forEach items="${map.page.list}" var="item" varStatus="status">
                    <tr>
                        <td>${item.id}</td>
						<td>${item.userName}</td>
						<td>${item.mobile}</td>
                        <td style="text-align: left;width: 400px">
							<c:forEach items="${item.projectDTOList}" var="project" varStatus="status">
								<c:if test="${project.isSelect==1}">
                                ${project.projectTitle};
								</c:if>
							</c:forEach>
						</td>
						<td>
							<fmt:formatDate value="${item.appointmentTime}" pattern="yyyy年MM月dd日 HH:mm" />
						</td>
						<td>
							<c:if test="${item.appointmentStatus == 0}">待审核</c:if>
							<c:if test="${item.appointmentStatus == 1}">已审核</c:if>
							<c:if test="${item.appointmentStatus == 2}">服务中</c:if>
							<c:if test="${item.appointmentStatus == 4}">已取消</c:if>
							<c:if test="${item.appointmentStatus == 3}">
								已完成
								<div>服务费：${item.serviceCharge}元</div>
							</c:if>
						</td>
                        <td>

								<a href="javascript:;" class="ListBtn ReviewAppointment" data-dialog=".DialogAppointmentDetail" data-url="/userservice/appointment/getAppointmentInfo?id=${item.id}&type=2">查看详情</a>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-msg="删除成功"
								   data-confirm="你确定要删除这条数据?" data-pending="删除"
								   data-url="/userservice/appointment/delete?id=${item.id}">删除</a>
						</td>
					</tr>
				</c:forEach>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/userservice/appointment/list?${map.param}"></c:set>
			<%@include file="../../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<div class="OverLay DialogOverAppointment">
	<div class="Dialog alertBox">
		<div class="DialogTitle">
			<h1 class="PayInsuranceTitle">完结预约</h1>
			<div class="DialogClose" data-close=".DialogOverAppointment"><img src="/resources/image/DialogClose.png" alt=""></div>
		</div>
		<div class="DialogContent">
			<form action="/userservice/appointment/finalcheck" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm" data-reloadurl="/userservice/appointment/list" novalidate>
				<div class="AppointmentDataWrapper">
					<div class="Preloading">加载中...</div>
				</div>
				<table class="Table tbStyle remarks" style="padding: 0 26px;margin-top: 20px;">
					<tr>
						<td class="BorderTop"><span class="">备注</span></td>
						<td colspan="2" class="Relative BorderTop">
							<textarea name="remarks" class="fl" cols="30" rows="5" placeholder="请输入备注" style="margin-right: 10px"></textarea>
							<div class="FormLayout FormItemControl FileUploadWrapper">
								<input class="ImageSourceUrl ImageInput" type="text" name="image" value="">
								<div class="PreShowList">
									<input type="hidden" name="imagePreFix" id="ImagePreFix" value="http://image.cnepaycd.quanyibao.com:81">
								</div>
								<div class="UploadBtnWrapper">
									<input class="FileUpload Multiple" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs" multiple="">
									<a class="Btn" href="javascript:;">上传图片</a>
								</div>
							</div>
						</td>
					</tr>
				</table>
				<div class="BtnGroup" style="padding-bottom: 25px;margin-top: 0">
					<button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="OverLay DialogAppointmentDetail">
	<div class="Dialog alertBox">
		<div class="DialogTitle">
			<h1 class="PayInsuranceTitle">查看详情</h1>
			<div class="DialogClose" data-close=".DialogAppointmentDetail"><img src="/resources/image/DialogClose.png" alt=""></div>
		</div>
		<div class="DialogContent">
			<div class="AppointmentDataWrapper">
				<div class="Preloading">加载中...</div>
			</div>
		</div>
	</div>
</div>
<div class="OverLay DialogReviewedAppointment">
	<div class="Dialog">
		<div class="DialogTitle">
			<h1 class="PayInsuranceTitle">审核预约</h1>
			<div class="DialogClose" data-close=".DialogReviewedAppointment"><img src="/resources/image/DialogClose.png" alt=""></div>
		</div>
		<div class="DialogContent">
			<form action="/userservice/appointment/check" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm" data-reloadurl="/userservice/appointment/list" novalidate>
				<div class="AppointmentDataWrapper">
					<div class="Preloading">加载中...</div>
				</div>
				<div class="BtnGroup" style="padding-bottom: 25px;margin-top: 0">
					<%--<a href="javascript:;" class="Btn BtnPrimary SubmitReviewedAppointment">提 交</a>--%>
					<button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@include file="../../../lib/footer.jsp" %>