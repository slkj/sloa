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
		<input name="state" value="0" type="hidden" /> <input name="ustate"
			value="0" type="hidden" /> <input type="hidden" name="department"
			value="${userSession.departcode }" />

		<table style="width: 100%; padding: 10px">
			<tr>
				<td style="width: 20%">SIM卡号 ：</td>
				<td><input name="telnum" class="easyui-textbox"
					style="width: 70%" /></td>
			</tr>
			<tr>
				<td>运 营 商 ：</td>
				<td><select class="easyui-combobox" name="cardType"
					style="width: 70%" data-options="required:'true'" editable="false">
						<option value="移动">移动</option>
						<option value="联通">联通</option>
				</select></td>
			</tr>
			<tr>
				<td>入库时间 ：</td>
				<td><input id="intime" name="intime" class="Wdate" type="text"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})"
					style="width: 70%" /></td>
			</tr>
		</table>
	</form>
</body>
</html>