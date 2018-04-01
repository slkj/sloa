<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="postForm" metdod="post">
		<input name="cpys" id="cpys" type="hidden">
		<table class="grid" style="width: 100%">
			<tr>
				<th colspan="4" style="text-align: center;color: red;">1、选择同步平台；2、登录平台；3、选择需要同步的客户和分组信息</th>
			</tr>
			<tr>
				<th width="80px">平台配置</th>
				<td colspan="3"><select id="serverId" class="easyui-combobox" name="serverId" style="width: 300px;">
						<option value="10376">危客车、其他（hbslkj.com）</option>
						<option value="11420">普货（219.148.86.152）</option>
						<option value="11292">渣土车（219.148.86.147）</option>
				</select></td>
			</tr>
			<tr>
				<th width="80px">用户名</th>
				<td><input id="userName" name="userName" class="easyui-textbox" style="width: 100%;" ></td>
				<th width="80px">密码</th>
				<td><input id="userPwd" name="userPwd" class="easyui-textbox" type="password" style="width: 100%;" ></td>
			</tr>
			<tr>
				<td colspan="4" style="text-align: center;">
				
				<a id="login_ex" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="width: 80px">登陆</a> 
				<span id="scuText" style="color: red;"></span>
				<input id="loginState"  type="hidden">
				</td>
			</tr>
			<tr>
				<th width="80px">车牌号</th>
				<td><input id="carName" name="carName" class="easyui-textbox" style="width: 100%;" editable="false" data-options="required:true"></td>
				<th>车机类型</th>
				<td><select id="mobileId" class="easyui-combobox" name="mobileId" style="width: 100%;" data-options="required:true">
						<option value=""></option>
						<option value="28">天禾</option>
						<option value="105">交通部JT808</option>
				</select>
			</tr>
			<tr>
				<th width="80px">设备号</th>
				<td><input id="gprs" name="gprs" class="easyui-textbox" style="width: 100%;" editable="false" data-options="required:true"></td>
				<th width="80px">SIM号码</th>
				<td><input id="sim" name="sim" class="easyui-textbox" style="width: 100%;" editable="false" data-options="required:true"></td>
			</tr>
			<tr>
				<th>客户</th>
				<td><input class="easyui-combobox" id="complb" name="clientID" style="width: 100%;" data-options="valueField:'id', textField:'compName', panelHeight:'200',required:true"></td>
				<th>分组</th>
				<td><input class="easyui-combobox" id="grouplb" name="goupListPage" style="width: 100%;" data-options="valueField:'id', textField:'name', panelHeight:'200',required:true"></td>
			</tr>
		</table>
	</form>
</body>
</html>