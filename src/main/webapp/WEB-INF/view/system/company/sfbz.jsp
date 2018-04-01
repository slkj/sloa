<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>收费标准</title>
</head>
<body>
	<form id="comForm">
		<input id="id" name="id" type="hidden" />
		<table class="grid">
			<tr>
				<th style="width: 120px">公司名称：</th>
				<td><input  name="compName" class="easyui-textbox"   style="width: 100%;" readonly="readonly"></td>
			</tr>
			<tr>
				<th>收费标准：</th>
				<td><input name="sfbz" class="easyui-textbox" data-options="required:'true'" style="width: 100%">元</td>
			</tr>

		</table>
	</form>
</body>
</html>