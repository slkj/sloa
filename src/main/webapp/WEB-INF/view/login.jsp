<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登录</title>
<link rel="stylesheet" href="css/base.css" />
<link rel="stylesheet" href="css/login.css" />
<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.tips.js"></script>
<script>
	if (window.top !== window.self) {
		window.top.location = window.location;
	}
	document.onkeydown = function() {
		if (event.keyCode == 13) {
			severCheck();
		}
	}
	//服务器校验
	function severCheck() {
		if (check()) {
			var username = $("#username").val();
			var password = $("#password").val();
			$.ajax({
				type : "POST",
				url : 'login_login',
				data : {
					username : username,
					password : password,
					tm : new Date().getTime()
				},
				dataType : 'json',
				cache : false,
				success : function(data) {
					if ("success" == data.result) {
						window.location.href = "index";
					} else if ("usererror" == data.result) {
						$("#username").tips({
							side : 1,
							msg : "用户名或密码有误",
							bg : '#FF5080',
							time : 15
						});
						$("#username").focus();
					} else {
						$("#username").tips({
							side : 1,
							msg : "缺少参数",
							bg : '#FF5080',
							time : 15
						});
						$("#username").focus();
					}
				}
			});
		}
	}
	//客户端校验
	function check() {
		if ($("#username").val() == "") {
			$("#username").tips({
				side : 2,
				msg : '用户名不得为空',
				bg : '#AE81FF',
				time : 3
			});
			$("#username").focus();
			return false;
		} else {
			$("#username").val(jQuery.trim($('#username').val()));
		}
		if ($("#password").val() == "") {
			$("#password").tips({
				side : 2,
				msg : '密码不得为空',
				bg : '#AE81FF',
				time : 3
			});
			$("#password").focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div class="superlogin"></div>
	<div class="loginBox">
		<div class="logo">
			<img src="images/admin_logo.png" />
		</div>
		<div class="loginMain">
			<div class="tabwrap">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="title">用户名：</td>
						<td><input name="username" id="username" type="text"
							class="form-control txt" /></td>
					</tr>
					<tr>
						<td class="title">密 码：</td>
						<td><input name="password" id="password" type="password"
							class="form-control txt" /></td>
					</tr>
					<!-- 			<tr><td class="title">验证码：</td><td><input type="text" class="form-control txt txt2" /><span class="yzm"><img src="images/yzm.jpg"/></span></td></tr> -->
					<!-- 					<tr class="errortd"> -->
					<!-- 						<td>&nbsp;</td> -->
					<!-- 						<td><i class="ico-error"></i><span class="errorword">用户名或密码错误，请重新输入！</spwan></td> -->
					<!-- 					</tr> -->
					<tr>
						<td>&nbsp;</td>
						<td><input type="button" class="loginbtn" value="登录"
							style="width: 242px" onclick="severCheck()" /> <!-- 							<input type="button" class="resetbtn" value="重置" onclick="location.href='loginA.html'" /> -->
						</td>
					</tr>
					<!-- 			<tr><td>&nbsp;</td><td class="forgetpsw"><a href="login_forgetb.html">忘记密码？</a></td></tr>	 -->
				</table>
			</div>
		</div>
	</div>
	<div class="footer">Copyright © 2015-2017 神龙科技 All Rights
		Reserved.</div>
</body>
</html>
