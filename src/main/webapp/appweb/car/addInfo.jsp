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

<link rel="stylesheet" href="../css/m.common.css" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../js/easyui/themes/metro/easyui.css">
<link rel="stylesheet" type="text/css" href="../../js/easyui/themes/mobile.css">
<link rel="stylesheet" type="text/css" href="../../js/easyui/themes/icon.css">
<script type="text/javascript" src="../../js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../../js/easyui/jquery.easyui.mobile.js"></script>
<script type="text/javascript" src="../../js/easyui/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">
	$(function() {
		initSeletList();
		var myId = GetQueryString("id");
		$("#dispatchNum").val(myId);

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
	$("#testForm").html5Validate(function() {
		alert("全部通过！");
		//this.submit();	
	}, {
	// novalidate: false,
	// labelDrive: false
	});
	function submitCar() {
		if ($("#postForm").form('enableValidation').form('validate')) {
			$.ajax({
				url : '../../vehicle/save',
				type : "POST",
				data : $('#postForm').serialize(),
				success : function(result) {
					if (result.success) {
						window.location = "../index.jsp";
						$.messager.show({
							title : 'Success',
							msg : result.msg
						});
					} else {
						$.messager.show({
							title : 'Error',
							msg : result.msg
						});
					}
				}
			});
		}

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

	<header class="topHd"> <a onClick="history.back();return false;" href="#" class="back">返回</a> <a href="../index.jsp" class="home">首页</a> <span>添加车辆</span></header>
	<section class="mContent"> <article class="cttBg">
	<form id="postForm" metdod="post" action="">
		<input name="guy" type="hidden" value="${sessionUser.id }" /> <input name="department" type="hidden" value="${sessionUser.departcode }" /> <input type="hidden" id="dispatchNum" name="repairNum" />
		<ul class="form">
			<li>所属地区:<span id="areaName"> <select id="province" onchange="changeSelect(this);">
						<option value="000000" style="color: #999;" disabled="disabled">-请选择省-</option>
				</select> <select id="city" onchange="changeSelect(this);">
						<option value="000000" style="color: #999;" disabled="disabled">-请选择市-</option>
				</select> <select id="district">
						<option value="000000" style="color: #999;" disabled="disabled">-请选区-</option>
				</select></li>
			<li>车辆识别代码/车架号： <input name="carVin" class="easyui-textbox" style="width: 100%" data-options="required:true">
			</li>
			<li>车牌号：<input name="carNumber" class="easyui-textbox" style="width: 200px" data-options="required:true" /></li>
			<li>车牌颜色：<select name="plateColor"><option value="" selected="selected">请选择</option>
					<option value="1" title="蓝色">蓝色</option>
					<option value="2" title="黄色">黄色</option></select></li>
			<li>车主/业户：<input name="carOwner" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>联系人：<input name="contacts" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>联系人手机：<input name="contactsTel" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>车辆类型：<select name="required">
					<option value="">请选择</option>
					<option value="112" title="重型厢式货车">重型厢式货车</option>
					<option value="101" title="普通货车">普通货车</option>
					<option value="102" title="罐车">罐车</option>
					<option value="103" title="牵引车">牵引车</option>
					<option value="104" title="集装箱车">集装箱车</option>
					<option value="105" title="半挂车">半挂车</option>
					<option value="106" title="自卸车">自卸车</option>
					<option value="108" title="大型货车">大型货车</option>
					<option value="109" title="厢式货车">厢式货车</option>
					<option value="110" title="低速载货汽车">低速载货汽车</option>
					<option value="111" title="专用运输车">专用运输车</option>
					<option value="120" title="仓栅式货车">仓栅式货车</option>
					<option value="153" title="平头柴油自卸货车">平头柴油自卸货车</option>
					<option value="155" title="重型平板自卸货车">重型平板自卸货车</option>
					<option value="156" title="大型非载货专项作业车">大型非载货专项作业车</option>
					<option value="29" title="重型罐式自卸货车">重型罐式自卸货车</option>
					<option value="154" title="重型集装箱半挂车">重型集装箱半挂车</option>
					<option value="157" title="轻型自卸货车">轻型自卸货车</option>
					<option value="121" title="平头柴油载货汽车">平头柴油载货汽车</option>
					<option value="122" title="洒布车">洒布车</option>
					<option value="123" title="粉粒物料运输车">粉粒物料运输车</option>
					<option value="126" title="重型普通货车">重型普通货车</option>
					<option value="138" title="中型半挂牵引车">中型半挂牵引车</option>
					<option value="149" title="中型罐式货车">中型罐式货车</option>
					<option value="152" title="重型普通半挂车">重型普通半挂车</option>
					<option value="27" title="重型厢式半挂车">重型厢式半挂车</option>
					<option value="22" title="中型普通货车">中型普通货车</option>
					<option value="28" title="重型平板半挂车">重型平板半挂车</option>
					<option value="142" title="重型集装箱车">重型集装箱车</option>
					<option value="143" title="中型仓栅式货车">中型仓栅式货车</option>
					<option value="144" title="重型非载货专项作业车">重型非载货专项作业车</option>
					<option value="145" title="中型专项作业车">中型专项作业车</option>
					<option value="146" title="中型厢式货车">中型厢式货车</option>
					<option value="113" title="重型罐式货车">重型罐式货车</option>
					<option value="114" title="重型货车">重型货车</option>
					<option value="115" title="爆破器材运输车">爆破器材运输车</option>
					<option value="116" title="中型自卸货车">中型自卸货车</option>
					<option value="117" title="重型专项作业车">重型专项作业车</option>
					<option value="118" title="重型特殊结构货车">重型特殊结构货车</option>
					<option value="119" title="大型专项作业车">大型专项作业车</option>
					<option value="124" title="重型半挂牵引车">重型半挂牵引车</option>
					<option value="127" title="封闭厢式">封闭厢式</option>
					<option value="128" title="非封闭厢式">非封闭厢式</option>
					<option value="129" title="非厢式">非厢式</option>
					<option value="130" title="载货汽车">载货汽车</option>
					<option value="131" title="农用车">农用车</option>
					<option value="132" title="整车">整车</option>
					<option value="133" title="挂车">挂车</option>
					<option value="125" title="重型平板货车">重型平板货车</option>
					<option value="136" title="仓栅式运输车">仓栅式运输车</option>
					<option value="23" title="重型载货专项作业车">重型载货专项作业车</option>
					<option value="148" title="轻型仓栅式货车">轻型仓栅式货车</option>
					<option value="135" title="重型仓栅式货车">重型仓栅式货车</option>
					<option value="25" title="重型仓栅式半挂车">重型仓栅式半挂车</option>
					<option value="26" title="大型载货专项作业车">大型载货专项作业车</option>
					<option value="134" title="重型自卸货车">重型自卸货车</option>
					<option value="139" title="重型封闭货车">重型封闭货车</option>
					<option value="137" title="混凝土搅拌运输车">混凝土搅拌运输车</option>
					<option value="140" title="中型特殊结构货车">中型特殊结构货车</option>
					<option value="24" title="中型非载货专项作业车">中型非载货专项作业车</option>
					<option value="158" title="重型罐式半挂车">重型罐式半挂车</option>
					<option value="159" title="轻型厢式货车">轻型厢式货车</option>
					<option value="160" title="中型载货专项作业车">中型载货专项作业车</option>
					<option value="161" title="轻型普通货车">轻型普通货车</option>
			</select></li>
			<li>车辆品牌：<input name="carBrand" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>车辆型号：<input name="carModel" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>总质量(kg)：<input name="carTotalmass" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>核定载质量(kg)：<input name="carApproved" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>准牵引总质量(kg)：<input name="carTrac" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>外廓尺寸(mm)长：<input name="carOutLength" class="easyui-textbox" style="width: 60px" data-options="required:true">-宽 <input name="carOutWidth" class="easyui-textbox" style="width: 60px"
				data-options="required:true">-高 <input name="carOutHeight" class="easyui-textbox" style="width: 60px" data-options="required:true"></li>
			<li>货厢内部尺寸(mm)长：<input name="carContLength" class="easyui-textbox" style="width: 60px" data-options="required:true">-宽 <input name="carContWidth" class="easyui-textbox"
				style="width: 60px" data-options="required:true">-高 <input name="carContHeight" class="easyui-textbox" style="width: 60px" data-options="required:true"></li>
			<li>轴数：<input name="axleNumber" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>车辆登记证1：<input name="cost4" type="file" style="width: 200px" required="required"></li>
			<li>车辆登记证2：<input name="cost3" type="file" style="width: 200px" required="required"></li>
			<li>车辆合格证/行驶证：<input name="cost2" type="file" style="width: 120px" required="required"></li>
			<li>车身照片：<input name="cost1" type="file" style="width: 200px" required="required"></li>
			<li>终端ID：<input name="equitment" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
			<li>SIM卡卡号：<input name="simNumber" class="easyui-textbox" style="width: 200px" data-options="required:true"></li>
		</ul>
	</form>
	</article>
	<ul class="form pusht">
		<li><input type="submit" class="btn" value="登记" onclick="submitCar()" /></li>
	</ul>
	</section>
</body>
</html>