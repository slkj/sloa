<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>神龙智能办公系统</title>
<meta name="viewport" content="width=device-width,height=device-height,inital-scale=1.0,maximum-scale=1.0,user-scalable=no,initial-scale=1, minimum-scale=1, maximum-scale=1;" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<link rel="stylesheet" href="css/m.common.css" />

<script type="text/javascript">
	function loadData() {
		var cph = $("#cphText").val();
		$.ajax({
			url : "../fees/getFeesByCarNum",
			type : "post",
			data : {
				carNum : cph
			},
			success : function(data) {
				$("#dataInfo").empty();
				var str = "";
				str += '<li>车牌号：' + data.carNumber + '</li>';
				str += '<li>车辆类型：' + data.carType + '</li>';
				str += '<li>联系人：' + data.contacts + '</li>';
				str += '<li>联系电话：' + data.contactsTel + '</li>';
				str += '<li>业户名称：' + data.carOwner + '</li>';
				str += '<li>到期时间：' + data.feeseEnd + '</li>';
				str += '<li>收费标准：' + data.uprice + '</li>';
				$("#dataInfo").append(str);
				var validDate=new Date(data.feeseEnd.replace(/-/g, "/"));
				var nowDate=new Date();
				if(validDate<nowDate){//判断状态是否有效  #FFFF00 黄 #FF0000  红
					alert(dd)
 					if(Math.abs(parseInt((nowDate - validDate) / 1000 / 60 / 60 /24))>30){
 						alert("将要过期，请及时续费");
					}
				}else{
					alert("已经过期，请续费");
				}
			}
		});
	}
</script>
</head>
<body class="mWrap">

	<header class="topHd"> <a onClick="history.back();return false;" href="#" class="back">返回</a> <a href="index.jsp" class="home">首页</a> <span>服务费到期查询</span></header>
	<section class="mContent"> <article class="cttBg">
	<form metdod="post">
		<ul class="form">
			<li>车牌号：<input id="cphText" type="text" style="width: 50%" /></li>
		</ul>
	</form>

	<ul class="form pusht">
		<li><input type="button" class="btn" value="查询" onClick="loadData()" /></li>
	</ul>
	<ul class="form" id="dataInfo">

	</ul>
	</article> </section>
</body>
</html>