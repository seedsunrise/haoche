<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="在职员工"></c:set>
<%@include file="../lib/header.jsp"%>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/nav.jsp"%>

<c:set var="sidebarOn" value="在职员工" ></c:set>
<c:set var="newUrl" value="/emp/edit?workStatus=0"></c:set>
<c:set var="newName" value="新增员工"></c:set>

<div class="Main">
	<div id="SideBar">
        <%@include file="sideBar.jsp"%>
	</div>
	<div class="ContentWrapper">
		<div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
                <li><span>员工管理</span> <i class="fa fa-angle-right"></i></li>
                <li><span>在职员工</span></li>
            </ul>
            <div class="SearchBox ClearFix">
                <form action="/emp/list">
                    <input type="hidden" value="0" name="workStatus">
                    <div class="SearchGroup">
                        <select name="cityId" id="cityId" class="CustomSelect" value="<%= request.getParameter("cityId") %>">
                            <option value="">请选择城市</option>
                            <c:forEach items="${map.citys}" var="city">
                                <option value="${city.id}" >${city.cityName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="SearchGroup">
                        <select name="departmentId" id="departmentId" class="CustomSelect"  value="<%= request.getParameter("departmentId") %>">
                            <option value="">请选择部门</option>
                            <c:forEach items="${map.depts}" var="dept">
                                <option value="${dept.id}">${dept.departmentName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="SearchGroup">
                        <div class="SearchButtonWrapper ClearFix">
                            <input style="margin-top: 0" type="text" name="mobile" class="CustomInput" value="<%= request.getParameter("mobile") != null ? request.getParameter("mobile") : "" %>">
                            <button style="margin-top: 0" type="submit" class="Btn BtnPrimary BtnSmall SearchBoxBtn"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </form>
            </div>
			<table border="1" class="Table">
                <tr class="THead">
                    <th>员工编号</th>
                    <th>姓名</th>
                    <th>手机号</th>
                    <th>城市</th>
                    <th>所属部门</th>
                    <th>职位</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <tbody>
                <c:forEach items="${map.page.list}" var="emp">
                    <tr>
                        <td>${emp.empIdentity}</td>
                        <td>${emp.realName}</td>
                        <td>${emp.mobile}</td>
                        <td>${emp.baseCityName}</td>
                        <td>${emp.departmentName}</td>
                        <td>${emp.positionName}</td>
                        <td><c:if test="${emp.workStatus==null || emp.workStatus==0 }">在职</c:if>
                            <c:if test="${emp.workStatus == 1}">离职</c:if>
                        </td>
                        <td class="ListAction">
	                        <summer:a href="/emp/detail?workStatus=0&id=${emp.id}" style="ListBtn" body="详情"></summer:a>
                            <summer:a href="/emp/edit?workStatus=0&id=${emp.id}" style="ListBtn" body="编辑"></summer:a>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <div class="SelectWrapper">
                                <select name="" id="" class="CustomSelectText AjaxSelect">
                                    <option value="">设置</option>
                                    <c:if test='${CurrentUser.check("/emp/empQuit")}'>
                                        <option value="/emp/empQuit?empId=${emp.id}" data-url="/emp/empQuit?empId=${emp.id}" data-msg="设置成功" data-pendingType="dialog" data-pending="设置中...">设为离职状态</option>
                                    </c:if>
	                                <c:if test="${CurrentUser.check('/emp/updateEmpGroup')}">
		                                <option value="/emp/updateEmpGroup?workStatus=0&empId=${emp.id}" class="OptionRedirect">设置角色权限</option>
	                                </c:if>
	                                <c:if test="${CurrentUser.check('/emp/resetPasswordPage')}">
		                                <option value="/emp/resetPasswordPage?workStatus=0&empId=${emp.id}" class="OptionRedirect">重置账号密码</option>
	                                </c:if>
                                </select>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
			</table>
			<c:set var="page" value="${map.page}"></c:set>
			<c:set var="pageUrl" value="/emp/list?workStatus=0"></c:set>
			<%@include file="../lib/pagination.jsp"%>

		</div>
	</div>
</div>
<%@include file="../lib/footer.jsp"%>
