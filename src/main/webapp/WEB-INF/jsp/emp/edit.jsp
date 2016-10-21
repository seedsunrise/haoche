<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>


<c:if test="${list.emp == null}">
    <c:set var="title" value="新增员工"></c:set>
</c:if>
<c:if test="${list.emp != null}">
    <c:set var="title" value="编辑员工"></c:set>
</c:if>

<c:if test="${list.workStatus == 0}">
    <c:set var="sidebarOn" value="在职员工" ></c:set>
</c:if>
<c:if test="${list.workStatus != 0}">
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
            <form action="/emp/update" method="post" class="FormHorizontal FormHorizontalWidthFull ValidateForm HistoryGo" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <c:if test="${list.emp != null}">
                    <input type="hidden" name="id" value="${list.emp.id}">
                </c:if>
                <c:if test="${list.emp == null}">
                    <input type="hidden" name="id" value="0">
                </c:if>
                <c:if test="${list.workStatus == 0}">
                <input type="hidden" name="status" value="0">
                </c:if>
                <c:if test="${list.workStatus != 0}">
                    <input type="hidden" name="status" value="2">
                </c:if>
                <table class="GroupTable">
                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">员工基本信息<span class="LabelNeedWrapper">（  <span class="LabelNeed">为必填</span>）</span></div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label for="realName" class="FormLayout"><span class="LabelNeed">员工中文姓名：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="8" type="text" id="realName" name="realName" value="${list.emp.realName}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="username">员工英文姓名：</label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="20" type="text" id="username" name="username" value="${list.emp.username}">
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="baseCityId"><span class="LabelNeed">所在城市：</span></label>
                                <input type="hidden" value="${list.emp.baseCityName}" name="baseCityName" class="BaseCityName">
                                <div class="FormLayout FormItemControl">
                                    <select name="baseCityId" id="baseCityId" class="CustomSelect LinkedInput" data-input="BaseCityName" value="${list.emp.baseCityId}"required>
                                        <option value="">请选择</option>
                                        <c:forEach var="item" items="${list.cityList}">
                                            <option value="${item.id}">${item.cityName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="departmentId"><span class="LabelNeed">所属部门：</span></label>
                                <input type="hidden" value="${list.emp.departmentName}" name="departmentName" class="DepartmentName">
                                <div class="FormLayout FormItemControl">
                                    <select value="${list.emp.departmentId}" name="departmentId" id="departmentId" class="CustomSelect LinkSelect LinkedInput" data-input="DepartmentName" data-link="positionId" data-url="/emp/getPositionList?departmentId=" required>
                                        <option value="">请选择</option>
                                        <c:forEach var="item" items="${list.depList}">
                                            <option value="${item.id}">${item.departmentName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="positionId"><span>岗位：</span></label>
                                <input type="hidden" value="${list.emp.positionName}" name="positionName" class="PositionName">
                                <div class="FormLayout FormItemControl">
                                    <select value="${list.emp.positionId}" name="positionId" id="positionId" class="CustomSelect LinkedInput" data-input="PositionName">
                                    </select>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td class="TableGroupTitle">
                            <div class="GroupTitle">员工账号信息<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
                        </td>
                        <td class="TableGroupContent">
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="mobile"><span class="LabelNeed">手机号：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" id="mobile" name="mobile" value="${list.emp.mobile}" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="wxTeamOpenId">OpenId：</label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" type="text" maxlength="30" id="wxTeamOpenId" name="wxTeamOpenId" value="${list.emp.wxTeamOpenId}">
                                </div>
                            </div>

                            <c:if test="${list.emp == null}">
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="password"><span class="LabelNeed">初始登陆密码：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="20" type="password" id="password" name="password" required>
                                </div>
                            </div>
                            <div class="FormItem ClearFix">
                                <label class="FormLayout" for="repwd"><span class="LabelNeed">确认密码：</span></label>
                                <div class="FormLayout FormItemControl">
                                    <input class="FormInput" maxlength="20" type="password" id="repwd" name="repwd" required>
                                </div>
                            </div>
                            </c:if>
                        </td>
                    </tr>

	                <tr id="IdentifyFormGroup" class="<c:if test="${list.emp.departmentName == '品质整备部'}">IdentifyFormGroupHidden</c:if>">
		                <td class="TableGroupTitle">
			                <div class="GroupTitle">员工鉴定信息<span class="LabelNeedWrapper">（ <span class="LabelNeed">为必填</span>）</span></div>
		                </td>
		                <td class="TableGroupContent">
			                <div class="FormItem ClearFix">
				                <label class="FormLayout" for="checkCarNum"><span class="LabelNeed">已检测车辆数：</span></label>
				                <div class="FormLayout FormItemControl">
					                <input class="FormInput" type="text" id="checkCarNum" name="checkCarNum" value="${list.emp.checkCarNum == null ? '0' : list.emp.checkCarNum }" required>
				                </div>
			                </div>
			                <div class="FormItem ClearFix">
				                <label class="FormLayout" for="level"><span class="LabelNeed">资质等级：</span></label>
				                <div class="FormLayout FormItemControl">
					                <input class="FormInput" type="text" id="level" name="level" value="${list.emp.level}" required>
				                </div>
			                </div>
			                <div class="FormItem ClearFix">
				                <label class="FormLayout" for="level"><span class="LabelNeed">鉴定师简介：</span></label>
				                <div class="FormLayout FormItemControl">
					                <textarea class="FormInput" type="text" id="profile" name="profile" required>${list.emp.profile}</textarea>
				                </div>
			                </div>
			                <div class="FormItem ClearFix">
				                <label class="FormLayout" for="level"><span class="LabelNeed">国家资质等级：</span></label>
				                <div class="FormLayout FormItemControl">
					                <input class="FormInput" type="text" id="levelCountry" name="levelCountry" value="${list.emp.levelCountry}" required>
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
