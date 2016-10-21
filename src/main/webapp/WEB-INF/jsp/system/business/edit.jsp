<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="title" value="车商管理"></c:set>
<%@include file="../../lib/header.jsp"%>
<c:set var="navOn" value="车源"></c:set>
<%@include file="../../lib/nav.jsp"%>

<c:set var="newUrl" value="/system/business/edit"></c:set>
<c:set var="newName" value="新增车商"></c:set>
<c:set var="sidebarOn" value="车商" ></c:set>

<div class="Main">
    <div id="SideBar">
        <%@include file="../../carsource/sideBar.jsp" %>
    </div>
    <div class="ContentWrapper">
        <div class="MainContent">
            <ul class="BreadCrumb">
                <li><a href="/system/city/list">系统设置</a> <i class="fa fa-angle-right"></i></li>
                <li><span>车辆基础数据管理</span> <i class="fa fa-angle-right"></i></li>
                <c:if test="${map.business.id == null}">
                    <li><span>新增车商</span></li>
                </c:if>
                <c:if test="${map.business.id != null}">
                    <li><span>编辑车商</span></li>
                </c:if>
            </ul>
            <form action="/system/business/update" class="FormHorizontal ValidateForm HistoryGo">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="${map.business.id}">
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle"><c:if test="${map.business.id == null}">新增车商</c:if><c:if test="${map.business.id != null }">编辑车商</c:if>
                                <span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span>
                            </div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="businessName" class="FormLayout"><span class="LabelNeed">品牌名：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="businessName" name="businessName" value="${map.business.businessName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="businessLogo"><span>车商LOGO：</span></label>
                                <div class="FormLayout FormItemControl FileUploadWrapper">
                                    <input class="ImageSourceUrl ImageInput" id="businessLogo" name="businessLogo" value="${map.business.businessLogo}" >
                                    <div class="PreShowList">
                                        <input type="hidden" name="imagePreFix" id="ImagePreFix" value="${map.imageUrl}">
                                    </div>
                                    <div class="UploadBtnWrapper">
                                        <input class="FileUpload" type="file" name="upload_file" data-url="/index.php/upload/do_upload_fdfs">
                                        <a class="Btn" href="javascript:;">上传图片</a>
                                    </div>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="businessCityId"><span class="LabelNeed">所在城市：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input type="hidden" value="${map.business.businessCityName}" name="businessCityName" class="BusinessCityName">
                                    <select name="businessCityId" id="businessCityId" class="CustomSelect LinkedInput" data-input="BusinessCityName" value="${map.business.businessCityId}" required>
                                        <option value="">请选择</option>
                                        <c:forEach var="item" items="${map.cityList}">
                                            <option value="${item.id}">${item.cityName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="businessProfile"><span class="LabelNeed">经销公司：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" id="businessProfile" maxlength="50" name="businessProfile" value="${map.business.businessProfile}"  required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="star"><span class="LabelNeed">星级：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <select class="CustomSelect" id="star" name="star" value="${map.business.star}"  required>
                                        <option value="50">五星</option>
                                        <option value="40">四星</option>
                                        <option value="30">三星</option>
                                        <option value="20">两星</option>
                                        <option value="10">一星</option>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="address"><span class="LabelNeed">地址：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" id="address" name="address" value="${map.business.address}"  required>
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