<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="广告列表"></c:set>
<%@include file="../../lib/header.jsp" %>
<c:set var="navOn" value="广告列表"></c:set>
<%@include file="../../lib/nav.jsp" %>

<c:set var="newUrl" value="/system/banner/edit"></c:set>
<c:set var="newName" value="新增广告"></c:set>
<c:set var="sidebarOn" value="广告列表"></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/banner/list">APP广告</a> <i class="fa fa-angle-right"></i></li>
                <li><span>修改APP广告</span></li>
            </ul>
            <form action="/system/banner/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.banner.id}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">广告信息<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="bannerType"><span class="LabelNeed">广告类型：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <select name="bannerType" id="bannerType"
                                            class="CustomSelect" data-link="bannerTypeId"
                                            data-input="bannerType" value="${map.banner.bannerType}" required>
                                        <option value="">请选择</option>
                                        <option value="1">首页轮播</option>
                                        <option value="2">首页提示</option>
                                        <option value="3">APP启动页</option>
                                        <option value="4">车主</option>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="clickType"><span class="LabelNeed">点击效果：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <select name="clickType" id="clickType"
                                            class="CustomSelect" data-link="clickTypeId"
                                            data-input="clickType" value="${map.banner.clickType}" required>
                                        <option value="">请选择</option>
                                        <option value="1">无效果</option>
                                        <option value="2">跳转APP内页</option>
                                        <option value="3">跳转外部链接</option>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="clickUrl"><span class="">跳转地址描述：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="10" type="text" id="clickUrl"
                                           name="clickUrl" value="${map.banner.clickUrl}">
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="sortIndex"><span class="">排序值：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="10" type="text" id="sortIndex"
                                           name="sortIndex" value="${map.banner.sortIndex}">
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label for="bannerPic" class="FormLayout"><span class="LabelNeed">广告图片：</span></label>

                                <div class="FormLayout FormItemControl FileUploadWrapper FormPhotoWrapper">
                                    <div class="FormLayout FormItemControl FileUploadWrapper">
                                        <input class="ImageSourceUrl ImageInput" id="bannerPic" name="bannerPic" value="${map.banner.bannerPic}" required>
                                        <div class="PreShowList">
                                            <input type="hidden" name="imagePreFix" id="ImagePreFix" value="${map.imageUrl}">
                                        </div>
                                        <div class="UploadBtnWrapper">
                                            <input class="FileUpload" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs">
                                            <a class="Btn" href="javascript:;">上传图片</a>
                                        </div>
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

