<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>后台-信息中心</title>
	<spring:url value="/resources/jquery-easyui-1.5.3/themes/default/easyui.css"
				var="easyuiCss"/>
	<link href="${easyuiCss}" rel="stylesheet"/>

	<spring:url value="/resources/jquery-easyui-1.5.3/themes/icon.css"
				var="easyuiIcon"/>
	<link href="${easyuiIcon}" rel="stylesheet"/>

	<spring:url value="/resources/images/112.png"
				var="adminPage"/>
	<link href="${adminPage}" rel="icon" />

	<script src="<c:url value="/resources/jquery-easyui-1.5.3/jquery.min.js" />"></script>

	<script src="<c:url value="/resources/jquery-easyui-1.5.3/jquery.easyui.min.js" />"></script>

	<script src="<c:url value="/resources/jquery-easyui-1.5.3/locale/easyui-lang-zh_CN.js" />"></script>

<script type="text/javascript">
	var url;
	
	function openTab(text,url,iconCls){
		if($("#tabs").tabs("exists",text)){
			$("#tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	
	function openPasswordModifyDialog(){
		$("#dlg").dialog("open").dialog("setTitle","修改密码");
		url="/MavenDemo/manager/modifyPassword?id=${currentUser.id}";
	}
	
	function closePasswordModifyDialog(){
		$("#dlg").dialog("close");
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}
	
	function modifyPassword(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				var oldPassword=$("#oldPassword").val();
				var newPassword=$("#newPassword").val();
				var newPassword2=$("#newPassword2").val();
				if(!$(this).form("validate")){
					return false;
				}
				if(oldPassword!='${currentUser.password}'){
					$.messager.alert("系统提示","用户密码输入错误！");
					return false;
				}
				if(newPassword!=newPassword2){
					$.messager.alert("系统提示","确认密码输入错误！");
					return false;
				}
				return true;
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","密码修改成功，下一次登录生效！");
					closePasswordModifyDialog();
				}else{
					$.messager.alert("系统提示","密码修改失败");
					return;
				}
			}
		});
	}
	
	function logout(){
		$.messager.confirm("系统提示","您确定要退出系统吗",function(r){
			if(r){
                $.post("/MavenDemo/manager/logout", function (result) {
                    if (result.success) {
                        $.messager.alert("系统提示","成功退出后台管理系统");
                        window.location.href="/MavenDemo/manager/managerLoginPage";
                    }
                }, "json");
			}
		});
	}


</script>
</head>
<body class="easyui-layout">
<div region="north" style="height: 88px;background-color: #E0ECFF">
	<table style="padding: 5px" width="100%">
		<tr>
			<td width="40%">
				<img src="${pageContext.request.contextPath}/images/112.png"/>
			</td>
			<td valign="bottom" align="right" width="60%" style="margin-right:48px;">
				<font size="3"><strong>欢迎：</strong>${adminUser}</font>
			</td>
		</tr>
	</table>
</div>
<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="首页" data-options="iconCls:'icon-home'">
			<div align="center" style="padding-top: 100px"><font color="red" size="10"><center><marquee direction="up">欢迎您进入后台信息管理</marquee></center></font></div>
		</div>
	</div>
</div>
<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
		<div title="用户管理" data-options="selected:true,iconCls:'icon-user'" style="padding: 10px">
			<a href="javascript:openTab('用户管理','/user/adminManagerPage','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-manage'" style="width: 150px;">管理用户</a>
		</div>
		
		<div title="客机管理"  data-options="iconCls:'icon-aircraft'" style="padding:10px;">
			<a href="javascript:openTab('客机管理','/aircraft/adminAircraftPage','icon-aircraft')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-manage'" style="width: 150px;">管理客机</a>
		</div>
		<div title="航班管理" data-options="iconCls:'icon-flight'" style="padding:10px">
			<a href="javascript:openTab('航班管理','/flight/adminFlightPage','icon-flight')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-manage'" style="width: 150px;">管理航班</a>
		</div>
		<div title="机票管理"  data-options="iconCls:'icon-ticket'" style="padding:10px">
			<a href="javascript:openTab('机票管理','/ticketOrder/adminTicketOrderPage','icon-ticket')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-manage'" style="width: 150px;">管理订单</a>
		</div>
		<div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
			<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
			<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
		</div>
	</div>
</div>
<div region="south" style="height: 25px;padding: 5px;" align="center">
	版权所有 翻版必究！
</div>


<div id="dlg" class="easyui-dialog" style="width: 400px;height:250px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
 	<form id="fm" method="post">
 		<table cellspacing="8px">
 			<tr>
 				<td>用户名：</td>
 				<td><input type="text" id="userName" name="username" value="${adminUser}" readonly="readonly" style="width: 200px"/></td>
 			</tr>
 			<tr>
 				<td>原密码：</td>
 				<td><input type="password" id="oldPassword" name="oldPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
 			</tr>
 			<tr>
 				<td>新密码：</td>
 				<td><input type="password" id="newPassword" name="password" class="easyui-validatebox" required="true" style="width: 200px"/></td>
 			</tr>
 			<tr>
 				<td>确认新密码：</td>
 				<td><input type="password" id="newPassword2" name="surePass"  class="easyui-validatebox" required="true" style="width: 200px"/></td>
 			</tr>
 		</table>
 	</form>
</div>

<div id="dlg-buttons">
	<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
	<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
</div>
</body>
</html>