<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>主页</title>

    <spring:url value="/resources/css/bootstrap.min.css"
                var="bootstrapCss"/>
    <link href="${bootstrapCss}" rel="stylesheet"/>

    <spring:url value="/resources/bootstrap3/css/bootstrap-theme.min.css"
                var="bootstrapCss1"/>
    <link href="${bootstrapCss1}" rel="stylesheet"/>

    <spring:url value="/resources/css/tos.css"
                var="bootstrapCss2"/>
    <link href="${bootstrapCss2}" rel="stylesheet"/>

    <script src="<c:url value="/resources/bootstrap3/js/jquery-3.1.1.min.js" />"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
    <script src="<c:url value="/resources/bootstrap3/js/onclock.js" />"></script>
    <script src="<c:url value="/resources/js/My97DatePicker/WdatePicker.js" />"></script>
    <%


        String mainPage = (String) request.getAttribute("mainPage");
        if (mainPage == null || mainPage.equals("")) {
            mainPage = "common/default.jsp";
        }
    %>
</head>
<body>
<table width="960px" align="center" cellspacing="20px;" cellpadding="20px;" border="1px solid red;">
    <tr>
        <td colspan="2">
            <jsp:include page="common/head.jsp"></jsp:include>
        </td>
    </tr>
    <tr>
        <td width="30%" valign="top">
            <jsp:include page="common/left.jsp"></jsp:include>
        </td>

        <td width="70%" valign="top">
            <jsp:include page="<%=mainPage %>"></jsp:include>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <jsp:include page="common/foot.jsp"></jsp:include>
        </td>
    </tr>
</table>
</body>
</html>