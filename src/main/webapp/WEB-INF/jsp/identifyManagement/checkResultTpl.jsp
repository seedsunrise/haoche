<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=utf-8" %>

<div class="ShowTitle">${resultMap.check.name}</div>
<ul class="CheckResultList ClearFix">
    <c:if test="${resultMap.identifyPoints != null }">
        <li class="ClearFix">
            <span class="CheckItemName">漆面监测点:</span>
            <ul class="ChildPoint ClearFix">
                <c:forEach var="point" items="${resultMap.identifyPoints}">
                    <li>${point}</li>
                </c:forEach>
            </ul>
            <a href="/resources/image/identifyPoint.png" class="FancyBoxImg ShowPointImage">点击查看监测点对照图</a>
        </li>
    </c:if>
    <c:forEach var="checkItem" items="${resultMap.checkItemInfo}">
        <li class="ClearFix">
            <span class="CheckItemName">${checkItem.checkChild.name}:</span>
            <ul class="ChildContentList ClearFix">
                <c:forEach var="childContent" items="${checkItem.checkChildContent}">
                    <li class='<c:if test="${childContent.isYes == 1}">ChildContentChecked</c:if>'>${childContent.name}</li>
                </c:forEach>
            </ul>
        </li>
    </c:forEach>
    <li class="ClearFix">
        <span class="CheckItemName">备注:</span>
        <span class="CheckRemark">${resultMap.check.remark}</span>
    </li>
    <li class="ClearFix">
        <span class="CheckItemName">照片:</span>
        <c:if test="${resultMap.check.imgUrl != '' }">
            <a href="${resultMap.check.imgUrl}" class="FancyBoxImg CheckImgWrapper">
                <img class="CheckImg" src="${resultMap.check.imgUrl}">
            </a>
        </c:if>
    </li>
</ul>

