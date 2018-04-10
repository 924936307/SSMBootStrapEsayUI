<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>后台-用户订单中心</title>
    <spring:url value="/resources/jquery-easyui-1.5.3/themes/default/easyui.css"
                var="easyuiCss"/>
    <link href="${easyuiCss}" rel="stylesheet"/>

    <spring:url value="/resources/jquery-easyui-1.5.3/themes/icon.css"
                var="easyuiIcon"/>
    <link href="${easyuiIcon}" rel="stylesheet"/>

    <script src="<c:url value="/resources/jquery-easyui-1.5.3/jquery.min.js" />"></script>

    <script src="<c:url value="/resources/jquery-easyui-1.5.3/jquery.easyui.min.js" />"></script>

    <script src="<c:url value="/resources/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js" />"></script>

    <script type="text/javascript">

        //var url;

        function searchTicketOrder() {
            $("#dg").datagrid('load', {
                "orderno": $("#s_ticketOrderNo").val(),
                "userName": $("#s_ticketOrderUserName").val()
            });
        }

        function deleteTicketOrder() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if (selectedRows.length == 0) {
                $.messager.alert("系统提示", "请选择要删除的数据！");
                return;
            }
            var strIds = [];
            for (var i = 0; i < selectedRows.length; i++) {
                strIds.push(selectedRows[i].id);
            }
            var ids = strIds.join(",");
            $.messager.confirm("系统提示", "您确认要删除这<font color=red>" + selectedRows.length + "</font>条数据吗？", function (r) {
                if (r) {
                    $.post("/MavenDemo/manager/adminDeleteTicketOrder", {ids: ids}, function (result) {
                        if (result.success) {
                            $.messager.alert("系统提示", "数据已成功删除！");
                            $("#dg").datagrid("reload");
                        } else {
                            $.messager.alert("系统提示", "删除失败！");
                        }
                    }, "json");
                }
            });

        }


        function formatFlightName(val, row) {
            return row.flight.name;
        }

        function formatUserName(val, row) {
            return row.user.userName;
        }
    </script>
</head>
<body style="margin:1px;">
<table id="dg" title="订单管理" class="easyui-datagrid"
         data-options="
            fit:true,
            rownumbers:true,
            autoRowHeight:true,
            pagination:true,
            SingleSelect:false,
            pageSize:10,
            pageList: [10, 20, 30],
            url:'<%=request.getContextPath()%>/manager/adminTicketOrderList',
            method:'get',
            toolbar:'#tb'">
    <thead>
    <tr>
        <th field="cb" checkbox="true" align="center"></th>
        <th field="id" width="50" align="center">编号</th>
        <th field="orderno" width="200" align="center">订单号</th>
        <th field="ordertime" width="175" align="center">订购时间</th>
        <th field="flightName" width="150" align="center" >航班名称</th>
        <th field="userName" width="100" align="center" >用户名</th>
        <th field="spacetype" width="100" align="center">座舱类型</th>
        <th field="price" width="100" align="center">票价</th>
        <th field="num" width="100" align="center">订购数量</th>
        <th field="totalprice" width="100" align="center">总价</th>
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:deleteTicketOrder()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除订单</a>
    </div>
    <div>
        &nbsp;订单号：<input type="text" id="s_ticketOrderNo" size="20"
                         onkeydown="if(event.keyCode==13) searchTicketOrder()"/>
        &nbsp;用户名：<input type="text" id="s_ticketOrderUserName" size="20"
                         onkeydown="if(event.keyCode==13) searchTicketOrder()"/>
        <a href="javascript:searchTicketOrder()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
    </div>
</div>


</body>
</html>