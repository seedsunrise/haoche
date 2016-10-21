<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车型油耗设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="车主服务"></c:set>
<%@include file="../../lib/nav.jsp" %>
<c:set var="sidebarOn" value="未设置"></c:set>
<div class="Main">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/user/list">车主服务</a> <i class="fa fa-angle-right"></i></li>
				<li><span>车型油耗管理</span> <i class="fa fa-angle-right"></i></li>
				<li><span>未已设置</span></li>
			</ul>


			<table border="1" class="Table">
				<tr class="THead">
					<th>序号</th>
					<th>品牌</th>
					<th>子品牌</th>
					<th>车系</th>
					<th>车型名称</th>
					<%--<th>百公里油耗</th>--%>
					<th>操作</th>
				</tr>
				<tbody>
				<c:set var="num" value="${page.pageNo*page.pageSize}"></c:set>
				<c:forEach items="${page.list}" var="model" varStatus="status">
					<tr>
						<td>${num+status.index+1}</td>
						<td>${model.brandName}</td>
						<td>${model.subBrandName}</td>
						<td>${model.lineName}</td>
						<td>${model.modelName}</td>
						<%--<td>${mfc.fcphk}</td>--%>
						<td class="TDAction">
							<a class="ListBtn SetFC" href="javascript:;"
							   data-brandid="${model.brandId}" data-brandname="${model.brandName}" data-modelid="${model.modelId}" data-modelname="${model.modelName}"
							   data-subbrandid="${model.subBrandId}" data-subbrandname="${model.subBrandName}" data-lineid="${model.lineId}" data-linename="${model.lineName}">
								设置
							</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${page}"></c:set>
			<c:set var="pageUrl" value="/user/notSetList"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
<script type="text/javascript">
	$(".SetFC").on("click", function(){
		var modelId = $(this).data("modelid");
		vex.dialog.open({
			className: 'vex vex-theme-default SetSalePriceDialog',
			message: $(this).text(),
			input:
			'<div class="DialogFormWrapper + DialogForm-' + modelId + '" >' +
			'<h2>' + $(this).data("modelname") + '</h2>' +
			'<form action="/user/edit" method="post">'+
			'<input type="hidden" value="' + $(this).data("brandid") + '" name="brandId" />' +
			'<input type="hidden" value="' + $(this).data("brandname") + '" name="brandName" />' +
			'<input type="hidden" value="' + $(this).data("subbrandid") + '" name="subBrandId" />' +
			'<input type="hidden" value="' + $(this).data("subbrandname") + '" name="subBrandName" />' +
			'<input type="hidden" value="' + $(this).data("lineid") + '" name="lineId" />' +
			'<input type="hidden" value="' + $(this).data("linename") + '" name="lineName" />' +
			'<input type="hidden" value="' + $(this).data("modelname") + '" name="modelName" />' +
			'<input type="hidden" value="' + $(this).data("modelid") + '" name="modelId" />' +
			'<div class="FormItem ClearFix">' +
			'<label class="FormLayout" for="fcphk">百公里油耗：</label>' +
			'<div class="FormLayout FormItemControl">' +
			'<input placeholder="请输入油耗量" class="FormInput" type="text" id="fcphk" name="fcphk" value="">' +
			'<span class="UnitYuan">L/100km</span>' +
			'</div>' +
			'</div>' +

			'</form>' +
			'</div>',
			callback: function(data) {
				if (data) {
					var $form = $(".DialogForm-" + modelId).find("form");
					$.ajax({
						url: $form.attr('action'),
						type: "post",
						dataType: "json",
						data: $form.serialize(),
						beforeSend: function(xhr){
							xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
						},
						success: function() {
							vex.dialog.alert("保存成功!");
							setTimeout(function(){
								location.reload();
							}, 1500)
						},
						error: function(e) {
							vex.dialog.alert(e.responseJSON.message);
						}
					});
				}
			}
		});
	});

</script>