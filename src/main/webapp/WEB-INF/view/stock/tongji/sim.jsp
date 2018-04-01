<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../../css/style.css" />
<script src="../../plugins/jquery/jquery-3.0.0.min.js" type="text/javascript"></script>
<link href="../../plugins/easyui/themes/default/easyui.css" rel="stylesheet" type="text/css" />
<link href="../../plugins/easyui/themes/icon.css" rel="stylesheet" type="text/css" />
<link href="../../css/IconExtension.css" rel="stylesheet" type="text/css" />
<script src="../../plugins/easyui/jquery.easyui.min.js" type="text/javascript"></script>
<script src="../../plugins/easyui/easyui-lang-zh_CN.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript"
	src="../../plugins/My97DatePicker/WdatePicker.js"></script>
<script src="../../js/SL.easyUI.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid;
	$(function() {
		closedDiv();
		//showDiv();
		
	});
	
	function closedDiv() {
		/*  $('#listGrid').show();
		$('#listGrid1').hide();  */
		 /* $("#listGrid").css("display","block");
		$("#listGrid1").css("display","none");  */
		$('#listGrid').treegrid({
			url : '../../devices/sum?type=su',
			loadMsg : '数据加载中....',
			fit : true,
			nowrap : true, //false:折行
			striped : true, //隔行变色
			//singleSelect : true, //单选
//			checkOnSelect : true,
			idField : 'id',
			treeField : 'd_name',
			lines : true,
			animate : true,
			height : 450,
			showFooter:true,
			rownumbers: true,
			collapsible:true,
			columns : [ [ {
				field : 'd_name',
				title : '部门 名 称',
				width : 180
			}, {
				field : 'stockSum',
				title : '库存数',
				width : 180
			},{
				field : 'useSum',
				title : '使用数',
				width : 180
			} ,  {
				field : 'unUseSum',
				title : '未使用数',
				width : 180
			} ] ],
		});		
	}
	
</script>
</head>
<body class="easyui-layout">
	<div region="north">
		<div class="rt_content">
			<div class="page_title">
				<h2 class="fl">SIM统计</h2>
			</div>
			<div class="top" style="height: 30px;">
				<input name="addType" type="radio" value="0" checked="checked"
							onclick="closedDiv()" />按部门<!-- <input name="addType" type="radio" value="1"
							onclick="showDiv()" />按设备类型 -->
			</div>
		</div>
	</div>
	<div  region="center" style="padding: 8px; background: #eee;">	
		<table id="listGrid"></table>	
	 </div>
	
</body>
</html>