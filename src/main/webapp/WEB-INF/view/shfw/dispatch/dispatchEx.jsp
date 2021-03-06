<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>派工</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="../js/easyui/datagrid-detailview.js" type="text/javascript"></script>
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
		$("#h_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});

		loadDataGrid();

		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					personnelName : $('#wxyText').val(),
					carNumber : $('#carText').val(),
					repairTime : $('#repairTime').val(),
					repairTime1 : $('#repairTime1').val(),
					department : $("#h_department").combotree("getValue"),
					type : $('#wxtype').combobox('getValue')
				}
			});
			$('#gridForm').form('clear');
		});
	});
	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../dispatch/list',
			fit : true,
			fitColumns : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			pagination : true,
			singleSelect : true,
			checkOnSelect : true,
			autoRowHeight : false,// 设置行的高度，根据该行的内容。设置为false可以提高负载性能。
			pageSize : 20,
			pageList : [ 10, 15, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [ {
				field : 'outcome',
				title : '状态审核',
				formatter : function(value, row, index) {
					if (row.outcome == '1') {
						return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>解决</div>";
					} else if (row.outcome == '0') {
						return "<div  style='background-color:red;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未解决</div>";
					}
				}
			}, {
				field : 'isLook',
				title : '回访结果',
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
			}, {
				field : 'dispatchNum',
				title : '派工单号'
			}, {
				field : 'repairTime',
				title : '派检时间'
			}, {
				field : 'type',
				title : '类型',
				align : 'center',
				formatter : function(value, row, index) {
					if (row.type == '0') {
						return '<span style="color:green;">新装</span>';
					} else if (row.type == '1') {
						return '<span style="color:red;">维修</span>';
					} else {
						return '<span style="color:blue;">转网</span>';
					}
				}
			}, {
				field : 'carNumber',
				title : '车牌号'
			}, {
				field : 'owner',
				title : '业户姓名'
			}, {
				field : 'telephone',
				title : '联系电话'
			}, {
				field : 'contact',
				title : '收费',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					return '&yen; ' + row.contact;

				}
			}, {
				field : 'personnelName',
				title : '维修员'
			}, {
				field : '_option',
				title : '操作',
				align : 'center',
				formatter : function(value, row, index) {
					var s = "";
					s += "<a href=\"javascript:void(0)\" onclick=\"javaScript:deleteRow('" + row.id + "');\"><span >删除</span></a>";
					return s;
				}
			} ] ],
			view : detailview,
			detailFormatter : function(rowIndex, rowData) {
				return '<table class="dv-table" border="0" style="width:100%;">' + '<tr> <td class="dv-label">设备号: </td><td> ' 
				+ rowData.deviceId + '</td><td  class="dv-label">卡号:</td><td>' + rowData.sim + '</td></tr>' 
				+ '<tr> <td class="dv-label">维修员: </td><td> ' + rowData.personnelName + '</td><td  class="dv-label">维修员电话: </td><td>' + rowData.personnelPhone + '</td></tr>' 
				+ '<tr> <td class="dv-label" >维修地点: </td><td colspan="3"> ' + rowData.site + '</td></tr>'
				+ '<tr> <td class="dv-label">原因: </td><td  colspan="3"> ' + rowData.why + '</td></tr>' 
				+ '</table>';
			},
			// 			toolbar : [ {
			// 				text : '登记',
			// 				iconCls : 'icon-edit',
			// 				handler : function() {
			// 					openWin();
			// 				}
			// 			}, '-', {
			// 				text : '导出',
			// 				iconCls : 'icon-20130406125519344_easyicon_net_16',
			// 				handler : function() {
			// 				}
			// 			} ],
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
	/*弹出入库窗口*/
	function openWin() {
		SL.showWindow({
			title : '派检单',
			width : 720,
			height : 370,
			url : '../dispatch/toDispatchAdd',
			onLoad : function() {
				loadCarNumBox();
				loadPerNumBox();
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
							url : '../dispatch/insert',
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
			onHidePanel : function() {
				var t = $(this).combogrid('getValue');
				if (artChanged) {
					if (selectRow == null || t != selectRow.carNumber) {//没有选择或者选项不相等时清除内容
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
				field : 'carNumber',
				title : '车牌号',
				width : 50
			}, {
				field : 'equitment',
				title : '设备ID',
				width : 50
			}, {
				field : 'simNumber',
				title : 'SIM卡号',
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
				$('#deviceId').textbox('setValue', row.equitment);
				$('#sim').textbox('setValue', row.simNumber);
			}
		});
	}
	function loadPerNumBox() {
		$('#peCombx').combogrid({
			required : true,
			panelWidth : 500,
			idField : 'id',
			textField : 'realname',
			url : '../user/list',
			loadMsg : '数据加载中,请稍后……',
			delay : 2000,
			onChange : function(newValue, oldValue) {
				artChanged1 = true;//记录是否有改变（当手动输入时发生)
			},
			onHidePanel : function() {
				var t = $(this).combogrid('getValue');
				if (artChanged1) {
					if (selectRow1 == null || t != selectRow1.id) {//没有选择或者选项不相等时清除内容
						alert('请选择，不要直接输入');
						$(this).combogrid('setValue', '');
					} else {
						//do something...
					}
				}
				artChanged1 = false;
				selectRow1 = null;
			},
			columns : [ [ {
				field : 'realname',
				title : '用户名',
				width : 50
			}, {
				title : '联系方式',
				field : 'phone',
				width : 50
			}, {
				field : 'office',
				title : '职务',
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
						'realname' : q
					});
					$(this).combogrid('setValue', q);
				}
			},
			onSelect : function(index, row) {
				selectRow1 = row;
				$('#personnelPhone').textbox('setValue', row.phone);
			}
		});
	}
	/**
	 执行删除
	 **/
	function deleteRow(id) {
		if (confirm("确定要删除该记录吗？")) {
			$.ajax({
				url : "../dispatch/delete?id=" + id,
				success : function(data) {
					if (data) {
						grid.datagrid('load');
					}
				}
			});
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 107px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<div class="rt_content">
			<!-- 整个表头DIV -->
			<div class="top">
				<!-- 表格DIV -->
				<form id="gridForm">
					<div class="item">
						<div id="cot">
							<br />
							<div class="shang">
								车牌号：<input id="carText" style="width: 150px" /> 类型：<select id="wxtype" class="easyui-combobox" style="width: 100px;">
									<option value=""></option>
									<option value="0">新装</option>
									<option value="1">维修</option>
									<option value="2">转网</option>
								</select> 维修员： <input id="wxyText" style="width: 150px">
							</div>
							<div class="xia">
								<br /> 所属部门： <input id="h_department" name="department" style="width: 180px" data-options="prompt:'---请选择部门---'" /> 派修时间：<input id="repairTime" class="Wdate" type="text"
									onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input id="repairTime1" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> <a
									id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
							</div>
						</div>
					</div>
				</form>
				<!--表格DIV结束-->
			</div>
		</div>
	</div>
	<div region="center">
		<table id="listGrid"></table>
	</div>
</body>
</html>