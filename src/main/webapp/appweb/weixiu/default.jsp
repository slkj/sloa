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
		var myId = GetQueryString("id");
		$.ajax({
			url : "../../repair/queryOne",
			type : "post",
			data : {
				id : myId
			},
			success : function(data) {
				var str = "";
				var outcome;
				if (data.outcome == '1') {
					outcome = "解决";
					outcome = '<i class="ico icoDan">解决</i>';
				} else if (data.outcome == '0') {
					outcome = '<i class="ico icoJi">未解决</i>';
				}
				var isLook;
				if (data.isLook == '1') {
					isLook = '<span style="color:green;">已通过</span>';
				} else if (data.isLook == '0') {
					isLook =  '<span style="color:red;">未通过</span>';
				}
				str += outcome + ' <span class="blue">'+data.carNumber+'</span></li>';
				str += '<li>派工单号：'+data.repairNum+'</li>';
				str += '<li>原设备ID：'+data.equitment+'</li>';
				str += '<li>原SIM卡号：'+data.simNumber+'</li>';
				str += '<li>现设备ID：'+data.equitment1+'</li>';
				str += '<li>现SIM卡号：'+data.simNumber1+'</li>';
				str += '<li>维修时间：'+data.wxTime+'</li>';
				str += '<li>维修地点：'+data.site+'</li>';
				str += '<li>录入员：'+data.operator+'</li>';
				str += '<li>录入时间：'+data.operatorTime+'</li>';
				str += '<li>审核结果：'+isLook+'</li>';
				str += '<li>审核人：'+data.looker+'</li>';
				str += '<li>审核时间：'+data.lookTime+'</li>';
				str += '<li><span class="ftBig orange">¥' + data.cost + '</span> <a href="javascript:pageBack();" class="aBlue right">返回列表页</a></li>';
				$("#dataInfo").append(str);
			}
		});
	});
	function pageBack() {
		window.location.href = 'list.jsp'
	}
	function toWeixiu() {
		window.location.href = 'addInfo.jsp?id=' + $("#dispatchNum").val();
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
	<input type="hidden" id="dispatchNum" />
	<header class="topHd"> <a onClick="history.back();return false;" href="#" class="back">返回</a>
	<a href="../index.jsp" class="home">首页</a> <span>详细信息</span> </header>
	<section class="mContent"> <article class="cttBg">
	<ul class="form" id="dataInfo">

	</ul>
	</article> </section>
</body>
</html>