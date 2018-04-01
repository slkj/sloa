<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加来电信息</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!-- 获取系统当前时间 -->
<%
	SimpleDateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	String value = format.format(new Date());
%>
</head>
<body>
	<form id="devPostForm" metdod="post">
		<input id="id" name="id" type="hidden" />
		<input id="companyId" name="companyId" type="hidden" />
<!-- 		<input type="hidden" name="department" -->
<%-- 			value="${sessionUser.departcode }" /> --%>
		<table style="width: 100%; padding: 10px" >
			<tr>
				<td style="width: 25%">来电者姓名：</td>
				<td><input id="askName" name="askName" class="easyui-textbox"
					style="width: 80%" /></td>
			</tr>
			<tr>
				<td>来电号码 ：</td>
				<td><input id="number" name="number" class="easyui-textbox"
					style="width: 80%" /></td>
			</tr>
			<tr>
				<td>来电所属公司：</td>
				<td><input id="department" name="department"
					class="easyui-textbox" style="width: 80%" /></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>来电所属：</td> -->
<!-- 				<td><input id="companyName" name="companyName"  style="width: 80%" /></td> -->
<!-- 			</tr> -->
			<tr>
				<td>来电时间 ：</td>
				<td><input id="callTime" name="callTime"
					class="easyui-datetimebox" type="text" style="width: 80%"
					value="<%=value%>"
					onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
			</tr>
			<tr>
				<td valign="top">通话内容 ：</td>
				<td><select id="conversation" class="easyui-combobox"
					name=conversation data-options="multiple:true,multiline:true"
					style="width: 85%; height: 80px">
						<option value=""></option>
						<option value="咨询">咨询</option>
						<option value="维修">维修</option>
						<option value="办卡">办卡</option>
						<option value="普货维修">普货维修</option>
						<option value="危货维修">危货维修</option>
				</select></td>
			</tr>
			<tr>
				<td>接听者姓名：</td>
				<td><input class="easyui-textbox" name="answerName"
					style="width: 80%" value="${sessionUser.realname }"   /></td>
			</tr>
			<tr>
				<td>转接员姓名：</td>
				<td><input id="transferName" name="transferName"
					class="easyui-textbox" style="width: 80%" /></td>
			</tr>
		</table>
	</form>
</body>
</html>