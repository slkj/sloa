<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="postForm" metdod="post">
		<input id="fees_id" name="id" type="hidden" />
		<table class="grid" style="width: 100%">
			<tr>
				<th width="80px">车牌号:</th>
				<td width="260px">
					<input id="carNumberCombx" name="carNumber" class="easyui-textbox" style="width: 250px" />
				</td>
			</tr>
			<tr>
				<th width="80px">所属企业:</th>
				<td width="260px">
					<input id="carOwnerText" name="companyName" class="easyui-textbox" style="width: 250px" />
				</td>
			</tr>
			<tr>
				<th width="80px">车主名称:</th>
				<td width="260px">
					<input id="contactsText" class="easyui-textbox" name="owner" style="width: 250px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<th width="80px">联系电话:</th>
				<td width="260px">
					<input id="contactsTelText" class="easyui-textbox" name="ownerTel" style="width: 250px" data-options="required:true" />
				</td>
			</tr>
			<tr>
				<th>收费类型</th>
				<td>
					<!-- 					<span style="color: red;">*新装需要输入设备号、SIM卡号、证明编号;续费需要输入证明编号；维修写明维修内容</span><br> -->
					<label>
						<input name="purpose" type="radio" value="0" checked="checked" />
						新装
					</label>
					<label>
						<input name="purpose" type="radio" value="1" />
						续费
					</label>
					<label>
						<input name="purpose" type="radio" value="2" />
						维修
					</label>

				</td>
			</tr>
			<tr>
				<th>收费金额</th>
				<td>
					<input name="fees" class="easyui-textbox" style="width: 250px;" data-options="required:true"  >
				</td>
			</tr>
			<tr>
				<th>服务期限:</th>
				<td>
					<span style="color: red;">*新装、转网车辆需要填写服务器期限。</span>
					<br>
					<input type="text" id="startTimeText" name="startTime" class="Wdate" style="width: 90px" onFocus="var endDate=$dp.$('endTimeText');WdatePicker({onpicked:function(){endTime.focus();},dateFmt:'yyyy-MM',maxDate:'#F{$dp.$D(\'endTimeText\')}'})" />
					-
					<input name="endTime" type="text" id="endTimeText" class="Wdate" style="width: 90px" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTimeText\')}',dateFmt:'yyyy-MM'})" />
				</td>
			</tr>
			<tr>
				<th>收费人员:</th>
				<td>
					<input name="sfry" class="easyui-textbox" style="width: 250px;" data-options="required:true" value="${sessionUser.realname }">
				</td>
			</tr>
			<tr>
				<th>收费时间:</th>
				<td>
					<input id="sfriqi" name="sfriqi" class="Wdate" type="text" style="width: 150px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,readOnly:true})" />
				</td>
			</tr>
			<tr>
				<th>备注:</th>
				<td>
					<input name="remark" " class="easyui-textbox" style="width: 100%" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>