<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="新增品牌"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="系统设置"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/carbrand/edit"></c:set>
<c:set var="newName" value="新增品牌"></c:set>
<c:set var="sidebarOn" value="品牌"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>

                <c:if test="${map.carBrand.id == null}">
                    <li><span>新增品牌</span></li>
                </c:if>
                <c:if test="${map.carBrand.id != null}">
                    <li><span>编辑品牌</span></li>
                </c:if>
            </ul>
            <form action="/system/carbrand/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.carBrand.id}">
                <input type="hidden" name="action" value="${map.carBrand.action}">

                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${map.carBrand.id == null}">新增品牌</c:if><c:if test="${map.carBrand.id != null}">编辑品牌</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="brandName" class="FormLayout"><span class="LabelNeed">品牌中文名称：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="brandName" name="brandName"
                                           value="${map.carBrand.brandName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="brandChar"><span class="LabelNeed">品牌索引：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <div class="FormLayout FormItemControl">
                                        <select name="brandChar" id="brandChar" class="CustomSelect"
                                                value="${map.carBrand.brandChar}" required>
                                            <option value="">请选择</option>
                                            <% for (int i = (int) 'A'; i < 'A' + 26; i++) {%>
                                            <option value="<%= (char)i %>"><%= (char) i %>
                                            </option>
                                            <%}%>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="brandIcon"><span class="LabelNeed">品牌缩略图：</span></label>
                                <div class="FormLayout FormItemControl FileUploadWrapper">
                                    <input class="ImageSourceUrl ImageInput" type="text" id="brandIcon" name="brandIcon"
                                           value="${map.carBrand.brandIcon}" >
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
