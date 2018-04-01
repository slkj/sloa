<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>交费审核</title>
<%@ include file="/common/taglibs.jsp"%>
</head>
<body>
	<form id="payForm" metdod="post" action="">
		<input id="orderNumber" name="orderNumber" type="hidden" />
		<table id="grid" style="width: 100%; padding: 10px">
			<tr>
				<td style="width:30%">支付状态 ：</td>
				<td><select id="state" name="state" class="easyui-combobox" style="width: 70%" editable="false">
						<option value="0">待处理</option>
						<option value="1">已支付</option>
				</select></td>
			</tr>
			<tr>
				<td style="width: 30%">已支付金额 ：</td>
				<td><input id="price" name="price" class="easyui-textbox" style="width: 50%" />&nbsp;元</td>
			</tr>
		</table>
	</form>
</body>
</html>