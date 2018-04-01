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
		<input type="hidden" id="simid"  name="id"/>

		<table id="listGrid" style="width: 100%; padding: 15px">
			<tr>
				<td style="width: 20%">出库状态 ：</td>
				<td> 
					<select id="s_ustate" name="ustate"
							class="easyui-combobox" style="width: 75%;" editable="false">
							<option value="1">已出库</option>
							<option value="0">未出库</option>
							<option value="2">已回收</option>
						</select>	
				</td>
			</tr>
			<tr>
				<td>使用状态 ：</td>
				<td><select class="easyui-combobox" id="s_state" name="state" panelheight="auto"
							style="width: 75%">
							<option value="1">已用</option>
							<option value="0">未用</option>
						</select></td>
			</tr>
			<tr>
				<td>SIM号码 ：</td>
				<td><input id="s_telnum" name="telnum" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>领 用 人 ：</td>
				<td><input id="s_lyr" name="lyr" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>领用部门 ：</td>
				<td><input id="s_department" name="department" style="width: 75%" /></td>
			</tr>
			<tr>
				<td>领用时间 ：</td>
				<td><input id="s_outtime" name="outtime" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>操 作 人 ：</td>
				<td><input id="s_lrr" name="lrr" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注 ：</td>
				<td><input class="easyui-textbox" data-options="multiline:true" id="s_remark" name="remark"
						style="height: 80px; width: 85%;"></input></td>
			</tr>
		</table>
	</form>
</body>
</html>