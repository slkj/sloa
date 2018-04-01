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
						<th width="100px">车牌号：</th>
						<td><input name="carNumber" id="carNumberCombx"
							style="width: 200px" /></td>
						<th width="100px">车辆类型：</th>
						<td><input name="cartype" id="cartype" class="easyui-textbox"
							data-options="required:true" type="text" style="width: 200px"></td>
					</tr>
					<tr>
						<th>联系人：</th>
						<td><input name="carman" id="carman" class="easyui-textbox"
							data-options="required:true" type="text" style="width: 200px"></td>
						<th>联系电话：</th>
						<td><input name="carphone" id="carphone"
							class="easyui-textbox" type="text" data-options="required:true"
							style="width: 200px"></td>
					</tr>
					<tr>
						<th>所属公司：</th>
						<td><input name="carcompany" id="carcompany1"
							class="easyui-textbox" type="text" style="width: 200px"></td>
						<th></th>
						<td></td>
					</tr>
					<tr>
						<th>回访电话：</th>
						<td><input name="fromphone" id="fromphone"
							class="easyui-textbox" data-options="required:true" type="text"
							style="width: 200px"></td>
						<th>回访时间：</th>
						<td><input name="calltime" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							style="width: 200px" /></td>
					</tr>
					<tr>
						<th>回访原因：</th>
						<td colspan="3" align="left"><textarea id="causes"
								name="causes" style="width: 90%; font-size: 14px; resize: none;"
								rows="2"></textarea></td>
					</tr>

					<tr>
						<th>回访员：</th>
						<td><input name="callman" id="callman" class="easyui-textbox"
							data-options="required:true" style="width: 200px"
							value="${sessionUser.realname }"></td>
						<th>接听状态：</th>
						<td><select class="easyui-combobox" name="carstate"
							style="width: 200px" data-options="required:'true'"
							editable="false">
								<option value="0">正常回访</option>
								<option value="1">未接通</option>
								<option value="2">空号</option>
						</select></td>
					</tr>
					<tr>
						<th>反馈意见：</th>
						<td colspan="3" align="left"><textarea id="advice"
								name="advice" style="width: 90%; font-size: 14px; resize: none;"
								rows="2"></textarea></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>