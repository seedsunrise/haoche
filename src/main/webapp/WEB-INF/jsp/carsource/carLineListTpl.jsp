<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<option value="">全部车系</option>
<c:forEach items="${carLineList}" var="carLine">
    <option value="${carLine.id}">${carLine.lineName}</option>
</c:forEach>