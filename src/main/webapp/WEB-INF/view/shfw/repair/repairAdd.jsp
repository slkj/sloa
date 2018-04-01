<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>派工登记</title>
</head>
<body>
	<div class="pop_cont">
		<div class="pop_cont_input" style="padding: 0px">
			<form id="postForm" metdod="post">
			<input id="id" name="id" type="hidden" />
				<input id="department" name="department" type="hidden"
					value="${userSession.departcode }" /> 
					<input id="carId" name="carId" type="hidden" />
					<input id="guy" name="guy" type="hidden" />
				<table class="grid" style="width: 100%">
					<tr>
						<th>维修单号：</th>
						<td><input name="repairNum" id="repairNum"
							class="easyui-textbox" type="text" style="width: 200px"></td>
						<th>预收费用：</th>
						<td><input name="cost" id="cost" class="easyui-numberbox"
							 style="width: 190px">元</td>
					</tr>
					
					<tr>
						<th width="100px">车牌号：</th>
						<td><input name="carNumber" id="carNumber"
							class="easyui-textbox" style="width: 200px"></td>
						<th>维修时间：</th>
						<td><input name="wxTime" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							style="width: 200px" /></td>
					</tr>
					<tr>
						<th width="100px">维修人：</th>
						<td><input name="guyName" id="guyName" class="easyui-textbox"
							type="text" style="width: 200px" ></td>
						<th width="100px">联系方式：</th>
						<td><input name="contact" id="contact" class="easyui-textbox"
							type="text" style="width: 200px"<%--  value="${userSession.phone }" --%>></td>
					</tr>
					<tr>
						<th width="100px">原设备号：</th>
						<td><input name="equitment" id="olddevice"
							class="easyui-textbox" type="text" style="width: 200px"></td>
						<th width="100px">原卡号：</th>
						<td><input name="simNumber" id="oldsim"
							class="easyui-textbox" type="text" style="width: 200px"></td>
					</tr>			
					
					<tr>
						<th width="100px">现设备号：</th>
						<td><input name="equitment1" id="newdevice"
							class="easyui-textbox" type="text" style="width: 200px"></td>
						<th width="100px">现卡号：</th>
						<td><input name="simNumber1" id="newsim"
							class="easyui-textbox" type="text" style="width: 200px"></td>
					</tr>
					
					<tr>
						<th>维修地点：</th>
						<td colspan="3"><textarea id="site" name="site"
								style="width: 90%; font-size: 14px; resize: none;" rows="1"></textarea></td>
					</tr>
					<tr>
						<th>原因：</th>
						<td colspan="3"><textarea id="why" name="why"
								style="width: 90%; font-size: 14px; resize: none;" rows="2"></textarea></td>
					</tr>
					<tr>
						<th>维修结果：</th>
						<td colspan="3"><label> <input name="outcome" type="radio" value="1"/>已解决
			</label> <label><input name="outcome" type="radio" value="0" checked="checked" />未解决</label></textarea></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>