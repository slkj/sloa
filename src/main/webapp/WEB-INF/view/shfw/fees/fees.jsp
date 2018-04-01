<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>服务费管理</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="../js/easyui/datagrid-detailview.js" type="text/javascript"></script>
<script src="../js/DateUtil.js" type="text/javascript"></script>
<script type="text/javascript">
	var grid;
	$(function() {
		//初始化页面加载单位下拉框
		$("#h_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});
		// 加载列表数据
		loadDataGrid();
		// 初始化用户操作按钮
		// 	loadJSPButton();
		// 点击查询，根据条件检索
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					carNumber : $('#cph').val(),
					number : $('#numberTop').val(),
					endTime : $('#endTime').val(),
					endTime1 : $('#endTime1').val(),
					department : $("#h_department").combotree("getValue"),
					purpose : $('#purpose').combobox('getValue'),
					fees : $('#fees').combobox('getValue')
				}
			});
			$('#gridForm').form('clear');
		});
	});
	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../fees/list',
			fit : true,
			fitColumns : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			singleSelect : true,
			checkOnSelect : true,
			autoRowHeight : false,
			pagination : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			rowStyler : function(index, row) {

				Date.prototype.diff = function(date) {
					return (this.getTime() - date.getTime()) / (24 * 60 * 60 * 1000);
				}
				// 构造两个日期，分别是系统时间和2013/04/08 12:43:45
				var now = new Date();
				var date = new Date(row.endTime);
				// 调用日期差方法，求得参数日期与系统时间相差的天数
				var diff = now.diff(date);
				// 打印日期差
				// 								alert(Math.abs(diff));
				if (diff > 30) {
					return 'background-color:pink;font-weight:bold;';

				}
			},
			columns : [ [ {
				field : 'carNumber',
				title : '车牌号'
			}, {
				field : 'owner',
				title : '业户名称'
			}, {
				field : 'startTime',
				title : '开始时间'
			}, {
				field : 'endTime',
				title : '到期时间'
			}, {
				field : 'number',
				title : '证明编号'
			}, {
				field : 'colAmounts',
				title : '代收金额',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					return '&yen; ' + row.colAmounts;

				}
			}, {
				field : 'agent',
				title : '代收人'
			}, {
				field : 'remark',
				title : '备注'
			}, {
				field : 'fees',
				title : '入账状态',
				align : 'center',
				formatter : function(value, row, index) {
					if (row.fees == 0)
						return "<div  style='background-color:gray;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>待确认</div>"
					if (row.fees == 1)
						return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已收款</div>";
				}
			} ] ],
			view : detailview,
			detailFormatter : function(index, row) {
				return '<div style="padding:5px"><table id="tbfeesItem-' + index + '"></table></div>';
			},
			onExpandRow : function(index, row) {
				$('#tbfeesItem-' + index).datagrid({
					url : '../fees/listByCarNumber',
					queryParams : {
						carNumber : row.carNumber
					},
					fitColumns : true,
					singleSelect : true,
					rownumbers : true,
					loadMsg : '数据加载中,请稍后……',
					height : 'auto',
					pagination : true,
					pageSize : 5,
					pageList : [ 5, 10, 20 ],
					columns : [ [ {
						field : 'number',
						title : '证明编号',
						width : 50
					}, {
						field : 'purpose',
						title : '用途',
						align : 'center',
						formatter : function(value, row, index) {
							if (row.purpose == 0)
								return "新装"
							if (row.purpose == 1)
								return "续费";
							if (row.purpose == 2)
								return "维修";
						}
					}, {
						field : 'startTime',
						title : '开始时间',
						width : 50
					}, {
						field : 'endTime',
						title : '结束时间',
						width : 50
					}, {
						field : 'colAmounts',
						title : '代收金额',
						width : 50,
						align : 'right',
						styler : function(value, row, index) {
							return 'color:red;';
						},
						formatter : function(val, row, index) {
							return '&yen; ' + row.colAmounts;

						}
					}, {
						field : 'agent',
						title : '代收人',
						width : 50
					} ] ],
					onResize : function() {
						$('#listGrid').datagrid('fixDetailRowHeight', index);
					},
					onLoadSuccess : function() {
						setTimeout(function() {
							$('#listGrid').datagrid('fixDetailRowHeight', index);
						}, 0);
					}
				});
				$('#listGrid').datagrid('fixDetailRowHeight', index);
			},
			toolbar : [ {
				text : '登记',
				iconCls : 'icon-add',
				handler : function() {
					openWin();
				}
			} ],
			onLoadSuccess : function() {
				grid.datagrid('clearSelections');
				// 								$(this).datagrid("fixRownumber");
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
	function openWin() {
		SL.showWindow({
			title : '服务费信息',
			iconCls : 'icon-add',
			width : 800,
			height : 500,
			top : 50,
			left : 100,
			url : '../fees/toFeesAdd',
			onLoad : function() {
				loadCarNumBox('#carNumber');
				loadProveBox('#number');
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#postForm").form('enableValidation').form('validate')) {
						var data = $("#postForm").serialize();
						$.ajax({
							cache : false,
							type : "POST",
							url : '../fees/pay',
							data : data,
							async : false,
							success : function(data) {
								if (data) {
									SL.closeWindow();
									grid.datagrid('reload');
								} else {
									alert("出错了");
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
	//车牌号下拉框处理
	function loadCarNumBox() {
		$('#carNumber').combogrid({
			required : true,
			panelWidth : 500,
			idField : 'carNumber',
			textField : 'carNumber',
			url : '../vehicle/list',
			delay : 2000,
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
// 			onHidePanel : function() {
// 				var t = $(this).combogrid('getValue');
// 				if (artChanged) {
// 					if (selectRow == null || t != selectRow.carNumber) {//没有选择或者选项不相等时清除内容
// 						alert('请选择，不要直接输入！请先添加车辆信息。');
// 						$(this).combogrid('setValue', '');
// 					} else {
// 						//do something...
// 					}
// 				}
// 				artChanged = false;
// 				selectRow = null;
// 			},
			columns : [ [ {
				field : 'carNumber',
				title : '车牌号',
				width : 50
			}, {
				field : 'carOwner',
				title : '户主',
				width : 50
			} ] ],
			fitColumns : true,
			pagination : true,
			pageSize : 20,
			keyHandler : {
				up : function() {
				},
				down : function() {
				},
				enter : function() {
				},
				query : function(q) {
					//动态搜索
					$(this).combogrid('grid').datagrid('reload', {
						'carNumber' : q
					});
					$(this).combogrid('setValue', q);
				}
			},
			onSelect : function(index, row) {
				selectRow = row;
				$('#carOwner').textbox('setValue', row.carOwner);
			}
		});
	}

	//证明编号下拉框处理
	function loadProveBox() {
		$('#number').combogrid({
			required : true,
			panelWidth : 450,
			idField : 'number',
			textField : 'number',
			url : '../prove/list',
			delay : 2000,
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
			onHidePanel : function() {
				var t = $(this).combogrid('getValue');
				if (artChanged) {
					if (selectRow == null || t != selectRow.number) {//没有选择或者选项不相等时清除内容
						alert('请选择，不要直接输入');
						$(this).combogrid('setValue', '');
					} else {
						//do something...
					}
				}
				artChanged = false;
				selectRow = null;
			},
			columns : [ [ {
				field : 'number',
				title : '证明编号',
				width : 50
			}, {
				field : 'ustype',
				title : '使用类型',
				width : 50
			}, {
				field : 'ustate',
				title : '使用状态',
				width : 50,
				//控制，当value不同时，显现出不同的颜色的样式（未使用、已使用、已作废） 
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<div  style='background-color:#CD3333;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未使用</div>";
					} else if (value == "1") {
						s = "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已使用</div>";
					} else if (value == "3") {
						s = "<div  style='background-color:#aaaaaa;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已作废</div>";
					}
					return s;
				}
			} ] ],
			fitColumns : true,
			pagination : true,
			pageSize : 20,
			keyHandler : {
				up : function() {
				},
				down : function() {
				},
				enter : function() {
				},
				query : function(q) {
					//动态搜索
					$(this).combogrid('grid').datagrid('reload', {
						'number' : q
					});
					$(this).combogrid('setValue', q);
				}
			},
			onSelect : function(index, row) {
				selectRow = row;
				$('#ustype').textbox('setValue', row.ustype);
				$('#ustate').textbox('setValue', row.ustate);
			}
		});
	}

	/*弹出收费窗口*/
	function fees(id) {
		SL.showWindow({
			title : '服务费信息',
			iconCls : 'icon-add',
			width : 450,
			height : 250,
			url : 'feesConfirm.jsp',
			onLoad : function() {
				$('#fees_id').val(id);
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#postForm").form('enableValidation').form('validate')) {
						var data = $("#postForm").serialize();
						$.ajax({
							cache : false,
							type : "POST",
							url : '../fees/fees',
							data : data,
							async : false,
							success : function(data) {
								if (data) {
									SL.closeWindow();
									grid.datagrid('reload');
								} else {
									alert("出错了");
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
<body class="easyui-layout">
	<div region="north" style="height: 80px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						车牌号：<input type="text" id="cph" style="width: 150px" /> 所属部门： <input id="h_department" name="department" style="width: 180px" data-options="prompt:'---请选择部门---'" /> 到期时间：<input id="endTime"
							class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input id="endTime1" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
					</div>
					<div class="xia">
						证明编号：<input type="text" id="numberTop" style="width: 150px" /> 用途：<select id="purpose" class="easyui-combobox" style="width: 100px;">
							<option value=""></option>
							<option value="0">新装</option>
							<option value="1">续费</option>
						</select> 是否付款：<select id="fees" class="easyui-combobox" style="width: 100px;">
							<option value=""></option>
							<option value="0">未付款</option>
							<option value="1">付款</option>
						</select> <a id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
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