<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设置缴费标准</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!-- 获取系统当前时间 -->
<%
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String value = format.format(new Date());
%>
</head>
<body>
	<form id="weixinForm" metdod="post" action="">
		<input id="orderNumber" name="orderNumber" type="hidden" />
		<table id="grid" style="width: 100%; padding: 10px">
			<tr>
				<td style="width: 25%">收费金额 ：</td>
				<td><input id="colAmounts" name="colAmounts" class="easyui-textbox" style="width: 50%" />&nbsp;元</td>
			</tr>
		</table>
	</form>
</body>
</html>