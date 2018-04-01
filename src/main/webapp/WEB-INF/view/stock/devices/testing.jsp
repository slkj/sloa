<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>GPS设备测试</title>
</head>
<body>

	<div class="pop_cont">
		<div class="pop_cont_input">
			<form id="ckform" metdod="post">
				<ul>
					<li><span class="ttl">用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;途&nbsp;：&nbsp;</span><select
						class="easyui-combobox" id="ustype" style="width: 70%" data-options="required:'true'"
						editable="false">
							<option value="普货">普货</option>
							<option value="危货">危货</option>
							<option value="客车">客车</option>
							<option value="旅游车">旅游车</option>
							<option value="其他">其他</option>
					</select></li>
					<li><span class="ttl">安&nbsp;检&nbsp;员&nbsp;：</span> <input id="inspector" type="text"
						style="width: 70%" value="${sessionUser.realname }"></input></li>
					<li><span class="ttl">默认卡号：</span> <input id="simNum" type="text" style="width: 70%"></input></li>
					<li><span class="ttl">测试时间：</span> <input id="cstime" name="cstime" class="Wdate"
						type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" style="width: 70%" /></li>
					<li><span class="ttl">测试结果：</span> <label><input id="tresult" type="radio" name="tresult"
							value="1" checked="checked" />定位</label> <label><input id="tresult" name="tresult" type="radio" value="0" />不定位</label></li>
					<li><span class="ttl">包装编号：</span> <input id="t_packBm"  type="text" style="width: 70%" /></li>
					<li><span class="ttl">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</span> <textarea
							class="textarea" id="remark" name="remark" style="height: 50px; width: 80%;"></textarea></li>
				</ul>
			</form>
		</div>
	</div>
</body>
</html>