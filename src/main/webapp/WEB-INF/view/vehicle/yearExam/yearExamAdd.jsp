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
		<table class="grid" style="width: 100%">
			
			<tr>
				<th>年审日期:</th>
				<td><input id="yearExamS" class="easyui-datebox" name="yearExamS" editable="false" style="width: 200px"
						data-options="required:true"></td>
			</tr>
			
			<tr>
				<th>到期时间:</th>
				<td> <input id="yearExamE" class="easyui-datebox" name="yearExamE" editable="false"
						style="width: 200px" data-options="required:true">
				</td>
			</tr>
			
		</table>
	</form>
</body>
</html>