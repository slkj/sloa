<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>维修</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="../js/easyui/datagrid-detailview.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/AjaxButtion.js"></script>
<style type="text/css">
.dv-table tr {
	border: 0;
	text-align: left;
}

.dv-table td {
	border: 0;
}

.dv-label {
	font-weight: bold;
	color: #15428B;
	width: 70px;
	text-align: right;
}
</style>
<script type="text/javascript">
	var grid;
	$(function() {
		loadJSPButton(25);
		//初始化页面加载单位下拉框
		$("#h_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});
		// 加载列表数据
		loadDataGrid();

		// 点击查询，根据条件检索
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				url : '../repair/list',
				queryParams : {
					carNumber : $('#cph').val(),
					guyName : $('#wxy').val(),
					wxTime : $('#repairTime').val(),
					wxTime1 : $('#repairTime1').val(),
					department : $("#h_department").combotree("getValue"),
					outcome : $('#outcome').combobox('getValue'),
					isLook : $('#isLook').combobox('getValue')
				}
			});
			$('#gridForm').form('clear');
		});
		// 点击解决按钮，收货审核
		$("#solveYes").click(function() {
			adopt(1);
		});
		// 点击解决按钮，收货审核
// 		$("#solveNo").click(function() {
// 			Solve(0);
// 		});
		// 点击通过按钮，监控录入信息审核
		$("#adoptYes").click(function() {
			Solve(1);
		});
		// 点击通过按钮，监控录入信息审核
// 		$("#adoptNo").click(function() {
// 			adopt(0);
// 		});
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../repair/list',
			fit : true,
			fitColumns : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			pagination : true,
			checkOnSelect : true,
			autoRowHeight : false,// 设置行的高度，根据该行的内容。设置为false可以提高负载性能。
			pageSize : 20,
			pageList : [ 10, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				field : 'carNumber',
				title : '车牌号'
			}, {
				field : 'guyName',
				title : '维修人'
			}, {
				field : 'cost',
				title : '收费金额',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					return '&yen; ' + row.cost;

				}
			}, {
				field : 'wxTime',
				title : '维修时间'
			}, {
				field : 'outcome',
				title : '定位审核',
				formatter : function(value, row, index) {
					if (row.outcome == '1') {
						return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>正常</div>";
					} else if (row.outcome == '0') {
						return "<div  style='background-color:red;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>异常</div>";
					}
				}
			},{
				field : 'operator',
				title : '审核人'
			}, {
				field : 'operatorTime',
				title : '审核时间'
			},{
				field : 'isLook',
				title : '审核结果',
				align : 'center',
				formatter : function(value, row, index) {
					if (row.isLook == '1') {
						return '<span style="color:green;">已通过</span>';
					} else if (row.isLook == '0') {
						return '<span style="color:orange;">未审核</span>';
					} else if (row.isLook == '-1') {
						return '<span style="color:red;">未通过</span>';
					}
				}
			},   {
				field : 'looker',
				title : '审核人'
			}, {
				field : 'lookTime',
				title : '审核时间'
			} ] ],
