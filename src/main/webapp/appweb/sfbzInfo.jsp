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
<style>
img{
  max-width:100%;
  height:auto;
}
</style>
<script type="text/javascript">
	function toWeixiu() {
		var data = $("#cphText").val();
		var url = "http://hbslkj.com:89/Interface/findPosition.action?carNum=" + data;
		// 		window.location.href = url;
		$('#mapIframe').attr('src', url);
	}
</script>
</head>
<body class="mWrap">

	<header class="topHd"> <a onClick="history.back();return false;" href="#" class="back">返回</a> <a href="index.jsp" class="home">首页</a> <span>收费标准</span></header>
	<section class="mContent"> <img src="images/sbsfbz.png"  /> </section>
</body>
</html>