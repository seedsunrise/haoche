<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:if test="${map.company.id == null}">
    <c:set var="title" value="新增保险公司"></c:set>
</c:if>
<c:if test="${map.company.id != null}">
    <c:set var="title" value="编辑保险公司"></c:set>
</c:if>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/insurance/company/edit"></c:set>
<c:set var="newName" value="新增保险公司"></c:set>
<c:set var="sidebarOn" value="保险公司"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车险设置</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${map.company.id == null}">
                    <li><span>新增保险公司</span></li>
                </c:if>
                <c:if test="${map.company.id != null}">
                    <li><span>编辑保险公司</span></li>
                </c:if>
            </ul>
            <form action="/insurance/company/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.company.id}">

                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${map.company.id == null}">新增保险公司</c:if><c:if test="${map.company.id != null}">编辑保险公司</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="name" class="FormLayout"><span class="LabelNeed">保险公司名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="name" name="name"
                                           value="${map.company.name}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="logo"><span class="">公司LOGO：</span></label>
                                <div class="FormLayout FormItemControl FileUploadWrapper">
                                    <input class="ImageSourceUrl ImageInput" type="text" id="logo" name="logo"
                                           value="${map.company.logo}" >
                                    <div class="PreShowList">
                                        <input type="hidden" name="imagePreFix" id="ImagePreFix"
                                               value="${map.imageUrl}">
                                    </div>
                                    <div class="UploadBtnWrapper">
                                        <input class="FileUpload" type="file" name="upload_file"
                                               data-url="/index.php/upload/do_upload_fdfs">
                                        <a class="Btn" href="javascript:;">上传图片</a>
                                    </div>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="phone"><span class="">企业电话：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="phone" name="phone" value="${map.company.phone}">
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
<%@include file="../../lib/footer.jsp" %>
