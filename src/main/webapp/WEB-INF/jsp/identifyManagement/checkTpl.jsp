<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>

<ul class="CheckList ClearFix">
    <c:forEach var="check" items="${checkDTOList}">
        <li data-url="/identifyManagement/findCheckResultByCheckId?checkId=${check.id}">${check.name}</li>
    </c:forEach>
</ul>
<div class="CheckResultWrapper"></div>

