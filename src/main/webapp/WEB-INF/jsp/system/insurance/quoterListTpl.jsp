<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<option value="">请选择</option>
<c:forEach items="${quoterList}" var="quoter">
    <option value="${quoter.id}">${quoter.name}</option>
</c:forEach>