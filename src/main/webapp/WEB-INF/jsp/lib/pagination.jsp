<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<c:set var="showNumber" value="3"></c:set>
<c:set var="totalPage" value="${Math.ceil(page.count/page.pageSize)}"></c:set>
<c:if test="${page.count > 2}">
    <ul class="Pagination ClearFix">
        <li class="PageTotal">共${page.count}条记录</li>
        <li class="PaginationItem PaginationPrev <c:if test="${page.pageNo == 0}">PaginationDisabled</c:if>">
            <a href="<c:if test="${page.pageNo == 0}">javascript:;</c:if><c:if test="${page.pageNo != 0}">
                <c:choose>
                    <c:when test="${fn:contains(pageUrl,'?')}">${pageUrl}&pageNo=${page.pageNo-1}</c:when>
                    <c:otherwise>${pageUrl}?pageNo=${page.pageNo-1}</c:otherwise>
                </c:choose>
            </c:if>"><i class="fa fa-angle-left"></i><span>上一页</span></a>
        </li>
        <c:set var="pageCount" value="${Math.ceil(page.count/page.pageSize)}"></c:set>
        <c:forEach begin="1" end="${Math.ceil(page.count/page.pageSize)}" var="index">
            <c:if test="${ ((index-1+showNumber >= page.pageNo) && index-1<=page.pageNo) || ((index-1-showNumber<=page.pageNo) && index-1>=page.pageNo)}">
                <li class="PaginationItem <c:if test="${index-1 == page.pageNo}">PaginationActive</c:if>">
                    <c:choose>
                        <c:when test="${fn:contains(pageUrl,'?')}"><a href="${pageUrl}&pageNo=${index-1}">${index}</a></c:when>
                        <c:otherwise><a class="PageNumber" href="${pageUrl}?pageNo=${index-1}">${index}</a></c:otherwise>
                    </c:choose>
                </li>
            </c:if>
        </c:forEach>
        <li class="PaginationItem PaginationNext <c:if test="${page.pageNo + 1 == Math.ceil(page.count/page.pageSize)}">PaginationDisabled</c:if>">
            <a href="<c:if test="${page.pageNo + 1 == Math.ceil(page.count/page.pageSize)}">javascript:;</c:if>
                 <c:if test="${page.pageNo + 1 != Math.ceil(page.count/page.pageSize)}">
                    <c:choose>
                        <c:when test="${fn:contains(pageUrl,'?')}">${pageUrl}&pageNo=${page.pageNo+1}</c:when>
                        <c:otherwise>${pageUrl}?pageNo=${page.pageNo+1}</c:otherwise>
                    </c:choose>
                 </c:if>
            "><span>下一页</span><i class="fa fa-angle-right"></i></a>
        </li>
        <li class="PageTotal">共计：<fmt:formatNumber value="${totalPage + (totalPage % 1 == 0 ? 0 : 0.5)}" type="number" pattern="#" />页</li>
        <li class="PageNow">到第 <input type="text" class="PageInput" value="${page.pageNo + 1}">页</li>
        <li class="PageNowGO PaginationItem" style="padding: 0 12px"><a href="javascript:;" data-url="
            <c:choose>
                <c:when test="${fn:contains(pageUrl,'?')}">${pageUrl}&pageNo=</c:when>
                <c:otherwise>${pageUrl}?pageNo=</c:otherwise>
            </c:choose>
        ">确定</a></li>
    </ul>
</c:if>