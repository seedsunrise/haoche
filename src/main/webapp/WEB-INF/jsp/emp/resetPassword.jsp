<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="重置员工密码"></c:set>

<c:if test="${map.workStatus == 0}">
    <c:set var="sidebarOn" value="在职员工" ></c:set>
</c:if>
<c:if test="${map.workStatus != 0}">
    <c:set var="sidebarOn" value="全部员工" ></c:set>
</c:if>

<c:set var="newUrl" value="/emp/edit"></c:set>
<c:set var="newName" value="新增员工"></c:set>
<c:set var="navOn" value="员工管理"></c:set>
<%@include file="../lib/header.jsp"%>
<%@include file="../lib/nav.jsp"%>

<div class="Main">
    <div id="SideBar">
        <%@include file="sideBar.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/emp/list">员工管理</a> <i class="fa fa-angle-right"></i></li>
                <li><span>员工管理</span> <i class="fa fa-angle-right"></i></li>
                <li>
                    <span>
                        <c:if test="${list.emp == null}">新增员工</c:if>
                        <c:if test="${list.emp != null}">编辑员工</c:if>
                    </span>
                </li>
            </ul>
            <form action="/emp/resetPwd" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="empId" value="${map.empId}">
                <input type="hidden" name="workStatus" value="${map.workStatus}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle" style="padding-bottom: 60px">
                            <div class="GroupTitle">重置密码<span class="LabelNeedWrapper">（  <span class="LabelNeed">为必填</span>）</span></div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="password" class="FormLayout"><span class="LabelNeed">新密码：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="20" type="password" id="password" name="password" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label for="repwd" class="FormLayout"><span class="LabelNeed">确认密码：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="20" type="password" id="repwd" name="repwd" required>
                                </div>
                            </div>
                        </td>
	                </tr>
                </table>
                <div class="FormItem ClearFix">
                    <button type="submit" class="Btn BtnPrimary FormBtnSubmit">提 交</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="../lib/footer.jsp"%>