<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<option value="">请选择</option>
<c:forEach items="${carModelList}" var="carModel">
    <option value="${carModel.id}">${carModel.modelName}</option>
</c:forEach>