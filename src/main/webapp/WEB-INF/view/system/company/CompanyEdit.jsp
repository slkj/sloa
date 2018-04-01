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
				<th style="width: 120px">公司名称：</th>
				<td colspan="3"><input name="compName" class="easyui-textbox" data-options="required:'true'" style="width: 330px"></td>
			</tr>
			<tr>

				<th>法人：</th>
				<td><input name="corporate" class="easyui-textbox" style="width: 200px" /></td>
				<th>注册资金：</th>
				<td><input name="registeredCapital" class="easyui-numberbox" style="width: 160px">万元</td>

			</tr>
			<tr>
				<th>联系人：</th>
				<td><input name="contactMenber" class="easyui-textbox" data-options="required:'true'" style="width: 200px"></td>
				<th>组织机构代码：</th>
				<td><input name="organizationCode" class="easyui-textbox" style="width: 160px"> <a class="imgInc"></a></td>
			</tr>
			<tr>
				<th>联系电话：</th>
				<td><input name="contactWay" class="easyui-textbox" data-options="required:'true'" style="width: 200px"></td>
				<th>营业执照号：</th>
				<td><input name="businessLicense" class="easyui-textbox" style="width: 160px"> <a class="imgInc"></a></td>
			</tr>
			<tr>
				<th>电话：</th>
				<td><input name="mobile" class="easyui-textbox" style="width: 200px"></td>
				<th>许可证号：</th>
				<td><input name="xkz" class="easyui-textbox" style="width: 160px"> <a class="imgInc"></a></td>

			</tr>
			<tr>
				<th>Email：</th>
				<td><input name="email" class="easyui-textbox" style="width: 200px"></td>
				<th>QQ号码：</th>
				<td><input name="qq" class="easyui-numberbox" style="width: 160px"></td>
			</tr>
			<tr>
				<th>公司地址：</th>
				<td colspan="3"><input name="compAddress" class="easyui-textbox" style="width: 100%"></td>
			</tr>
			<tr>
				<th>简介(经营范围)</th>
				<td colspan="3"><input name="introduction" class="easyui-textbox" data-options="multiline:true" style="height: 60px; width: 100%"></input></td>
			</tr>
			<tr>
				<th>备注：</th>
				<td colspan="3"><input class="easyui-textbox" name="remark" data-options="multiline:true" style="width: 100%"></input></td>
			</tr>
		</table>
	</form>
</body>
</html>