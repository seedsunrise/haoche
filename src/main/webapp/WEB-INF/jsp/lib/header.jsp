<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <link rel="shortcut icon" href="/resources/image/favicon.ico"/>
    <link rel="bookmark" href="/resources/image/favicon.ico"/>
    <link href='<c:url value="/resources/dist/all.min.css" />' rel="stylesheet" type="text/css" />
    <title>${title}</title>
</head>
<body>
<script>
    if (window.devicePixelRatio > 1 || (window.devicePixelRatio == 1 && window.screen.width < 1300 )) {
        document.getElementsByTagName('body')[0].style.zoom = "0.9";
    }
</script>
