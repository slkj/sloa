<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>微信订单</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="../../js/easyui/datagrid-detailview.js" type="text/javascript"></script>
<script type="text/javascript">
	var grid;
	$(function() {
		// 加载列表数据
		loadDataGrid();
		// 初始化用户操作按钮
		// 	loadJSPButton();
		// 点击查询，根据条件检索
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					carNumber : $('#cph').val(),
					riqiStart : $('#riqi1').val(),
					riqiEnd : $('#riqi2').val()
				}
			});
			$('#gridForm').form('clear');
		});
	});
	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../list',
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
			columns : [ [ {
				field : 'orderNumber',
				title : '订单号',
				align : 'center'
			}, {
				field : 'type',
				title : '订单类型',//续费 or 新装
				align : 'center',
				formatter : function(value, row, index) {
					if (row.type == '0') {
						return '<span style="color:blue;">续费</span>';
					} else if (row.type == '1') {
						return '<span style="color:green;">新装</span>';
					}
				}
			}, {
				field : 'wx_type',
				title : '平台类型',//续费 or 新装
				align : 'center',
				formatter : function(value, row, index) {
					if (row.wx_type == '0') {
						return '危客';
					} else if (row.wx_type == '1') {
						return '普货';
					}
				}
			}, {
				field : 'carNumber',
				title : '车牌号',
				align : 'center'
			}, {
				field : 'purpose',
				title : '车主'
			}, {
				field : 'phone',
				title : '联系电话',
				align : 'center'
			}, {
				field : 'deadline',
				title : '缴费期限',
				align : 'center',
				formatter : function(value, row, index) {
					if (row.deadline == '0' || row.deadline == null) {
						return "";
					} else {
						return row.deadline + '年';
					}
				}
			}, {
				field : 'prove',
				title : '证明索取',
				align : 'center',
				formatter : function(value, row, index) {
					if (row.prove == '0') {
						return '<span style="color:red;">否</span>';
					} else if (row.prove == '1') {
						return '<span style="color:green;">是</span>';
					}
				}
			}, {
				field : 'colAmounts',
				title : '收费标准',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					if (row.colAmounts == 0 || row.colAmounts == null) {

						return "";
					}
					return '&yen; ' + row.colAmounts;

				}
			}, {
				field : 'state',
				title : '支付状态',//待处理 or 已支付 
				align : 'center',
				formatter : function(value, row, index) {
					if (row.state == '0') {
						return '<span style="color:red;">待处理</span>';
					} else if (row.state == '1') {
						return '<span style="color:green;">已支付</span>';
					}
				}
			}, {
				field : 'price',
				title : '总金额',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					if (row.price == 0 || row.price == null) {

						return "";
					}
					return '&yen; ' + row.price;

				}
			}, {
				field : 'pay_time',
				title : '支付时间',
				align : 'center'
			}, {
				field : 'col',
				title : '操作',
				align : 'center',
				formatter : function(value, row, index) {
					var str = "";
					str += "<a href=\"javascript:void(0)\"><span  onclick=\"javaScript:orderAdd('" + row.state + "','" + row.orderNumber + "');\">收费金额 </span></a>"
					str += "  |  <a href=\"javascript:void(0)\"><span  onclick=\"javaScript:orderEdit('" + row.state + "','" + row.orderNumber + "');\">编辑</span></a>";
					return str;
				}
			} ] ],
			view : detailview,
			detailFormatter : function(rowIndex, rowData) {
				var str = '<table class="smallGrid">';
				str += '<tr><th width="70px">所属单位: </th><td width="120px">' + rowData.owner + '</td><th width="70px">下单时间：</th><td width="120px">' + rowData.riqi + '</td></tr>';
				str += '<tr><th width="70px">审核员: </th><td>' + rowData.payee + '</td><th width="70px">操作时间：</th><td>' + rowData.qr_time + '</td></tr>';
				str += '<tr><th width="70px">备注：</th><td colspan="3">' + rowData.remark + '</td></tr>';
				return str + '</table>';
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
	/* 设置收费标准页面  */
	function orderAdd(state, on) {
		if (state == 1) {
			alert("该车辆已经支付，无法编辑");
			return;
		}
		SL.showWindow({
			title : '设置收费标准',
			iconCls : 'icon-add',
			width : 350,
			height : 200,
			url : '../order/toOrderAdd',
			buttons : [ {
				text : '确定',
				iconCls : 'icon-save',
				handler : function() {
					if ($("#weixinForm").form('enableValidation').form('validate')) {
						///调用微信接口
						if (toWxUpdateOrderPay(on)) {
							var data = {
								orderNumber : on,
								colAmounts : $('#colAmounts').val(),
							};
							$.ajax({
								cache : false,
								type : "POST",
								url : '../updateSfbz',
								data : data,
								async : false,
								dataType : 'json',
								success : function(data) {
									if (data.success) {
										grid.datagrid('load');
										SL.closeWindow();
									} else {
										alert("异常，操作失败！");
									}
								}
							});
						}else{
							alert("微信平台异常，操作失败！");
						}
					}
				}
			}, {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	};
	function orderEdit(state, on) {
		if (state == 1) {
			alert("该车辆已经支付，无法编辑");
			return;
		}
		SL.showWindow({
			title : '编辑信息',
			iconCls : 'icon-add',
			width : 350,
			height : 200,
			url : '../order/toOrderEdit',
			buttons : [ {
				text : '确定',
				iconCls : 'icon-edit',
				handler : function() {
					if ($("#payForm").form('enableValidation').form('validate')) {
						//调用微信平台接口
						if (toWxUpdateOrder(on)) {
							var data = {
								orderNumber : on,
								state : $('#state').combobox('getValue'),
								price : $('#price').textbox('getValue')
							};
							$.ajax({
								cache : false,
								type : "POST",
								url : '../editSate',
								data : data,
								async : false,
								dataType : 'json',
								success : function(data) {
									if (data.success) {
										grid.datagrid('load');
										SL.closeWindow();
									} else {
										alert("异常，操作失败！");
									}
								}
							});
						}else{
							alert("微信平台异常，操作失败！");
						}

					}
				}
			}, {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	};
	//保存数据
	function toWxUpdateOrder(on) {
		var data = {
			orderNumber : on,
			state : $('#state').combobox('getValue'),
			price : $('#price').textbox('getValue')
		};
		$.ajax({
			cache : false,
			type : "POST",
			url : 'http://weixin.wlsh.cn:8089/shengLong/f/shengLongFront/updateOrderSuccess',
			data : data,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					return true;
				} else {
					alert("系统异常！");
					return false;
				}
			}
		});
	}

	//保存数据
	function toWxUpdateOrderPay(on) {
		var data = {
			orderNumber : on,
			price : $('#colAmounts').textbox('getValue'),
			state : $('#state').combobox('getValue')
		};
		$.ajax({
			cache : false,
			type : "POST",
			url : 'http://weixin.wlsh.cn:8089/shengLong/f/shengLongFront/updateOrderPay',
			data : data,
			async : false,
			dataType : 'json',
			success : function(data) {
				if (data.success) {
					return true;
				} else {
					alert("系统异常！");
					return false;
				}
			}
		});
	}
</script>
<body class="easyui-layout">
	<div region="north" style="height: 45px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						车牌号：<input type="text" id="cph" name="carNumber" style="width: 150px" /> 支付时间：<input id="riqi1" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input
							id="riqi2" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> <a id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
					</div>
					<div class="xia"></div>
				</div>
			</div>
		</form>
	</div>
	<div region="center">
		<table id="listGrid"></table>
	</div>
</body>
</html>