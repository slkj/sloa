<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="devPostForm" metdod="post">
		<input name="state" value="2" type="hidden" /> <input type="hidden"
			name="department" value="${sessionUser.departcode }" />
		<table style="width: 100%; padding: 10px">
			<tr>
				<td></td>
				<td><label><input name="addType" type="radio" value="0"
						checked="checked" onclick="closedDiv()" />单个加</label>&nbsp;&nbsp;&nbsp;<label><input
						name="addType" type="radio" value="1" onclick="showDiv()" />批量加</label></td>
			</tr>
			<tr id="listnum">
				<td style="width: 20%">设 备 I D ：</td>
				<td><input id="listnum" name="listnum" class="easyui-textbox"
					style="width: 70%" /></td>
			</tr>
			<tr id="listdiv">
				<td style="width: 20%;" valign="top">设 备 I D ：</td>
				<td><input id="listnum" name="listnum" class="easyui-textbox"
					style="width: 70%" /><br /> <span
					style="font-size: 12px; color: red;">
						（不包括后四位，例如"CX201005031234"请输入"CX20100503"）</span> <br /> <input
					name="listnum_begin" class="easyui-textbox" style="width: 120px;">
					- <input name="listnum_end" class="easyui-textbox"
					style="width: 120px"></td>
			</tr>
			<tr>
				<td>设备厂商 ：</td>
				<td><select class="easyui-combobox" name="firm"
					style="width: 50%" data-options="required:'true'" editable="false">
						<option value="博实结">博实结</option>
						<option value="华宝">华宝</option>
						<option value="首航">首航</option>
						<option value="神龙">神龙</option>
						<option value="星瑞达">星瑞达</option>
						<option value="神龙GPS">神龙GPS</option>
						<option value="佛山联星">佛山联星</option>
						<option value="鸿泉">鸿泉</option>
						<option value="中斗">中斗</option>
						<option value="赛格">赛格</option>
						<option value="航天无线">航天无线</option>
						<option value="超长待机">超长待机</option>
				</select></td>
			</tr>
			<tr>
				<td>厂牌型号 ：</td>
				<td><input name="model" class="easyui-textbox"
					style="width: 70%" /></td>
			</tr>
			<tr>
				<td>设备包装 ：</td>
				<td><label><input name="pack" type="radio" value="0"
						checked="checked" />全新</label>&nbsp;&nbsp;&nbsp;<label><input
						name="pack" type="radio" value="1" />返修</label></td>
			</tr>
			<tr>
				<td>入库时间 ：</td>
				<td><input id="rktime" name="rktime" class="Wdate" type="text"
					style="width: 70%"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})" /></td>
			</tr>
		</table>
	</form>
</body>
</html>