// 			toolbar : [ {
// 				text : '通过',
// 				iconCls : 'icon-ok',
// 				handler : function() {
// 					isPass("1");
// 				}
// 			}, {
// 				text : '不通过',
// 				iconCls : 'icon-no',
// 				handler : function() {
// 					isPass("-1");
// 				}
// 			} ],
			toolbar : '#td_toolbar',
			view : detailview,
			detailFormatter : function(rowIndex, rowData) {
				return '<div id="ddv-' + rowIndex + '" style="padding:5px 0"></div>';
			},
			onExpandRow : function(index, rowData) {

				var contentStr = '<table class="dv-table" border="0" style="width:100%;">';
				$.ajax({
					cache : false,
					type : "POST",
					url : '../dispatch/getByNum',
					data : {
						dispatchNum : rowData.repairNum
					},
					async : false,
					success : function(data) {
						if(data != ""){
						contentStr += '<tr> <td class="dv-label">设备号: </td><td> ' + data.deviceId + '</td><td  class="dv-label">卡号:</td><td>' + data.sim + '</td><td class="dv-label">派工时间: </td><td>' + data.repairTime + '</td></tr>' 
						+ '<tr> <td class="dv-label">维修员: </td><td> ' + data.personnelName + '</td><td  class="dv-label">维修员电话: </td><td>' + data.personnelPhone + '</td><td class="dv-label">派工员: </td><td>' + data.operator + '</td></tr>'
						+ '<tr> <td class="dv-label">报修原因: </td><td  colspan="5"> ' + data.causes + '</td></tr>' ;
						}
					}
				});
// 				contentStr += '<tr> <td class="dv-label" >维修地点: </td><td colspan="5"> ' + rowData.site + '</td></tr>' 
// 							+ '<tr> <td class="dv-label">检测原因: </td><td  colspan="5"> ' + rowData.why + '</td></tr>' 
							+ '</table>';
				$('#ddv-' + index).panel({
					border : false,
					cache : false,
					// 		            href:'datagrid21_getdetail.php?itemid='+row.itemid,    
					content : contentStr,
					onLoad : function() {
						grid.datagrid('fixDetailRowHeight', index);
					}
				});
				grid.datagrid('fixDetailRowHeight', index);
			},
			onLoadSuccess : function() {
				grid.datagrid('clearSelections');
			}
		});
		// 设置分页控件
		grid.datagrid('getPager').pagination({
			beforePageText : '第',// 页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}
	function Solve(state) {

		// 得到选中的行
		var selRow = grid.datagrid("getSelections");// 返回选中多行
		if (selRow.length != 1) {
			alert("请选择一行数据!");
			return false;
		}
		if (confirm("该车辆定位信息及安装线路正常,信息无误请点击确定否则取消！")) {
			var ids = [];
			for (var i = 0; i < selRow.length; i++) {
				ids.push(selRow[i].id);
			}
			var param = {
				ids : ids,
				outcome : state
			};
			$.ajax({
				url : "../repair/isOutcome",
				type : "POST",
				data : param,
				async : false,
				dataType : "json",
				cache : false,
				success : function(data) {
					grid.datagrid('reload');
				}
			});
		}
	}
	function adopt(state) {
		// 得到选中的行
		var selRow = grid.datagrid("getSelections");// 返回选中多行
		if (selRow.length != 1) {
			alert("请选择一行数据!");
			return false;
		}
		if (confirm("该车辆定位信息及安装线路正常,信息无误请点击确定否则取消！")) {
			var ids = [];
			for (var i = 0; i < selRow.length; i++) {
				ids.push(selRow[i].id);
			}
			var param = {
				ids : ids,
				isLook : state
			};
			$.ajax({
				url : "../repair/isLook",
				type : "POST",
				data : param,
				async : false,
				dataType : "json",
				cache : false,
				success : function(data) {
					grid.datagrid('reload');
				}
			});
		}
	}
</script>
</head>

<body class="easyui-layout" data-options="fit:true">
	<div region="north" style="height: 60px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			车牌号：<input type="text" id="cph" style="width: 150px" /> 维修员： <input type="text" id="wxy" style="width: 150px"> 所属部门：<input id="h_department" name="department" style="width: 180px"
				data-options="prompt:'---请选择部门---'" /> <br> 维修解决：<select id="outcome" class="easyui-combobox" style="width: 100px;">
				<option value=""></option>
				<option value="0">未解决</option>
				<option value="1">已解决</option>
			</select> 审核状态： <select id="isLook" class="easyui-combobox" style="width: 100px;">
				<option value=""></option>
				<option value="-1">未通过</option>
				<option value="1">已通过</option>
				<option value="0">未审核</option>
			</select> 维修时间： <input id="repairTime" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input id="repairTime1" class="Wdate" type="text"
				onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> <a id="search_btn" href="#" class="easyui-linkbutton" iconCls="icon-search">查询</a>
		</form>
	</div>
<div id="td_toolbar"></div>
	<div region="center">
		<table id="listGrid"></table>
	</div>
</body>
</html>