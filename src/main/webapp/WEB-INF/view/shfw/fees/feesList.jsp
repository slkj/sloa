<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>缴费管理</title>
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
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			checkOnSelect : true,
			autoRowHeight : false,
			pagination : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [ {
				field : 'riqi',
				title : '收费时间'
			}, {
				field : 'purpose',
				title : '项目',
				align : 'center',
				width : 50,
				formatter : function(value, row, index) {
					if (row.purpose == 0) {
						return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>新装</div>"
					} else if (row.purpose == 1) {
						return "<div  style='background-color:blue;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>续费</div>"
					} else if (row.purpose == 2) {
						return "<div  style='background-color:gray;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>续费</div>"
					}
				}
			}, {
				field : 'carNumber',
				title : '车牌号'
			}, {
				field : 'owner',
				title : '业户名称'
			}, {
				field : 'colAmounts',
				title : '代收金额',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					return row.colAmounts == 0 ? "" : '&yen; ' + row.colAmounts;

				}
			}, {
				field : 'agent',
				title : '收款人'
			}, {
				field : 'depName',
				title : '收款部门'
			}, {
				field : 'remark',
				title : '备注'
			}, {
				field : 'fees',
				title : '入账状态',
				align : 'center',
				formatter : function(value, row, index) {
					if (row.fees == 0) {
						return "<div  style='background-color:gray;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>待确认</div>"
					} else if (row.fees == 1) {
						return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已入网</div>";
					}
				}
			}, {
				field : 'opt',
				title : '操作',
				align : 'center',
				formatter : function(value, row, index) {
					var s = "";
					if (row.fees == 0) {
						s += "<a href=\"javascript:void(0)\"  onclick=\"javaScript:editRow('" + row.id + "');\"><span>编辑</span></a>";
					}
					return s;
				}
			} ] ],
			view : detailview,
			detailFormatter : function(rowIndex, rowData) {
				var str = '<table class="smallGrid"><tr><th width="70px" style="text-align: center;">项目：</th>' + '<th style="text-align: center;" >内容</th><th width="70px" style="text-align: center;">价格</th></tr>';
				if (rowData.deviceNumber.length > 0) {
					str += '<tr><th>设备ID: </th><td>' + rowData.deviceNumber + '</td><td>¥' + rowData.devicePice + '</td></tr>';
				}
				if (rowData.number.length > 0) {
					str += '<tr><th>证明编号: </th><td>' + rowData.number + '（' + rowData.startTime + '至' + rowData.endTime + '）</td><td>¥' + rowData.colAmounts + '</td></tr>';
				}
				if (rowData.simNumber.length > 0) {
					str += '<tr><th>SIM卡号: </th><td>' + rowData.simNumber + '</td><td>¥' + rowData.simPice + '</td></tr>';
				}
				if (rowData.fees.length > 0) {
					str += '<tr><th>维修: </th><td>' + rowData.upkeep + '</td><td>¥' + rowData.upkeepPice + '</td></tr>';
				}
				return str + '</table>';
			},
			toolbar : [ {
				text : '缴费登记',
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
			title : '收费登记',
			iconCls : 'icon-add',
			width : 800,
			height : 450,
			top : 50,
			left : 100,
			url : '../fees/toFeesAdd',
			onLoad : function() {
				var now = new Date();
				var year = now.getFullYear(); // 年
				var month = now.getMonth() + 1; // 月
				var day = now.getDate(); // 日
				var clock = year + "-";
				if (month < 10) {
					clock += "0";
				}
				clock += month + "-";
				if (day < 10) {
					clock += "0";
				}
				clock += day;

				$("#riqi").val(clock);
				loadCarNumBox();
				loadEquipmentBox('#deviceNumber');
				loadProveBox();
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
								if (data.success) {
									SL.closeWindow();
									grid.datagrid('reload');
								} else {
									alert("出错了");
								}
							}
						});

					} else {
						alert("请完善信息。");
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

	function loadEquipmentBox(id) {
		$(id).combogrid({
			delay : 2000,
			panelWidth : 500,
			idField : 'listnum',
			textField : 'listnum',
			url : '../devices/list',
			queryParams : {
				ustate : '0'
			},
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
			columns : [ [ {
				field : 'listnum',
				title : '设备号',
				width : 50
			}, {
				field : 'state',
				title : '出库状态',
				width : 50,
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<span  style='color:blue;'>未出库</span>";
					} else if (value == "1") {
						s = "<span  style='color:green;'>已出库</span>";
					} else if (value == "2") {
						s = "<span  style='color:red;'>已退回</span>";
					}
					return s;
				}
			}, {
				field : 'ustate',
				title : '使用状态',
				width : 50,
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<div  style='background-color:#999999;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未使用</div>";
					} else if (value == "1") {
						s = "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>使用</div>";
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
						'listnum' : q
					});
					$(this).combogrid('setValue', q);
				}
			},
			onSelect : function(index, row) {
				selectRow = row;
				//$('#deviceId').textbox('setValue', row.equitment);
				//$('#sim').textbox('setValue', row.simNumber);
			}
		});
	}
	function loadCarNumBox() {
		$('#carNumberCombx').combogrid({
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
// 						alert('请选择，不要直接输入');
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
				title : '所属企业',
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

				$('#contactsText').textbox('setValue', row.contacts);
				$('#contactsTelText').textbox('setValue', row.contactsTel);
				$('#carOwnerText').textbox('setValue', row.carOwner);
			}
		});
	}
	//证明编号下拉框处理
	function loadProveBox() {
		$('#proveNumber').combogrid({
			panelWidth : 450,
			idField : 'number',
			textField : 'number',
			url : '../prove/list',
			delay : 2000,
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
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
				// 				$('#ustype').textbox('setValue', row.ustype);
				// 				$('#ustate').textbox('setValue', row.ustate);
			}
		});
	}

	function editRow(id) {
		SL.showWindow({
			title : '收费登记',
			iconCls : 'icon-add',
			width : 800,
			height : 450,
			top : 50,
			left : 100,
			url : '../fees/toFeesAdd',
			onLoad : function() {
				var now = new Date();
				var year = now.getFullYear(); // 年
				var month = now.getMonth() + 1; // 月
				var day = now.getDate(); // 日
				var clock = year + "-";
				if (month < 10) {
					clock += "0";
				}
				clock += month + "-";
				if (day < 10) {
					clock += "0";
				}
				clock += day;

				$("#riqi").val(clock);
				loadCarNumBox();
				loadEquipmentBox('#deviceNumber');
				loadProveBox();
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#postForm").form('enableValidation').form('validate')) {
						var chkObjs = null;
						var obj = document.getElementsByName("purpose");
						for (var i = 0; i < obj.length; i++) { //遍历Radio 
							if (obj[i].checked) {
								chkObjs = obj[i].value;
							}
						}

						if (chkObjs == 0) {
							if ($("#endTime").val().length <= 0) {
								alert("请输入到期时间");
								return;
							}
						}

						var pobj = $(".number").val();
						if (pobj.length > 0) {
							if ($("#endTime").val().length <= 0) {
								alert("请输入到期时间");
								return;
							}
						}
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

					} else {
						alert("请完善信息。");
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
						车牌号：<input type="text" id="cph" style="width: 150px" /> 部门： <input id="h_department" name="department" style="width: 180px" data-options="prompt:'---请选择部门---'" /> 到期时间：<input id="endTime"
							class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input id="endTime1" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
					</div>
					<div class="xia">
						证明编号：<input type="text" id="numberTop" style="width: 150px" />
						类型：<select id="purpose" class="easyui-combobox" style="width: 100px;">
							<option value=""></option>
							<option value="0">新装</option>
							<option value="1">续费</option>
							<option value="2">维修</option>
						</select> 支付状态：<select id="fees" class="easyui-combobox" style="width: 100px;">
							<option value=""></option>
							<option value="0">待付款</option>
							<option value="1">已付款</option>
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