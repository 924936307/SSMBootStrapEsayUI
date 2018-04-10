<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员登陆界面</title>

    <spring:url value="/resources/core/css/bootstrap.min.css"
                var="assets"/>
    <link href="${assets}" rel="stylesheet"/>

    <spring:url value="/resources/core/css/font-awesome.min.css"
                var="min"/>
    <link href="${min}" rel="stylesheet"/>

    <spring:url value="/resources/core/css/form-elements.css"
                var="assetsCss"/>
    <link href="${assetsCss}" rel="stylesheet"/>

    <spring:url value="/resources/core/css/style.css"
                var="assetsStyle"/>
    <link href="${assetsStyle}" rel="stylesheet"/>

    <spring:url value="/resources/core/images/favicon.png"
                var="icon"/>
    <link href="${icon}" rel="icon"/>

    <spring:url value="/resources/core/images/apple-touch-icon-144-precomposed.png"
                var="assets1"/>
    <link href="${assets1}" rel="icon" sizes="144x144"/>

    <spring:url value="/resources/core/images/apple-touch-icon-114-precomposed.png"
                var="assets2"/>
    <link href="${assets2}" rel="icon" sizes="144x144"/>

    <spring:url value="/resources/core/images/apple-touch-icon-72-precomposed.png"
                var="assets3"/>
    <link href="${assets3}" rel="icon" sizes="72x72"/>

    <spring:url value="/resources/core/images/apple-touch-icon-57-precomposed.png"
                var="assets4"/>
    <link href="${assets4}" rel="icon"/>


</head>
<body>

<%
    Object message = session.getAttribute("message");
    if (message == null) {
        message = "";
    }
%>
<!-- Top content -->
<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>
                                <center>机票管理系统后台登陆</center>
                            </h3>
                            <p>Enter your username and password to log on:</p>
                            <p><a style="color: red;" id="login_prompt"><h3><%=message%>
                            </h3></a></p>
                        </div>
                    </div>
                    <div class="form-bottom">
                        <form role="form" action="${pageContext.request.contextPath}/user/login" method="post" class="login-form">
                            <div class="form-group">
                                <input type="text" name="username" class="form-username form-control"
                                            id="form-username">
                            </div>
                            <div class="form-group">
                                <input type="password" name="password"
                                       class="form-password form-control" id="form-password"  >
                            </div>
                            <button type="submit" class="btn" >Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Javascript -->

<script src="<c:url value="/resources/core/js/jquery-3.1.1.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.backstretch.min.js" />"></script>
<script src="<c:url value="/resources/core/js/scripts.js" />"></script>
<script src="<c:url value="/resources/core/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/placeholder.js" />"></script>

<script type="text/javascript">
    $("[name=username]").focus(function () {
        $("[name=username]").val("");
    });

    $("[name=password]").focus(function () {
        $("[name=password]").val("");
    });

</script>

</body>
</html>
