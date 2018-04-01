<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>神龙智能办公系统</title>
<meta name="viewport"
	content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1;" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />

<link rel="stylesheet" href="../css/m.common.css" />
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>

<script type="text/javascript">
	$(function() {

		$("#wxTime").val(new Date())
		var myId = GetQueryString("id");
		$("#dispatchNum").val(myId)
	});
	function toWeixiu() {
		var data = $("#dataInfo").serialize();
		$.ajax({
			cache : false,
			type : "POST",
			url : '../../repair/save',
			data : data,
			async : false,
			success : function(data) {
				if (data.success) {
					alert("上传信息成功！");
					window.location.href = 'list.jsp'
				} else {
					alert("出错了");
				}
			}
		});
	}
	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null)
			return unescape(r[2]);
		return null;
	}
</script>
</head>
<body class="mWrap">

	<header class="topHd"> <a onClick="history.back();return false;" href="#" class="back">返回</a>
	<a href="../index.jsp" class="home">首页</a> <span>详细信息</span></header>
	<section class="mContent"> <article class="cttBg">
	<form id="dataInfo" metdod="post">
		<ul class="form">
			<input name="guy" type="hidden" value="${sessionUser.id }" />
			<input name="department" type="hidden" value="${sessionUser.departcode }" />
			<input name="contact" type="hidden" value="${sessionUser.phone }" />
			<input type="hidden" id="dispatchNum" name="repairNum" value=""/>
			<li>维修时间：<input name="wxTime" type="datetime-local" /></li>
			<li>车牌号：<input name="carNumber" type="text" /></li>
			<li>原设备号：<input name="equitment" type="number" style="width: 200px"></li>
			<li>原卡号：<input name="simNumber" type="number" style="width: 200px"></li>
			<li>现设备号：<input name="equitment1" type="number" style="width: 200px"></li>
			<li>现卡号：<input name="simNumber1" type="number" style="width: 200px"></li>
			<li>费用：<input name="cost" type="number" style="width: 200px"></li>
			<!-- 		<li>维修现场：<a class="uploadButton"><input id="uploadInput" type="file" style="display:block;height:40px;width:45px;opacity:0;"></input></a></li> -->
			<li>维修地点：<textarea id="site" name="site" style="width: 90%; font-size: 14px; resize: none;"
					rows="2"></textarea></li>

		</ul>
	</form>
	</article>
	<ul class="form pusht">
		<li><input type="button" class="btn" value="维修登记" onClick="toWeixiu()" /></li>
	</ul>
	</section>
</body>
</html>