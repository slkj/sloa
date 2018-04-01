<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="pop_cont">
		<div class="pop_cont_input" style="padding: 0px">
			<form id="postForm" metdod="post">
				<table class="grid" style="width: 100%">
					<tr>
						<th width="100px">类型：</th>
						<td align="left" style="width: 200px"><label><input
								name="type" type="radio" value="0" checked="checked" />新装</label> <label><input
								name="type" type="radio" value="1" />维修</label><label><input
								name="type" type="radio" value="2" />转网</label></td>
						<th width="100px">派检时间：</th>
						<td><input class="easyui-datetimebox" name="repairTime"
							style="width: 200px;" editable="false"
							data-options="required:true" /></td>
					</tr>
					<tr>
						<th width="100px">车牌号：</th>
						<td><input name="carNumber" id="carNumberCombx"
							style="width: 200px" /></td>
						<th>设备ID：</th>
						<td><input name="deviceId" id="deviceId"
							class="easyui-textbox" data-options="required:true" type="text"
							style="width: 200px"></td>
					</tr>
					<tr>
						<th>业户姓名：</th>
						<td><input name="owner" id="owner" class="easyui-textbox"
							type="text" style="width: 200px"></td>
						<th>SIM卡号：</th>
						<td><input name="sim" id="sim" class="easyui-textbox"
							type="text" data-options="required:true" style="width: 200px"></td>
					</tr>
					<tr>
						<th>联系电话：</th>
						<td colspan="3" width="300px"><input name="telephone"
							id="telephone" class="easyui-textbox"
							data-options="required:true"
							style="width: 94%; height: 27px; font-size: 14px; resize: none;"
							rows="2"></td>
					</tr>
					<tr>
						<th>报修原因：</th>
						<td colspan="3"><textarea id="causes" name="causes"
								style="width: 93%; font-size: 14px; resize: none;" rows="2"></textarea></td>
					</tr>
					<tr>
						<th>收费金额：</th>
						<td><input name="contact" id="contact"
							class="easyui-numberbox" type="text" style="width: 190px">元</td>
						<th>平台状态：</th>
						<td><select class="easyui-combobox" name="ptstate"
							style="width: 200px" style="width: 200px"
							data-options="required:'true'" editable="false">
								<option value="0">定位</option>
								<option value="1">不定位</option>
								<option value="2">服务到期</option>
						</select></td>
					</tr>
					<tr>
						<th>维修人员：</th>
						<td><input name="personnel" id="peCombx"
							class="easyui-textbox" data-options="required:true"
							style="width: 200px"></td>
						<th>联系电话：</th>
						<td><input name="personnelPhone" id="personnelPhone"
							data-options="required:true" class="easyui-textbox" type="text"
							style="width: 200px"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>