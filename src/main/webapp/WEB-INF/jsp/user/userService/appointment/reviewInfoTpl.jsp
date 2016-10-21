<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<input type="hidden" name="id" value="${appointment.id}">
<input type="hidden" name="projectList" id="InputProjectList">
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>预约创建时间：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix" >
        <label><fmt:formatDate value="${appointment.createdAt}" pattern="yyyy年MM月dd日 HH:mm" /></label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>预约客户姓名：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <input class="FormInput" type="text" name="userName" value="${appointment.userName}" />
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>联系电话：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <input class="FormInput" type="text" name="mobile" value="${appointment.mobile}" />
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>车型号：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.carModelName}</label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>车牌号：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.licenseNum}</label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout MaintainLabel">
        <span class="">预约项目：</span>
    </label>
    <div class="MaintainCheckItemList ProjectCheckItemList ClearFix">
        <c:forEach var="project" items="${appointment.projectDTOList}">
            <label><input type="checkbox" value="${project.id}" <c:if test="${project.isSelect == 1}">checked</c:if>>${project.projectTitle}</label>
        </c:forEach>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>客户备注：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.userRequest}</label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>预约时间：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <div class="AppointDateTimePickerWrapper">
            <input class="FormInput DateTimePicker" type="text" name="time" value='<fmt:formatDate value="${appointment.appointmentTime}" pattern="yyyy年MM月dd日 HH:mm" />' />
        </div>
    </div>
</div>