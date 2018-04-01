<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="postForm" metdod="post">
		<input id="fees_id" name="id" type="hidden" /> <input id="proverId" name="proverId" type="hidden" />
		<table class="grid" style="width: 100%">
			<tr>
				<th width="80px">车牌号:</th>
				<td width="260px"><input id="carNumberCombx" name="carNumber" class="easyui-textbox" style="width: 250px"  /></td>
				<th width="80px">所属企业:</th>
				<td width="260px"><input id="carOwnerText" name="owner" class="easyui-textbox" style="width: 250px"  /></td>
			</tr>
			<tr>
				<th width="80px">车主名称:</th>
				<td width="260px"><input id="contactsText" class="easyui-textbox" style="width: 250px" /></td>
				<th width="80px">联系电话:</th>
				<td width="260px"><input id="contactsTelText" class="easyui-textbox" style="width: 250px"   /></td>
			</tr>
			<tr>
				<th>收费类型</th>
				<td colspan="3"><label><input name="purpose" type="radio" value="0" checked="checked" />新装</label> <label><input name="purpose" type="radio" value="1" />续费</label> <label><input
						name="purpose" type="radio" value="2" />维修</label>
					<span style="color: red;">*新装需要输入设备号、SIM卡号、证明编号;续费需要输入证明编号；维修写明维修内容</span>		
				</td>
			</tr>
			<tr>
				<td colspan="4" style="width: 100%; padding: 5; margin: 0">
					<div style="width: 100%">
						<table class="smallGrid" style="width: 100%;">
							<tr>
								<th width="20%" style="text-align: center;">项目</th>
								<th width="60%" style="text-align: center;">明细</th>
								<th width="20%" style="text-align: center;">价格</th>
							</tr>
							<tr>
								<th width="20%" style="text-align: center;">证明编号：</th>
								<td width="60%"><input id="proveNumber" name="number" class="easyui-textbox" style="width: 100%" data-options="prompt: '证明编号'" /></td>
								<td width="20%"><input id="colAmounts" name="colAmounts" type="text" style="width: 80px" class="easyui-numberbox" data-options="min:0,precision:0" />元</td>
							</tr>
							<tr>
								<th width="20%" style="text-align: center;">设备ID：</th>
								<td width="60%"><input id="deviceNumber" name="deviceNumber" class="easyui-textbox" style="width: 100%" data-options="prompt: '设备ID'" /></td>
								<td width="20%"><input id="devicePice" name="devicePice" type="text" style="width: 80px" class="easyui-numberbox" data-options="min:0,precision:0" />元</td>
							</tr>
							<tr>
								<th width="20%" style="text-align: center;">SIM卡号：</th>
								<td width="60%"><input id="simNumber" name="simNumber" class="easyui-textbox" style="width: 100%" data-options="prompt: 'SIM卡号'" /></td>
								<td width="20%"><input id="simPice" name="simPice" type="text" style="width: 80px" class="easyui-numberbox" data-options="min:0,precision:0" />元</td>
							</tr>
							<tr>
								<th width="20%" style="text-align: center;">维修费：</th>
								<td width="60%"><input id="feesText" name="upkeep" " class="easyui-textbox" style="width: 100%" data-options="prompt: '收费明细'" /></td>
								<td width="20%"><input id="feesPice" name="upkeepPice" type="text" style="width: 80px" class="easyui-numberbox" data-options="min:0,precision:0" />元</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
			<tr>
				<th>服务期限:</th>
				<td colspan="3">
				<input type="text" id="startTimeText" name="startTime" class="Wdate" style="width: 90px"
					onFocus="var endDate=$dp.$('endTimeText');WdatePicker({onpicked:function(){endTime.focus();},dateFmt:'yyyy-MM',maxDate:'#F{$dp.$D(\'endTimeText\')}'})" /> 
					- <input name="endTime" type="text"
					id="endTimeText" class="Wdate" style="width: 90px" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTimeText\')}',dateFmt:'yyyy-MM'})" />
					
					 <span style="color: red;">*新装、转网车辆需要填写服务器期限。</span></td>
			</tr>
			<tr>
				<th>收费人员:</th>
				<td><input id="agent" name="agent" class="easyui-textbox" style="width: 250px;" data-options="required:true" value="${sessionUser.realname }"></td>
				<th>收费时间:</th>
				<td><input id="riqi" name="riqi" class="Wdate" type="text" style="width: 150px;" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,readOnly:true})" /></td>
			</tr>
			<tr>
				<th>备注:</th>
				<td colspan="3"><input name="remark" " class="easyui-textbox" style="width: 100%" /></td>
			</tr>
		</table>
	</form>
</body>
</html>