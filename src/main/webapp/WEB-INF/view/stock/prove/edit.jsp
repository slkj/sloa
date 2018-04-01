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
		<input type="hidden" id="proveid"  name="id"/>

		<table id="listGrid" style="width: 100%; padding: 15px">
			<tr>
				<td style="width: 20%">使用状态 ：</td>
				<td><select class="easyui-combobox" id="p_ustate" name="ustate" panelheight="auto"
							style="width: 75%">
							<option value="1">已使用</option>
							<option value="0">未使用</option>
							<option value="3">已作废</option>
						</select></td>
			</tr>
			<tr>
				<td>类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型 ：</td>
				<td><input id="p_ustype" name="ustype" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>编&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号 ：</td>
				<td><input id="p_number" name="number" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>出库状态 ：</td>
				<td> 
					<select id="p_state" name="state"
							class="easyui-combobox" style="width: 75%;" editable="false">
							<option value="1">已出库</option>
							<option value="0">未出库</option>
							<option value="2">已回收</option>
						</select>	
				</td>
			</tr>
			<tr>
				<td>出库日期 ：</td>
				<td><input id="p_usriqi" name="usriqi" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
			<tr>
				<td>领用部门 ：</td>
				<td><input id="p_department" name="department"  style="width: 75%" /></td>
			</tr>
			<tr>
				<td>领 用 人 ：</td>
				<td><input id="p_usman" name="usman"
					class="easyui-textbox" style="width: 75%" /></td>
			</tr>
			<tr>
				<td>用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;途 ：</td>
				<td><select id="p_purpose" name="purpose"
							class="easyui-combobox" style="width: 75%;" editable="false">
							<option value="1">续费</option>
							<option value="0">新装</option> 
						</select></td>
			</tr>
			<tr>
				<td>车 牌 号 ：</td>
				<td><input id="p_carNumber" name="carNumber"
					class="easyui-textbox" style="width: 75%" /></td>
			</tr>
			<tr>
				<td valign="top">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注 ：</td>
				<td><input class="easyui-textbox" data-options="multiline:true" id="p_remark" name="remark"
						style="height: 80px; width: 85%;"></input></td>
			</tr>
			<tr>
				<td>是否收款 ：</td>
				<td><select id="p_fees" name="fees"
							class="easyui-combobox" style="width: 75%;" editable="false">
							<option value="">未收款</option>
							<option value="1">已收款</option> 
						</select></td>
			</tr>
			<tr>
				<td>收 款 人 ：</td>
				<td><input id="p_payee" name="payee" class="easyui-textbox"
					style="width: 75%" /></td>
			</tr>
		</table>
	</form>
</body>
</html>