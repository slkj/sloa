<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
<script type="text/javascript" src="../js/AjaxButtion.js"></script>
</head>
<body> 
	<form id="editform" metdod="post"  action="">
		<input type="hidden" id="devicesid"  name="id"/>

		<table id="listGrid" style="width: 100%; padding: 15px">
			<tr>
				<td style="width: 20%">箱&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号 ：</td>
				<td><input id="d_packBm" name="packBm" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>出库状态 ：</td>
				<td> 
					<select id="d_state" name="state"
							class="easyui-combobox" style="width: 75%;" editable="false">
							<option value="1">已出库</option>
							<option value="2">未出库</option>
							<option value="3">退回</option>
						</select>	
				</td>
			</tr>
			<tr>
				<td>使用状态 ：</td>
				<td><select class="easyui-combobox" id="d_ustate" name="ustate" panelheight="auto"
							style="width: 75%">
							<option value="1">已使用</option>
							<option value="0">未使用</option>
						</select></td>
			</tr>
			<tr>
				<td>设备编号 ：</td>
				<td><input id="d_listnum" name="listnum"
					class="easyui-textbox" style="width: 75%" /></td>
			</tr>
			<tr>
				<td>默认卡号 ：</td>
				<td><input id="d_simNumber" name="simNumber"
					class="easyui-textbox" style="width: 75%" /></td>
			</tr>
			<tr>
				<td>库存网点 ：</td>
				<td><input id="d_department" name="department" style="width: 75%" /></td>
			</tr>
			<tr>
				<td>测试状态 ：</td>
				<td><select class="easyui-combobox" id="d_test" name="test" panelheight="auto"
							style="width: 75%">
							<option value="1">已检测</option>
							<option value="0">未检测</option>
						</select></td>
			</tr>
			<tr>
				<td>用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;途 ：</td>
				<td><input id="d_ustype" name="ustype" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>领 用 人 ：</td>
				<td><input id="d_lyr" name="lyr" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr> 
			<tr>
				<td>领用时间 ：</td>
				<td><input id="d_lytime" name="lytime" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr> 
			<tr>
				<td valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注 ：</td>
				<td><input class="easyui-textbox" data-options="multiline:true" id="d_remark" name="remark"
						style="height: 80px; width: 85%;"></input></td>
			</tr>
		</table>
	</form>
</body>
</html>