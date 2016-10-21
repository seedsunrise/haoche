<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="title" value="消息反馈"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="sidebarOn" value="详情列表"></c:set>

<div class="Main">
	<div id="SideBar">
		<%@include file="../sideBar.jsp" %>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
			<ul class="BreadCrumb">
				<li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
				<li><span>问题反馈</span> <i class="fa fa-angle-right"></i></li>
				<li><span>详情列表</span></li>
			</ul>

			<table border="1" class="Table">
				<tr class="THead">
					<th>反馈ID</th>
					<th>反馈内容</th>
					<th>反馈图片</th>
					<th>联系方式</th>
					<th>设备信息</th>
					<th>提交时间</th>
					<th>是否已发送邮件</th>
				</tr>
				<tbody>
				<c:forEach items="${page.list}" var="feedBack">
					<tr>
						<td>${feedBack.id}</td>
						<td>${feedBack.content}</td>
						<td>
							<c:forTokens items="${feedBack.feedBackImg}" delims="," var="imgSrc">
								<a href="${imgSrc}" class="FixImage CarImage FancyBoxImg">
									<img src="${imgSrc}" style="height: 80px;width: 120px;"/>
								</a>
							</c:forTokens>

						</td>
						<td>${feedBack.contact}</td>
						<td>${feedBack.project}|${feedBack.version}|${feedBack.device}|${feedBack.deviceOS}</td>
						<td><fmt:formatDate value="${feedBack.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<c:if test="${feedBack.isSent eq 0}">未发送</c:if>
							<c:if test="${feedBack.isSent eq 1}">已发送</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<c:set var="page" value="${page}"></c:set>
			<c:set var="pageUrl" value="/system/feedBack/list"></c:set>
			<%@include file="../../lib/pagination.jsp" %>

		</div>
	</div>
</div>
<%@include file="../../lib/footer.jsp" %>
