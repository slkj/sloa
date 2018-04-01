<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="postForm" metdod="post">
		<input id="id" name="id" type="hidden" /> 
		<input id="vId" name="vId" type="hidden" /> 
		<table class="grid" style="width: 100%">
			<tr>
				<th width="100px">车牌号：</th>
				<td><input id="carNumber" name="vehicleNumber" class="easyui-textbox" style="width: 200px" /></td>
			</tr>
			<tr>
				<th>证件类型:</th>
				<td>
					<select name="licenseType"
					class="easyui-combobox" style="width: 200px;" editable="false"
					data-options="required:true">
						<option selected="selected" value="资格证">资格证</option>
						<option value="营运证">营运证</option>
						<option value="驾驶证">驾驶证</option>
						<option value="身份证">身份证</option>
						<option value="行驶证">行驶证</option>
				</select></td>
			</tr>
			<tr>
				<th>证件号：</th>
				<td><input type="text" name="licenseNo" class="easyui-textbox" style="width: 200px" data-options="required:true" /></td>
			</tr>
			
			<tr>
				<th>办理日期:</th>
				<td><input id="riqi" class="easyui-datebox" name="riqi" editable="false" style="width: 200px"
						data-options="required:true"></td>
			</tr>
			
			<tr>
				<th>到期时间:</th>
				<td> <input id="endTime" class="easyui-datebox" name="endTime" editable="false"
						style="width: 200px" data-options="required:true">
				</td>
			</tr>
			<tr>
				<th>备注:</th>
				<td><textarea id="remark" name="remark" style="width: 60%;" rows="5"></textarea></td>
			</tr>
		</table>
	</form>
</body>
</html>