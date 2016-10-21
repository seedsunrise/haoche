<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<div class="SideBarInner SideMenu NoFixed">
	<c:if test="${CurrentUser.check(newUrl)}">
		<a class="SideBarBtn" href="${newUrl}">${newName}</a>
	</c:if>
</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">城市/门店管理</div>
	<c:if test="${CurrentUser.check('/system/city/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('城市设置')}">SideBarOn</c:if>" href="/system/city/list">城市设置</a>
	</c:if>
	<c:if test="${CurrentUser.check('/system/shop/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('门店设置')}">SideBarOn</c:if>" href="/system/shop/list">门店设置</a>
	</c:if>

</div>
<div class="SideBarInner SideMenu">
	<div class="SideSubTitle">车辆基础数据管理</div>
	<c:if test="${CurrentUser.check('/system/carbrand/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('品牌')}">SideBarOn</c:if>"
		   href="/system/carbrand/list">品牌</a>
	</c:if>
	<c:if test="${CurrentUser.check('/system/carsubbrand/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('生产厂商')}">SideBarOn</c:if>"
		   href="/system/carsubbrand/list">生产厂商</a>
	</c:if>
	<c:if test="${CurrentUser.check('/system/carline/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('车系')}">SideBarOn</c:if>"
		   href="/system/carline/list">车系</a>
	</c:if>
	<c:if test="${CurrentUser.check('/system/carmodel/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('车型配置')}">SideBarOn</c:if>"
		   href="/system/carmodel/list">车型配置</a>
	</c:if>
</div>
<%--<div class="SideBarInner SideMenu">--%>
<%--<div class="SideSubTitle">车型配置管理</div>--%>
<%--<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('亮点配置')}">SideBarOn</c:if>">亮点配置</a>--%>
<%--</div>--%>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle ">帮助中心</div>
	<c:if test="${CurrentUser.check('/help/helpMenu/editPage?level=1')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('一级标题')}">SideBarOn</c:if>"
		   href="/help/helpMenu/list?level=1">一级标题</a>
	</c:if>
	<c:if test="${CurrentUser.check('/help/helpMenu/editPage?level=2')}">
	<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('二级标题')}">SideBarOn</c:if>"
	   href="/help/helpMenu/list?level=2">二级标题</a>
	</c:if>
	<c:if test="${CurrentUser.check('/help/helpDocument/editPage')}">
	<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('帮助文档')}">SideBarOn</c:if>"
	   href="/help/helpDocument/list">帮助文档</a>
	</c:if>
</div>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle ">车险设置</div>
	<c:if test="${CurrentUser.check('/insurance/company/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('保险公司')}">SideBarOn</c:if>"
		   href="/insurance/company/list">保险公司</a>
	</c:if>
	<c:if test="${CurrentUser.check('/insurance/quoter/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('报价员')}">SideBarOn</c:if>"
		   href="/insurance/quoter/list">报价员</a>
	</c:if>
</div>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle ">保养、美容、精品加装设置</div>
	<c:if test="${CurrentUser.check('/extraItem/edit')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('项目列表')}">SideBarOn</c:if>"
		   href="/extraItem/list">项目列表</a>
	</c:if>
</div>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle ">问题反馈</div>
	<c:if test="${CurrentUser.check('/system/feedBack/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('详情列表')}">SideBarOn</c:if>"
		   href="/system/feedBack/list">详情列表</a>
	</c:if>
</div>

<div class="SideBarInner SideMenu">
	<div class="SideSubTitle ">广告</div>
	<c:if test="${CurrentUser.check('/system/banner/list')}">
		<a class="SideBarMainTitle <c:if test="${sidebarOn.equals('广告列表')}">SideBarOn</c:if>"
		   href="/system/banner/list">广告列表</a>
	</c:if>
</div>