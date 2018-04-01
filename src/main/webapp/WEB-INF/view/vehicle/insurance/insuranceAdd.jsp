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
				<th>保单号：</th>
				<td><input type="text" name="policy" class="easyui-textbox" style="width: 200px" data-options="required:true" /></td>
			</tr>
			<tr>
				<th>投保类型:</th>
				<td><input id="insuranceType" name="insuranceType" class="easyui-textbox" style="width: 200px;"
						data-options="required:true" /></td>
			</tr>
			<tr>
				<th>费用(元):</th>
				<td><input name="feiyong" class="easyui-numberbox" data-options="required:true,precision:2"
						style="width: 200px;" /></td>
			</tr>
			<tr>
				<th>承保单位:</th>
				<td><input id="insuranceCompany" name="insuranceCompany" class="easyui-textbox" style="width: 200px;"
						data-options="required:true" /></td>
			</tr>

			<tr>
				<th>投保日期:</th>
				<td><input id="riqi" class="easyui-datebox" name="riqi" editable="false" style="width: 200px"
						data-options="required:true"></td>
			</tr>
			<tr>
				<th>核保人:</th>
				<td><input name="checkMan" style="width: 200px;" class="easyui-textbox" /></td>
			</tr>
			<tr>
				<th>制单人:</th>
				<td><input name="makeMan" style="width: 200px;" class="easyui-textbox" /></td>
			</tr>
			<tr>
				<th>保险期间:</th>
				<td>自<input id="startTime" class="easyui-datebox" name="startTime" editable="false" style="width: 100px"
						data-options="required:true"> 至 <input id="endTime" class="easyui-datebox" name="endTime" editable="false"
						style="width: 100px" data-options="required:true">
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