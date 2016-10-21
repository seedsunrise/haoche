<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>
<html class="LoginHtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <link rel="shortcut icon" href="/resources/image/favicon.ico"/>
    <link rel="bookmark" href="/resources/image/favicon.ico"/>
    <link href='<c:url value="../../../resources/css/app.css" />' rel="stylesheet"  type="text/css" />
    <link href='<c:url value="../../../resources/css/lib/vex.css" />' rel="stylesheet" type="text/css" />
    <link href='<c:url value="../../../resources/css/login.css" />' rel="stylesheet"  type="text/css" />
    <title>乾坤好车业务运营系统-登陆</title>
</head>
<body>
<script>
    if (window.devicePixelRatio > 1 || (window.devicePixelRatio == 1 && window.screen.width < 1300 )) {
        document.getElementsByTagName('body')[0].style.zoom = "0.9";
    }
</script>
<div id="LoginWrapper">
    <h1><img src="/resources/image/LoginLogo.png" alt=""></h1>
    <div class="FormAreaWrapper">
            <form class="LoginForm" action="/emp/login" autocomplete="off" novalidate>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="InputWrapper">
                    <div class="FormItem ClearFix">
                        <label for="UserName" class="Label">
                            <img src="/resources/image/icon-user.png" />
                        </label>
                        <input class="LoginMobile" type="text" name="UserName" placeholder="用户名/手机号码" value="" id="UserName" maxlength="30" required/>
                    </div>
                    <div class="FormItem ClearFix">
                        <label for="Password" class="Label">
                            <img src="/resources/image/icon-lock.png" />
                        </label>
                        <input class="LoginMobile" type="password" name="Password" placeholder="请输入密码" value="" id="Password" maxlength="20" required/>
                    </div>
                </div>
	            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" class="Btn BtnDanger SubmitBtn">登 录</button>
            </form>
    </div>
</div>
<script src='<c:url value="../../../resources/javascript/lib/jquery-2.2.3.min.js" />'></script>
<script src='<c:url value="../../../resources/javascript/lib/jquery.validate.min.js" />'></script>
<script src='<c:url value="../../../resources/javascript/lib/jquery.validate.min.js" />'></script>
<script src='<c:url value="../../../resources/javascript/lib/vex.min.js" />'></script>
<script>vex.defaultOptions.className = 'vex-theme-default';</script>
<script src='<c:url value="../../../resources/javascript/app/login.js" />'></script>
</body>
</html>