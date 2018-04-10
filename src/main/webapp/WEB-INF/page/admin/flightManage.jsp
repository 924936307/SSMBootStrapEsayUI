<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>后台-航班中心</title>
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
	
	function searchFlight(){
		$("#dg").datagrid('load',{
			"name":$("#s_flightName").val(),
			"fromcity":$("#s_fromCity").val(),
			"tocity":$("#s_toCity").val(),
			"fromTime":$("#s_fromTime").datebox("getValue")
		});
	}
	
	function deleteFlight(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("/MavenDemo/manager/adminDeleteFlight",{ids:ids},function(result){
					if(result.success){
                        $.messager.alert("系统提示",result.message);
                        //$.messager.alert("系统提示","数据已成功删除！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示",result.message);
						//$.messager.alert("系统提示","删除失败！");
					}
				},"json");
			}
		});
		
	}
	
	
	function openFlightAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加航班信息");
		url="/MavenDemo/flight/save";
	}
	
	
	function saveFlight(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				if($("#flightType").combobox("getValue")==""){
					$.messager.alert("系统提示","请选择航班类型");
					return false;
				}
				if($("#aircraft").combobox("getValue")==""){
					$.messager.alert("系统提示","请选择使用客机");
					return false;
				}
				return $(this).form("validate");
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	
	function openFlightModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		alert(row.ectickettotal+"   "+row.fctickettotal)
		$("#dlg").dialog("open").dialog("setTitle","编辑航班信息");
		$("#name").val(row.name);
		$("#flightType").combobox("setValue",row.flighttype);
		$("#fromCity").val(row.fromcity);
		$("#fromTime").datebox("setValue",row.fromtime);
		$("#toCity").val(row.tocity);
        $("#ecTicketTotal").val(row.ectickettotal);
        $("#fcPrice").val(row.fcprice);
        $("#fcTicketTotal").val(row.fctickettotal);
        $("#aircraft").combobox("setValue",row.aircraftid);
        $("#toTime").datebox("setValue",row.totime);
        $("#ecPrice").val(row.ecprice);
		url="/MavenDemo/flight/save?id="+row.id;
	}
	
	function resetValue(){
		$("#name").val("");
		$("#flightType").combobox("setValue","");
		$("#fromCity").val("");
		$("#fromTime").datebox("setValue","");
		$("#toCity").val("");
		$("#toTime").datebox("setValue","");
		$("#ecPrice").val("");
		$("#ecTicketTotal").val("");
		$("#fcPrice").val("");
		$("#fcTicketTotal").val("");
		$("#aircraft").combobox("setValue","");
	}
	
	function closeFlightDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function formatAircraftName(val,row){
		return row.aircraft.name;
	}
	
	function formatAircraftId(val,row){
		return row.aircraft.id;
	}
</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="航班管理" class="easyui-datagrid"
		   data-options="
            fit:true,
            rownumbers:true,
            autoRowHeight:true,
            pagination:true,
            SingleSelect:false,
            pageSize:10,
            pageList: [10, 20, 30],
            url:'<%=request.getContextPath()%>/manager/adminFlightList',
            method:'get',
            toolbar:'#tb'">
	 <thead data-options="frozen:true">
			<tr>
				<th field="cb" checkbox="true" align="center"></th>
		 		<th field="id" width="50" align="center">编号</th>
		 		<th field="name" width="150" align="center">航班名称</th>
		 		<th field="flighttype" width="100" align="center">航班类型</th>
		 		<th field="fromcity" width="100" align="center">出发城市</th>
		 		<th field="tocity" width="100" align="center">目的城市</th>
		 		<th field="fromtime" width="150" align="center">出发时间</th>
		 		<th field="totime" width="150" align="center">到点时间</th>
			</tr>
		</thead>
	 <thead>
	 	<tr>
	 		<th field="ecprice" width="100" align="center">经济舱票价</th>
	 		<th field="fcprice" width="100" align="center">头等舱票价 </th>
	 		<th field="ectickettotal" width="100" align="center">经济舱总票数</th>
	 		<th field="fctickettotal" width="100" align="center">头等舱总票数</th>
	 		<th field="ecticketremain" width="100" align="center">经济舱剩余票数</th>
	 		<th field="fcticketremain" width="100" align="center">头等舱剩余票数</th>
			<th field="aircraftid" width="100" align="center"  <%--hidden="true"--%> <%--formatter="formatAircraftId"--%>>使用客机ID</th>
           <th field="aircraftname" width="100" align="center" <%--formatter="formatAircraftName"--%>>使用客机</th>
	 	</tr>
	 </thead>
	</table>
	<div id="tb">
		<div>
			<a href="javascript:openFlightAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openFlightModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteFlight()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
		<div>
			&nbsp;航班名称：<input type="text" id="s_flightName"  style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			&nbsp;出发地点：<input type="text" id="s_fromCity"  style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			&nbsp;到达地点：<input type="text" id="s_toCity"  style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			&nbsp;出发日期：<input type="text" id="s_fromTime" name="s_fromTime" class="easyui-datebox" style="width: 100px" onkeydown="if(event.keyCode==13) searchFlight()"/>
			<a href="javascript:searchFlight()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 700px;height:350px;padding: 10px 20px"
	  closed="true" buttons="#dlg-buttons">
	 	<form id="fm" method="post">
	 		<table cellspacing="8px">
	 			<tr>
	 				<td>航班名称：</td>
	 				<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>航班类型：</td>
	 				<td>
	 					<select class="easyui-combobox" id="flightType" name="flighttype" style="width: 154px;" editable="false" panelHeight="auto">
	 						<option value="">请选择性别</option>
	 						<option value="国内航班">国内航班</option>
	 						<option value="国际航班">国际航班</option>
	 					</select>
	 				</td>
	 			</tr>
	 			<tr>
	 				<td>出发地点：</td>
	 				<td><input type="text" id="fromCity" name="fromcity" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>出发时间：</td>
	 				<td><input type="text" id="fromTime" name="fromTime"  class="easyui-datetimebox"  required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>到达地点：</td>
	 				<td><input type="text" id="toCity" name="tocity" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>到达时间：</td>
	 				<td><input type="text" id="toTime" name="toTime"  class="easyui-datetimebox"  required="true"/></td>
	 			</tr>
	 			<tr>
	 				<td>经济舱票价：</td>
	 				<td><input type="text" id="ecPrice" name="ecprice" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>(经济舱)座位数：</td>
					<td><input type="text" id="ecTicketTotal" name="ectickettotal" class="easyui-validatebox" required="true"/></td>
	 				<%--<td><input type="text" id="ecTicketTotal" name="ectickettotal" class="easyui-numberbox" required="true"/></td>--%>
	 			</tr>
	 			<tr>
	 				<td>头等舱票价：</td>
	 				<td><input type="text" id="fcPrice" name="fcprice" class="easyui-validatebox" required="true"/></td>
	 				<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	 				<td>(头等舱)座位数：</td>
					<td><input type="text" id="fcTicketTotal" name="fctickettotal" class="easyui-validatebox" required="true"/></td>
	 				<%--<td><input type="text" id="fcTicketTotal" name="fctickettotal" class="easyui-numberbox" required="true"/></td>--%>
	 			</tr>
	 			<tr>
	 				<td>使用客机：</td>
	 				<td colspan="4">
	 				    <input class="easyui-combobox" id="aircraft" name="aircraftid" data-options="panelHeight:'auto',editable:false,valueField:'id',textField:'name',url:'/MavenDemo/aircraft/comboList'"/>
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveFlight()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeFlightDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>