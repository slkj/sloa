<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增公司信息</title>
</head>
<body>
	<form id="comForm">
		<input id="id" name="id" type="hidden" />
		<table class="grid">
			<tr>
				<th style="width: 80px">车牌号：</th>
				<td><input id="carNumber" name="carNumber" class="easyui-textbox"
					data-options="required:'true'" style="width: 250px"></td>
			</tr>
			<tr>
				<th >公司名称：</th>
				<td><input id="companyId" name="companyId" class="easyui-textbox"
					data-options="required:'true'" style="width: 250px"></td>
			</tr>
			<tr>

				<th>设备号：</th>
				<td><input id="deviceNum" name="deviceNum" class="easyui-textbox" style="width: 250px" /></td>
			</tr>
			<tr>
				<th>驾驶证号：</th>
				<td><input name="drivingNo" class="easyui-textbox" style="width: 250px"></td>

			</tr>
			<tr>
				<th>司机卡号：</th>
				<td><input name="driverNo" class="easyui-textbox" data-options="required:'true'"
					style="width: 250px"></td>
			</tr>
			<tr>
				<th>司机姓名：</th>
				<td><input name="driverName" class="easyui-textbox" style="width: 250px"> <a
					class="imgInc"></a></td>
			</tr>

			<tr>
				<th>制作日期：</th>
				<td><input name="madeTime" class="Wdate" type="text" style="width: 250px;"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})"></td>
			</tr>
			<tr>
				<th>领卡人：</th>
				<td><input name="collar" class="easyui-textbox" style="width: 250px"> <a
					class="imgInc"></a></td>

			</tr>
			<tr>
				<th>备注：</th>
				<td><input class="easyui-textbox" name="remark" data-options="multiline:true"
					style="width: 250px;height: 40px;"></input></td>
			</tr>
		</table>
	</form>
</body>
</html>