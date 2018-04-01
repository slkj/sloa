<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.o../html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设备管理</title>

<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="../js/ajaxfileupload.js"></script>


<script type="text/javascript">
	var grid;
	$(function() {

		loadJSPButton(23);

		loadDataGrid();

		$("#h_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					packBm : $('#packBm').val(),
					listnum : $('#equitment').val(),
					simNumber : $('#simNumber').val(),
					lytime : $('#lytime').val(),
					lytime1 : $('#lytime1').val(),
					state : $('#state').combobox('getValue'),
					ustate : $('#ustate').combobox('getValue'),
					test : $('#test').combobox('getValue'),
					department : $("#h_department").combotree("getValue")
				}
			});
		});
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid(
			{
				url : '../devices/list',
				fit : true,
				nowrap : true, // false:折行
				rownumbers : true, // 行号
				striped : true, // 隔行变色
				pagination : true,
				pageSize : 20,
				pageList : [ 10, 20, 30, 50, 100 ],
				loadMsg : '数据加载中,请稍后……',
				columns : [ [
						{
							field : 'ck',
							checkbox : true
						},
						{
							field : 'packBm',
							title : '箱号'
						},
						{
							field : 'state',
							title : '出库状态',
							align : 'center',
							formatter : function(value, row) {
								var s = "";
								// 					if (value == "0") {
								// 						s = "<span  style='color:red;'>已退回</span>";
								// 					} else
								if (value == "1") {
									s = "<span  style='color:green;'>已出库</span>";
								} else if (value == "2") {
									s = "<span  style='color:blue;'>未出库</span>";
								} else if (value == "3") {
									s = "<span  style='color:#FF0000;'>退回</span>";
								}
								return s;
							}
						},
						{
							field : 'ustate',
							title : '使用状态',
							align : 'center',
							formatter : function(value, row) {
								var s = "";
								if (value == "0") {
									s = "<div  style='background-color:#999999;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未使用</div>";
								} else if (value == "1") {
									s = "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>使用</div>";
								}
								return s;
							}
						},
						{
							field : 'listnum',
							title : '设备编号'
						},
						{
							field : 'simNumber',
							title : '默认卡号'
						},
						{
							field : 'departmentName',
							title : '库存网点'
						},
						{
							field : 'test',
							title : '测试',
							align : 'center',
							formatter : function(value, row, index) {
								var s = "";
								if (value == 1) {
									s = "已检测";
								} else if (value == 0) {
									s = "<span style=\"color:red;\">未检测</span>";
								}
								return s;
							}
						},
						{
							field : 'ustype',
							title : '用途'
						},
						{
							field : 'lyr',
							title : '领用人'
						},
						{
							field : 'lytime',
							title : '领用时间'
						},
						{
							field : 'remark',
							title : '备注'
						},
						{
							field : '_mx',
							title : '出入库明细',
							align : 'center',
							formatter : function(value, row, index) {
								var str = "";
								str += "<a href=\"javascript:void(0)\"><span  onclick=\"javaScript:isRecdFun('"
										+ row.listnum.replace(
												/\s+/g, "")
										+ "');\">明细</span></a>";
								return str;
							}
						} ] ],
				toolbar : '#td_toolbar',
				onLoadSuccess : function(data) {
					grid.datagrid('clearSelections');
					if (data.total == 0) {
						var body = $(this).data().datagrid.dc.body2;
						body
								.find('table tbody')
								.append(
										'<tr><td width="'
												+ body.width()
												+ '" style="height: 35px; text-align: center;"><h1>暂无数据</h1></td></tr>');
					}
				},
			});
		// 设置分页控件
		grid.datagrid('getPager').pagination({
			beforePageText : '第',// 页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}
	/*弹出出入库记录*/
	function isRecdFun(id) {
		SL.showWindow({
			title : '出入库明细',
			width : 720,
			height : 380,
			url : '../devices/toDetails', 
			onLoad : function() {
				loadDetails(id);
			},
			buttons : [ {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	}
	function loadDetails(id) {
		$('#detailsGrid').datagrid({
			url : '../devices/getListRecd',
			method : 'POST',
			queryParams : {
				'listnum' : id
			},
			fit : true,
			striped : true,
			fitColumns : true,
			singleSelect : false,
			rownumbers : true,
			pagination : false,
			nowrap : false,
			pageSize : 10,
			pageList : [ 10, 20, 50, 100, 150, 200 ],
			showFooter : true,
			columns : [ [ {
				field : 'site',
				title : '库存网点'
			}, {
				field : 'ustate',
				title : '使用状态',
				align : 'center',
				formatter : function(value, row) {
					var s = "";
					if (value == "1") {
						s = "<span  style='color:green;'>出库</span>";
					} else if (value == "2") {
						s = "<span  style='color:blue;'>退回</span>";
					}
					return s;
				}
			}, {
				field : 'cktime',
				title : '出库时间',
				sortable : true,
				order : 'desc',
			}, {
				field : 'departmentname',
				title : '领用部门'
			}, {
				field : 'lyr',
				title : '领用人'
			}, {
				field : 'qsstate',
				title : '签收',
				align : 'center',
				formatter : function(value, row) {
					var s = "";
					if (value == "1") {
						s = "<span  style='color:green;'>已签收</span>";
					} else if (value == "0") {
						s = "<span  style='color:blue;'>待收货</span>";
					}
					return s;
				}
			}, {
				field : 'qstime',
				title : '签收时间'
			}, {
				field : 'qsr',
				title : '签收人'
			} ] ]
		});
	}
</script>
</head>

<body class="easyui-layout">
	<div region="north"
		style="height: 80px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						箱 号 ：<input id="packBm" style="width: 150px"
							data-options="prompt:'例如：HBC9,HBD1.以,分开'" /> 库存网点：<input
							id="h_department" name="department" style="width: 180px"
							data-options="prompt:'---请选择部门---'" /> 领用时间：<input id="lytime"
							class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input
							id="lytime1" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
					</div>
					<div class="xia">
						设备号：<input id="equitment" name="equitment" style="width: 150px" />
						SIM卡号： <input id="simNumber" name="simNumber" style="width: 180px" />
						出库： <select id="state" name="state" class="easyui-combobox"
							style="width: 100px;" editable="false">
							<option value=""></option>
							<option value="1">已出库</option>
							<option value="2">未出库</option>
							<option value="3">退回</option>
						</select> 使用：<select id="ustate" class="easyui-combobox"
							style="width: 100px;" editable="false">
							<option value=""></option>
							<option value="1">入网使用</option>
							<option value="0">未使用</option>
						</select> 测试：<select id="test" class="easyui-combobox"
							style="width: 100px;" editable="false">
							<option value=""></option>
							<option value="0">未测试</option>
							<option value="1">已测试</option>
						</select> <a id="search_btn" href="#" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'">查询</a>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center">
		<table id="listGrid"></table>
	</div>
	<div id="td_toolbar">
		<!-- 		<a id="rukuBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ruku',plain:'true'">入库</a>  -->
		<!-- 		<a id="chukuBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-chuku',plain:'true'">出库</a> -->
		<!-- 		<a id="checkBtn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-check',plain:'true'">检修</a> -->
	</div>

</body>
</html>