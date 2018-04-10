<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <spring:url value="/resources/jquery-easyui-1.5.3/themes/default/easyui.css"
                var="easyuiCss"/>
    <link href="${easyuiCss}" rel="stylesheet"/>

    <spring:url value="/resources/jquery-easyui-1.5.3/themes/icon.css"
                var="easyuiIcon"/>
    <link href="${easyuiIcon}" rel="stylesheet"/>

    <script src="<c:url value="/resources/jquery-easyui-1.5.3/jquery.min.js" />"></script>

    <script src="<c:url value="/resources/jquery-easyui-1.5.3/jquery.easyui.min.js" />"></script>

    <script src="<c:url value="/resources/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js" />"></script>

</head>
<body>
<table id="dg" class="easyui-datagrid" title="用户信息" style="height:500px" data-options="
            fit:true,
            rownumbers:true,
            singleSelect:true,
            autoRowHeight:true,
            pagination:true,
            pageSize:10,
            pageList: [10, 20, 30],
            url:'<%=request.getContextPath()%>/user/adminUserList',
            method:'get',
            toolbar:'#tb'">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="50" align="center">编号</th>
        <th field="truename" width="100" align="center">真实姓名</th>
        <th field="username" width="100" align="center">用户名</th>
        <th field="password" width="100" align="center">密码</th>
        <th field="sex" width="50" align="center">性别</th>
        <th field="sfz" width="150" align="center">身份证</th>
        <th field="email" width="100" align="center">邮件</th>
        <th field="phone" width="100" align="center">联系电话</th>
        <%-- <th data-options="field:'id',width:50">ID</th>
         <th data-options="field:'truename',width:250">真实姓名</th>
         <th data-options="field:'username',width:300">用户名</th>
         <th data-options="field:'password',width:150">密码</th>
         <th data-options="field:'sex',width:150">性别</th>
         <th data-options="field:'sfz',width:150">身份证</th>
         <th data-options="field:'email',width:150">邮箱</th>
         <th data-options="field:'phone',width:150">联系电话</th>--%>
    </tr>
    </thead>
</table>
</body>
</html>
