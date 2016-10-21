<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>

<option value="">请选择</option>
<c:forEach items="${subBrandList}" var="subBrand">
    <option value="${subBrand.id}">${subBrand.subBrandName}</option>
</c:forEach>