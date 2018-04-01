<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="pop_cont">
		<div class="pop_cont_input">
			<form id="postForm" metdod="post">
				<input id="fees_id" name="id" type="hidden" />
				<table class="grid" style="width: 100%; padding: 10px">
					<tr>
						<th width="100px">实收人：</th>
						<td><input id="payee" name="payee" class="easyui-textbox" style="width: 200px;"
							data-options="required:true" value="${sessionUser.realname }"></td>
					</tr>
					<tr>
						<th width="100px">实收时间：</th>
						<td><input id="sriqi" name="sriqi" class="Wdate" type="text" style="width: 200px;"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /></td>
					</tr>

					<tr>
						<th width="100px">实收金额：</th>
						<td><input id="amounts" name="amounts" class="easyui-numberbox" style="width: 200px"
							data-options="min:0,precision:0,required:true" />元</td>
					</tr>
				</table>

			</form>
		</div>
	</div>
</body>
</html>