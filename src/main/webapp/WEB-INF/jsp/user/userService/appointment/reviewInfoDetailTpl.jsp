<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=utf-8" %>

<c:set var="appointment" value="${map.appointment}"></c:set>
<input type="hidden" name="id" value="${appointment.id}">
<input type="hidden" name="projectList" id="InputProjectList">
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
        <span>联&nbsp&nbsp&nbsp系&nbsp&nbsp电&nbsp&nbsp话：</span>
    </label>

    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.mobile}</label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>汽&nbsp&nbsp&nbsp车&nbsp&nbsp型&nbsp&nbsp号：</span>
    </label>

    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.carModelName}</label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>车&nbsp&nbsp&nbsp牌&nbsp&nbsp号&nbsp&nbsp码：</span>
    </label>

    <div class="MaintainCheckItemList ClearFix">
        <label>${appointment.licenseNum}</label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>预&nbsp&nbsp&nbsp约&nbsp&nbsp时&nbsp&nbsp间：</span>
    </label>

    <div class="MaintainCheckItemList ClearFix">
        <label><fmt:formatDate value="${appointment.appointmentTime}" pattern="yyyy年MM月dd日 HH:mm"/></label>
    </div>
</div>
<div class="FormItem ClearFix">
    <label class="FormLayout">
        <span>下&nbsp&nbsp&nbsp单&nbsp&nbsp时&nbsp&nbsp间：</span>
    </label>

    <div class="MaintainCheckItemList ClearFix">
        <label><fmt:formatDate value="${appointment.createdAt}" pattern="yyyy年MM月dd日 HH:mm"/></label>
    </div>
</div>
<c:if test="${appointment.appointmentStatus==1 || appointment.appointmentStatus==2 ||appointment.appointmentStatus==3 ||(appointment.appointmentStatus==4&& appointment.cancelServiceTime>appointment.appointmentCheckTime)}">
    <div class="FormItem ClearFix">
        <label class="FormLayout">
            <span>预约确认时间：</span>
        </label>

        <div class="MaintainCheckItemList ClearFix">
            <label><fmt:formatDate value="${appointment.appointmentCheckTime}" pattern="yyyy年MM月dd日 HH:mm"/></label>
        </div>
    </div>
</c:if>
<c:if test="${appointment.appointmentStatus==2 ||appointment.appointmentStatus==3}">
    <div class="FormItem ClearFix">
        <label class="FormLayout">
            <span>开始服务时间：</span>
        </label>

        <div class="MaintainCheckItemList ClearFix">
            <label><fmt:formatDate value="${appointment.startServiceTime}" pattern="yyyy年MM月dd日 HH:mm"/></label>
        </div>
    </div>
</c:if>
<c:if test="${appointment.appointmentStatus==3}">
    <div class="FormItem ClearFix">
        <label class="FormLayout">
            <span>服务结束时间：</span>
        </label>

        <div class="MaintainCheckItemList ClearFix">
            <label><fmt:formatDate value="${appointment.endServiceTime}" pattern="yyyy年MM月dd日 HH:mm"/></label>
        </div>
    </div>
</c:if>

<c:if test="${appointment.appointmentStatus==4}">
    <div class="FormItem ClearFix">
        <label class="FormLayout">
            <span>预约取消时间：</span>
        </label>

        <div class="MaintainCheckItemList ClearFix">
            <label><fmt:formatDate value="${appointment.cancelServiceTime}" pattern="yyyy年MM月dd日 HH:mm"/></label>
        </div>
    </div>
</c:if>


<c:if test="${appointment.appointmentStatus==3}">
    <div class="OverAppointmentTitle">服务项目及价格:</div>
    <div class="Table OverAppointmentTableWrapper">
        <table class="OverAppointmentTable">
            <tr>
                <th>项目名称</th>
                <th>细则备注</th>
                <th>价格(元)</th>
            </tr>
            <c:forEach var="project" items="${appointment.projectDTOList}">
                <c:if test="${project.isSelect == 1}">
                    <tr>
                        <td>${project.projectTitle}</td>
                        <td>${project.projectRemarks}</td>
                        <td>${project.projectPrice}</td>
                    </tr>
                </c:if>
            </c:forEach>
            <tr>
                <td>合计:</td>
                <td></td>
                <td>${appointment.serviceCharge} </td>
               <%-- <input type="hidden" value="${appointment}">--%>
            </tr>
        </table>
    </div>
</c:if>
<c:if test="${appointment.appointmentStatus!=3}">
    <div class="OverAppointmentTitle">服务项目:
        <c:forEach var="project" items="${appointment.projectDTOList}">
            <c:if test="${project.isSelect == 1}">
                ${project.projectTitle};
            </c:if>

        </c:forEach>
    </div>
</c:if>
<div class="ProjectRemarksWrapper ClearFix">
    <span>客户备注：</span>
   ${appointment.userRequest}
    <c:if test="${appointment.appointmentStatus!=0}">
        <div class="ProjectRemarks"><label>订单备注: ${appointment.remarks}</label></div>

    </c:if>

    <div class="ProjectRemarksImage">
        <c:if test="${appointment.image != ''}">
            <c:set var="remarkImgs" value="${ fn:split(appointment.image,'|') }"/>
            <c:forEach var="remarkImg" items="${ remarkImgs }">
                <img class="remarkImg FancyBoxImg" href="${map.imageUrl}${remarkImg}"
                     src="${map.imageUrl}${remarkImg}"/>
            </c:forEach>
        </c:if>
    </div>
</div>

