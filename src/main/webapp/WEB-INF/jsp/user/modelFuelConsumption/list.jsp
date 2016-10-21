<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车型油耗设置"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="车主服务"></c:set>
<%@include file="../../lib/nav.jsp" %>
<c:set var="sidebarOn" value="已设置"></c:set>
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
				<li><span>已设置</span></li>
			</ul>
			<div class="SearchBox ClearFix">
				<form action="/user/list" novalidate>
					<div class="SearchGroup">
						<div class="SearchButtonWrapper ClearFix">
							<input class="CustomInput" type="text" name="modelName" value="${map.modelName}" placeholder="车型名称"/>
							<button type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
						</div>
					</div>
				</form>
			</div>

			<table border="1" class="Table">
				<tr class="THead">
					<th>序号</th>
					<th>品牌</th>
					<th>子品牌</th>
					<th>车系</th>
					<th>车型名称</th>
					<th>百公里油耗</th>
					<th>操作</th>
				</tr>
				<tbody>
				<c:set var="num" value="${page.pageNo*page.pageSize}"></c:set>
				<c:forEach items="${map.page.list}" var="mfc" varStatus="status">
					<tr>
						<td>${num+status.index+1}</td>
						<td>${mfc.brandName}</td>
						<td>${mfc.subBrandName}</td>
						<td>${mfc.lineName}</td>
						<td>${mfc.modelName}</td>
						<td>${mfc.fcphk} L/100km</td>
						<td class="TDAction">
							<%--<a href="javascript:;" class="ListBtn">编辑</a>--%>
								<a class="ListBtn SetFC" href="javascript:;"
								   data-id="${mfc.id}" data-brandid="${mfc.brandId}" data-brandname="${mfc.brandName}" data-modelid="${mfc.modelId}" data-modelname="${mfc.modelName}" data-fcphk="${mfc.fcphk}"
								   data-subbrandid="${mfc.subBrandId}" data-subbrandname="${mfc.subBrandName}" data-lineid="${mfc.lineId}" data-linename="${mfc.lineName}">
									编辑
								</a>
								<a href="javascript:;" class="ListBtn AjaxBtnConfirm AjaxBtn" data-reloadurl="/user/list" data-msg="删除成功" data-confirm="你确定要删除这条数据?" data-pending="删除" data-url="/user/delete?id=${mfc.id}">删除</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/user/list?modelName=${map.modelName}"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
<script type="text/javascript">
	$(".SetFC").on("click", function(){
		var id = $(this).data("id");
		vex.dialog.open({
			className: 'vex vex-theme-default SetSalePriceDialog',
			message: $(this).text(),
			input:
			'<div class="DialogFormWrapper + DialogForm-' + id + '" >' +
			'<h2>' + $(this).data("modelname") + '</h2>' +
			'<form action="/user/edit" method="post">'+
			'<input type="hidden" value="' + id + '" name="id" />' +
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
			'<input placeholder="请输入油耗量" class="FormInput" type="text" id="fcphk" name="fcphk" value="'+ $(this).data("fcphk") + '">' +
			'<span class="UnitYuan">L/100km</span>' +
			'</div>' +
			'</div>' +

			'</form>' +
			'</div>',
			callback: function(data) {
				if (data) {
					var $form = $(".DialogForm-" + id).find("form");
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