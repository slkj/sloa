<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="zmPostForm" metdod="post">
		<input name="uid" type="hidden" value="${sessionUser.id }" /> <input
			name="department" type="hidden" value="${sessionUser.departcode }" />

		<table style="width: 100%; padding: 10px">
			<tr>
				<td></td>
				<td><label><input name="addType" type="radio" value="0"
						checked="checked" onclick="closedDiv()" />单个加</label> <label><input
						name="addType" type="radio" value="1" onclick="showDiv()" />批量加</label></td>
			</tr>
			<tr>
				<td style="width: 20%">使用类型 ：</td>
				<td><input id="ustypeWin" name="ustype" style="width: 70%" /></td>
			</tr>
			<tr>
				<td>入网编号 ：</td>
				<td><input name="listNo" class="easyui-textbox"
					style="width: 70%" data-options="required:'true'"></td>
			</tr>
			<tr id="listdiv" style="display: none;">
				<td></td>
				<td>（不包括后四位，例如"CX201005031234"请输入"CX20100503"） <br /> <input
					name="listnum_begin" class="easyui-textbox" style="width: 120px">
					- <input name="listnum_end" class="easyui-textbox"
					style="width: 120px"></td>
			</tr>
		</table>
	</form>
</body>
</html>