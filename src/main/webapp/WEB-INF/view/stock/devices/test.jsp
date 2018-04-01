<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设备安检</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	$(function() {
		loadDataGrid();
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					packBm : $('#packBm').val(),
					listnum : $('#equitment').val(),
					simNumber : $('#simNumber').val(),
					test : $('#test').combobox('getValue')
				}
			});
			$('#gridForm').form('clear');
		});
	});
	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../devices/list',
			fit : true,
			fitColumns : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			pagination : true,
			singleSelect : true,
			checkOnSelect : false,
			autoRowHeight : false,// 设置行的高度，根据该行的内容。设置为false可以提高负载性能。
			pageSize : 20,
			pageList : [ 10, 15, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [ {
				field : 'test',
				title : '测试',
				align : 'center',
				formatter : function(value, row, index) {
					var s = "";
					if (value == 1) {
						s = "<span style=\"color:green;\">已检测</span>";
					} else if (value == 0) {
						s = "<span style=\"color:red;\">未检测</span>";
					}
					return s;
				}
			}, {
				field : 'packBm',
				title : '箱号'
			}, {
				field : 'pack',
				title : '包装',
				align : 'center',
				formatter : function(value, row, index) {
					var s = "";
					if (value == 0) {
						s = "全新";
					} else if (value == 1) {
						s = "返修";
					}
					return s;
				}
			}, {
				field : 'listnum',
				title : '设备编号'
			}, {
				field : 'simNumber',
				title : '默认卡号'
			}, {
				field : 'cstime',
				title : '测试时间',
				sortable : true,
				order : 'desc'
			}, {
				field : 'inspector',
				title : '安检员'
			}, {
				field : 'remark',
				title : '备注'
			}, {
				field : 'tresult',
				title : '测试结果',
				align : 'center',
				formatter : function(value, row, index) {
					var s = "";
					if (value == 1) {
						s = "<span style=\"color:green;\">定位</span>";
					} else if (value == 0) {
						s = "<span style=\"color:red;\">不定位</span>";
					}
					return s;
				}
			}, {
				field : '_opp',
				title : '操作',
				align : 'center',
				formatter : function(value, row, index) {
					var str = "";
					str += "<a href=\"javascript:void(0)\"><span  onclick=\"javaScript:editRow('" + row.id + "');\">编辑 </span></a>";
					str += " | <a href=\"javascript:void(0)\"><span  onclick=\"javaScript:testing('" + row.id + "');\">检测 </span></a>";
					return str;
				}
			} ] ],
// 			toolbar : [ {
// 				id : '',
// 				text : '导出',
// 				iconCls : 'icon-help',
// 				handler : function() {
// 				}
// 			}, "-", {
// 				id : '',
// 				text : '导入',
// 				iconCls : 'icon-help',
// 				handler : function() {
// 				}
// 			} ],
			onLoadSuccess : function() {
				grid.datagrid('clearSelections');
				if (data.total == 0) {
					var body = $(this).data().datagrid.dc.body2;
					body.find('table tbody').append('<tr><td width="' + body.width() + '" style="height: 35px; text-align: center;"><h1>暂无数据</h1></td></tr>');
				}
			}
		});
		// 设置分页控件
		grid.datagrid('getPager').pagination({
			beforePageText : '第',// 页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}
	/*弹出入库窗口*/
	function testing(id) {
		SL.showWindow({
			title : '设备安检信息',
			iconCls : 'icon-add',
			width : 500,
			height : 370,
			url : '../devices/toTestPage',
			buttons : [ {
				text : '确定',
				handler : function() {
					if ($("#ckform").form('enableValidation').form('validate')) {
						var ids = [];
						ids.push(id);
						var param = {
							ids : ids,
							ustype : $('#ustype').combobox('getValue'),
							cstime : $('#cstime').val(),
							tresult : $("input[name='tresult']:checked").val(),
							remark : $('#remark').val(),
							packBm : $('#t_packBm').val(),
							simNumber : $('#simNum').val(),
							inspector : $('#inspector').val()
						};
						$.ajax({
							cache : false,
							type : 'POST',
							url : '../devices/testing',
							data : param,
							async : false,
							success : function(data) {
								if (data) {
									grid.datagrid('reload');
									SL.closeWindow();
								}
							}
						});
					}

				}
			}, {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	}
	/*设备打包方法*/
	function packFun() {
		var selRow = grid.datagrid("getSelections");// 返回选中多行
		if (selRow.length == 0) {
			alert('未选中设备，请至少选择一行数据!');
			return;
		}
		var ids = [];
		for (var i = 0; i < selRow.length; i++) {
			ids.push(selRow[i].id);
		}
	}
	
	
	/*弹出入库窗口*/
	function editRow(id) {
		SL.showWindow({
			title : '设备安检信息',
			iconCls : 'icon-add',
			width : 500,
			height : 370,
			url : '../devices/toTestPage',
			buttons : [ {
				text : '确定',
				handler : function() {
					if ($("#ckform").form('enableValidation').form('validate')) {
						var ids = [];
						ids.push(id);
						var param = {
							ids : ids,
							ustype : $('#ustype').combobox('getValue'),
							cstime : $('#cstime').val(),
							tresult : $("input[name='tresult']:checked").val(),
							remark : $('#remark').val(),
							packBm : $('#t_packBm').val(),
							simNumber : $('#simNum').val(),
							inspector : $('#inspector').val()
						};
						$.ajax({
							cache : false,
							type : 'POST',
							url : '../devices/testing',
							data : param,
							async : false,
							success : function(data) {
								if (data) {
									grid.datagrid('reload');
									SL.closeWindow();
								}
							}
						});
					}

				}
			}, {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
					<div class="item" style="height: 38px;">
						<div id="cot">
							<div class="xia">
								测试：<select id="test" class="easyui-combobox" style="width: 100px;" editable="false">
									<option value="" selected="selected">请选择</option>
									<option value="0">未测试</option>
									<option value="1">已测试</option>
								</select> 设备号：<input id="equitment" name="equitment" style="width: 150px" /> SIM卡号： <input
									id="simNumber" name="simNumber" style="width: 180px" /> 箱 号 ：<input id="packBm"
									style="width: 150px" data-options="prompt:'例如：HBC9,HBD1.以,分开'" />
								<a id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
							</div>
						</div>
					</div>
				</form>
	</div>
	<div region="center">
		<table id="listGrid"></table>
	</div>
</body>
</html>