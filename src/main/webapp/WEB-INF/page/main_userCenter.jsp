<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户中心</title>

    <spring:url value="/resources/bootstrap3/css/style.css"
                var="styleCss"/>
    <link href="${styleCss}" rel="stylesheet"/>
    <spring:url value="/resources/bootstrap3/css/top.css"
                var="topCss"/>
    <link href="${topCss}" rel="stylesheet"/>
    <spring:url value="/resources/bootstrap3/css/bootstrap-theme.min.css"
                var="bootstrapCss"/>
    <link href="${bootstrapCss}" rel="stylesheet"/>
    <spring:url value="/resources/css/tos.css"
                var="tosCss"/>
    <link href="${tosCss}" rel="stylesheet"/>
    <spring:url value="/resources/css/bootstrap.min.css"
                var="bootstrapCss"/>
    <link href="${bootstrapCss}" rel="stylesheet"/>
    <script src="<c:url value="/resources/bootstrap3/js/jquery-3.1.1.min.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/bootstrap3/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/js/My97DatePicker/WdatePicker.js" />"></script>
    <script src="<c:url value="/resources/js/onclock.js" />"></script>
    <script src="<c:url value="/resources/js/register.js" />"></script>

    <%
        String mainPage = (String) request.getAttribute("mainPage");
        if (mainPage == null || mainPage.equals("")) {
            mainPage = "common/default2.jsp";
        }
    %>
</head>
<body>
<table width="960px" align="center" cellspacing="20px;" cellpadding="20px;"
       style="border: 1px solid red;margin:0px auto;margin-top:45px;">
    <tr style="border: 1px solid red;">
        <td colspan="2">
            <jsp:include page="common/head.jsp"></jsp:include>
        </td>
    </tr>
    <tr style="border: 1px solid red;">
        <td width="18.9%" valign="top" style="border: 1px solid red;">
            <jsp:include page="common/menu.jsp"></jsp:include>
        </td>

        <td width="81.1%" valign="top">
            <jsp:include page="<%=mainPage %>"></jsp:include>
        </td>
    </tr>
    <tr style="border: 1px solid red;">
        <td colspan="2">
            <jsp:include page="common/foot.jsp"></jsp:include>
        </td>
    </tr>
</table>
</body>
</html>