<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="http://g.alicdn.com/dingding/open-develop/1.5.1/dingtalk.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
	var _config = {
			agentid : '7935645',
			corpId : 'ding7265dba91f03ed02'
	};
	dd.ready(function() {
		//获取免登授权码 -- 注销获取免登服务，可以测试jsapi的一些方法             
		dd.runtime.permission.requestAuthCode({
			corpId : _config.corpId,
			onSuccess : function(result) {
				loginAjax(result.code);
			},
			onFail : function(err) {
			}
		});
	});

	//用户登录
	function loginAjax(code) {
// 		alert("----"+code);
		$.ajax({
			url : "../goDingLogin?code="+code,
			type : "get",
			success : function(data) {
				if (data) {
					window.location.href = "index.jsp";
				} else {
					alert("暂无权限，请联系管理员。");
				}
			}
		});
	}
</script>
</head>
<body>

</body>
</html>