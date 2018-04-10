<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>后台-用户信息中心</title>
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

        var url;
        function searchUser() {
            $("#dg").datagrid('load', {
                "username": $("#s_userName").val()
            });
        }

        function deleteUser() {
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
                    $.post("/MavenDemo/manager/deleteUser", {ids: ids}, function (result) {
                        if (result.success) {
                           // $.messager.alert("系统提示", "数据已成功删除！");
                            $.messager.alert("系统提示", result.message);
                            $("#dg").datagrid("reload");
                        } else {
                           // $.messager.alert("系统提示", "该用户有订单，不能删除！");
                            $.messager.alert("系统提示", result.message);
                            $("#dg").datagrid("reload");
                        }
                    }, "json");
                }
            });

        }


        function openUserAddDialog() {
            $("#dlg").dialog("open").dialog("setTitle", "添加用户信息");
            url = "/MavenDemo/user/save";
        }


        function saveUser() {
            $("#fm").form("submit", {
                url: url,
                onSubmit: function () {
                    if ($("#Sex").combobox("getValue") == "") {
                        $.messager.alert("系统提示", "请选择性别");
                        return false;
                    }
                    return $(this).form("validate");
                },
                success: function (result) {
                    var result = eval('(' + result + ')');
                    if (result.success) {
                        $.messager.alert("系统提示", "保存成功");
                        resetValue();
                        $("#dlg").dialog("close");
                        $("#dg").datagrid("reload");
                    } else {
                        $.messager.alert("系统提示", "保存失败");
                        return;
                    }
                }
            });
        }

        function openUserModifyDialog() {
            var selectedRows = $("#dg").datagrid('getSelections');
            if (selectedRows.length != 1) {
                $.messager.alert("系统提示", "请选择一条要编辑的数据！");
                return;
            }
            var row = selectedRows[0];
            $("#dlg").dialog("open").dialog("setTitle", "编辑用户信息");
            $("#trueName").val(row.truename);
            $("#userName").val(row.username);
            $("#password").val(row.password);
            $("#Sex").combobox("setValue", row.sex);
            $("#sfz").val(row.sfz);
            $("#email").val(row.email);
            $("#phone").val(row.phone);
            url = "/MavenDemo/user/save?id="+row.id;
        }

        function resetValue() {
            $("#trueName").val("");
            $("#userName").val("");
            $("#password").val("");
            $("#Sex").combobox("setValue", "");
            $("#sfz").val("");
            $("#email").val("");
            $("#phone").val("");
            //$("#address").val("");
        }

        function closeUserDialog() {
            $("#dlg").dialog("close");
            resetValue();
        }
    </script>
</head>
<body style="margin:1px;">
<table id="dg" class="easyui-datagrid" title="用户信息" style="height:500px" data-options="
            fit:true,
            rownumbers:true,
            autoRowHeight:true,
            pagination:true,
            SingleSelect:false,
            pageSize:10,
            pageList: [10, 20, 30],
            url:'<%=request.getContextPath()%>/manager/adminUserList',
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
    </tr>
    </thead>
</table>
<div id="tb">
    <div>
        <a href="javascript:openUserAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
        <a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
        <a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
    </div>
    <div>
        &nbsp;用户名：&nbsp;<input type="text" id="s_userName" size="20" onkeydown="if(event.keyCode==13) searchUser()"/>
        <a href="javascript:searchUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
    </div>
</div>

	<div id="dlg" class="easyui-dialog" style="width: 670px;height:250px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>真实姓名：</td>
	 				<td><input type="text" id="trueName" name="truename" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>用户名：</td>
	 				<td><input type="text" id="userName" name="username" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>密码：</td>
	 				<td><input type="text" id="password" name="password" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>性别：</td>
	 				<td>
	 					<select class="easyui-combobox" id="Sex" name="sex" style="width: 154px;" editable="false" panelHeight="auto">
	 						<option value="">请选择性别</option>
	 						<option value="男">男</option>
	 						<option value="女">女</option>
	 					</select>
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>邮件：</td>
	 				<td><input type="text" id="email" name="email" class="easyui-validatebox" validType="email" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>联系电话：</td>
	 				<td><input type="text" id="phone" name="phone" class="easyui-validatebox" required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>身份证：</td>
	 				<td colspan="4">
	 				    <input type="text" id="sfz" name="sfz" class="easyui-validatebox" required="true" style="width: 300px;"/>
	 				</td>
	 			</tr>
	 		</table>
	 	</form>

	</div>
<div id="dlg-buttons">
    <a href="javascript:saveUser()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
    <a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>