<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<c:forEach items="${positionList}" var="position">
    <option value="${position.id}">${position.positionName}</option>
</c:forEach>