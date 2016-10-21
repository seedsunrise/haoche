<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<input type="hidden" name="id" value="${appointment.id}">
<%--<div class="FormItem ClearFix">--%>
    <%--<label class="FormLayout">--%>
        <%--<span>预约创建时间：</span>--%>
    <%--</label>--%>
    <%--<div class="MaintainCheckItemList ClearFix" >--%>
        <%--<label><fmt:formatDate value="${appointment.c}" pattern="yyyy年MM月dd日 HH:mm" /></label>--%>
    <%--</div>--%>
<%--</div>--%>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>预约客户姓名：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.userName}</label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>联系电话：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.mobile}</label>
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
    <label class="FormLayout">
        <span>预约时间：</span>
    </label>
    <div class="MaintainCheckItemList ClearFix">
        <label><fmt:formatDate value="${appointment.appointmentTime}" pattern="yyyy年MM月dd日 HH:mm" /></label>
    </div>
</div>
<div class="OverAppointmentTitle">服务项目及价格:</div>
<div class="Table OverAppointmentTableWrapper">
    <table class="OverAppointmentTable">
        <tr>
            <th>项目名称</th>
            <th>细则备注</th>
            <th>价格(元)</th>
        </tr>
        <c:forEach var="project" items="${appointment.projectDTOList}" varStatus="var">

            <c:if test="${project.isSelect == 1}">
                <tr>
                    <td>${project.projectTitle}</td>
                    <input type="hidden" name="projectDTOList[${var.index}]co.id" value="${project.id}">
                    <td class="NoPadding"><input name="projectDTOList[${var.index}].projectRemarks" class="CustomInput AppointmentProjectPrice" type="text" value="${project.projectRemarks}"></td>
                    <td class="NoPadding"><input name="projectDTOList[${var.index}].projectPrice" class="CustomInput AppointmentProjectPrice" type="text" value="${project.projectPrice}"></td>
                </tr>
            </c:if>
        </c:forEach>
    </table>
</div>
