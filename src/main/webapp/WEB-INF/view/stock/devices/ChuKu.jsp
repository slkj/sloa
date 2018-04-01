<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="ckform" metdod="post">
		<input type="hidden" id="site" value="${sessionUser.departcode }" />
		<input type="hidden" id="lyrid" />

		<table style="width: 100%; padding: 10px">
			<tr>
				<td style="width: 20%">所在部门 ：</td>
				<td><input id="ck_department" name="department"
					class="easyui-textbox" style="width: 70%"
					data-options="prompt:'---请选择部门---'" /></td>
			</tr>
			<tr>
				<td>领 用 人&nbsp;&nbsp;：</td>
				<td><input id="peCombx" name="lyr" class="easyui-textbox"
					style="width: 70%" /></td>
			</tr>
			<tr>
				<td>发货时间 ：</td>
				<td><input id="ck_lytime" name="lytime" class="Wdate"
					type="text"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})"
					style="width: 70%" /></td>
			</tr>
			<tr>
				<td>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注 ：</td>
				<td><textarea class="textarea" id="remark" name="remark"
						style="height: 50px; width: 80%;"></textarea></td>
			</tr>
		</table>
	</form>
</body>
</html>