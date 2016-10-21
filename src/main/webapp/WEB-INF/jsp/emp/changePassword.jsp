<%@ page import="com.haoche.bos.util.CurrentUser" %>
<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="修改密码"></c:set>
<%@include file="../lib/header.jsp" %>
<%@include file="../lib/nav.jsp" %>
<c:set var="sidebarOn" value="修改密码"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../emp/sideBar1.jsp"%>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><span>个人设置</span> <i class="fa fa-angle-right"></i></li>
                <li><span>修改密码</span> <i class="fa fa-angle-right"></i></li>
            </ul>
            <form action="/emp/changePwd" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">修改登录密码<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="password" class="FormLayout"><span class="LabelNeed">原密码：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="password" id="password" name="password" value=""  required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label for="newPassword" class="FormLayout"><span class="LabelNeed">新密码：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="password" id="newPassword" name="newPassword" value="" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label for="confirmPassword" class="FormLayout"><span class="LabelNeed">确认新密码：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="password" id="confirmPassword" name="confirmPassword" value="" required>
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
<%@include file="../lib/footer.jsp" %>
