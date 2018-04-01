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
<style type="text/css">
label {
    cursor: pointer;
    display: inline-block;
    font-size: 13px;
    margin-right: 15px;
    padding-left: 25px;
    position: relative;
}
input[type="radio"] {
    display: none;
}
label:before {
    background-color: #a06b63;
    bottom: 1px;
    box-shadow: 0 2px 3px 0 rgba(0, 0, 0, 0.3) inset, 0 1px 0 0 rgba(255, 255, 255, 0.8);
    content: "";
    display: inline-block;
    height: 16px;
    left: 0;
    margin-right: 10px;
    position: absolute;
    width: 16px;
}
.radio label:before {
    border-radius: 8px;
}
input[type="radio"]:checked + label:before {
    color: #f3f3f3;
    content: "•";
    font-size: 30px;
    line-height: 18px;
    text-align: center;
}
</style>
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
					alert(data.msg);
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
			<input type="hidden" id="dispatchNum" name="repairNum" />
			<li>
			<div class="radio"> 
			    <input type="radio" value="0" name="wxType" id="radio1" >
			    <label for="radio1">自带设备</label>
			    <input type="radio" value="1" name="wxType" id="radio2" checked>
			    <label for="radio2">8条线</label>
			    <input type="radio" value="2" name="wxType" id="radio3">
			    <label for="radio3">非8条线</label>
			</div>
			</li>
			<li>维修时间：<input id="wxTime" name="wxTime" type="datetime-local"  required="required"/></li>
			<li>设备号：<input name="equitment1" id="newdevice" type="number" style="width: 200px"  required="required"/></li>
			<li>卡号：<input name="simNumber1" id="newsim" type="number" style="width: 200px"  required="required" /></li>
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