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
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.10.2/jquery.min.js"></script>
<meta name="format-detection" content="telephone=no" />

<link rel="stylesheet" href="../css/m.common.css" />
<script type="text/javascript">
	var upPage = 1;
	var pageRows = 5;
	var total;
	$(function() {
		loadData(upPage);
		$("#goodsload").click(function() {
			var tolsPage = total / pageRows;
			if (upPage <= tolsPage) {
				upPage = upPage + 1;
				loadData(upPage);
			} else {
				alert("没有更多数据了");
			}

		})
	});
	function loadData(upPage) {
		$.ajax({
			url : "../../dispatch/list",
			type : "post",
			data : {
				personnel : $("#personnel").val(),
				page : upPage,
				rows : pageRows

			},
			success : function(data) {
				var str = "";
				var rows = data.rows;
				total = data.total;
				for (var i = 0; i < rows.length; i++) {
					var outcome, btnstr;
					if (rows[i].outcome == '1') {
						outcome = '<i class="ico icoDan">已维修</i>';
						btnstr = '<ins class="sbtn right">查看</ins>';
					} else if (rows[i].outcome == '0') {
						outcome = '<i class="ico icoJi">未维修</i>';
						btnstr = '<ins class="sbtn right">登记</ins>';
					}
					str += '<li><a href="default.jsp?id=' + rows[i].id + '"><p class="tt">' + outcome + rows[i].carNumber + '</p>  <p> ' + btnstr + '<span class="price">'
							+ rows[i].owner + '<br>电话：' + rows[i].telephone + '' + '</span><br>' + '原因：' + rows[i].causes + '<br>' + '派修时间：' + rows[i].repairTime + '</p></a></li>';
				}
				$("#dataUl").append(str);
			}
		});
	}
</script>
</head>

<body class="mWrap">
	<input type="hidden" id="personnel" value="Mj5OdvDGwkJoaQf4ceY" />
	<header class="topHd"> <a onClick="history.back();return false;" href="#" class="back">返回</a>
	<a href="../index.jsp" class="home">首页</a> <span>派检单</span> </header>
	<section class="mContent">
	<ul class="proList clearfix" id="dataUl">
		<!-- 		<li><a href="default.html"><p class="tt"> -->
		<!-- 					<i class="ico icoJi">寄</i>7300银两=100元 -->
		<!-- 				</p></a> -->
		<!-- 			<p> -->
		<!-- 				<a href="default.html"><ins class="sbtn right">购买</ins></a> <a href="default.html"><span -->
		<!-- 					class="price">¥100</span><br>三区/万剑逍遥/游戏币</a> -->
		<!-- 			</p></li> -->
		<div id="dataappend"></div>
	</ul>
	<div class="moreList" id="goodsload">+点击加载后更多+</div>
	</section>
</body>
</html>