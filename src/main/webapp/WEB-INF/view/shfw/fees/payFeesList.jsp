<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>缴费管理</title>
<%@ include file="/common/taglibs.jsp"%>
<script src="../js/DateUtil.js" type="text/javascript"></script>
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
					sfriqi : $('#sfriqi').val(),
					sfriqi1 : $('#sfriqi1').val()
				}
			});
			$('#gridForm').form('clear');
		});
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../fees/listPayFees',
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
				width : 100,
				field : 'carNumber',
				title : '车牌号'
			}, {
				width : 100,
				field : 'owner',
				title : '业户名称'
			}, {
				width : 100,
				field : 'ownerTel',
				title : '联系电话'
			}, {
				width : 100,
				field : 'companyName',
				title : '所属企业'
			}, {

				field : 'purpose',
				title : '收费类型',
				align : 'center',
				width : 70,
				formatter : function(value, row, index) {
					if (row.purpose == 0) {
						return "<div  style='background-color:#008B00;text-align:center;margin:0px;padding:0px;'>新装</div>"
					} else if (row.purpose == 1) {
						return "<div  style='background-color:#FF6347;text-align:center;margin:0px;padding:0px;'>续费</div>"
					} else if (row.purpose == 2) {
						return "<div  style='background-color:#8B8B00;text-align:center;margin:0px;padding:0px;'>维修</div>"
					}
				}
			}, {
				field : '_qx',
				title : '服务期限',
				align : 'center',
				width : 140,
				formatter : function(value, row, index) {
					return row.startTime + "至" + row.endTime;
				}
			}, {
				field : 'fees',
				title : '金额',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					return row.fees == 0 ? "" : '&yen; ' + row.fees;

				}
			}, {
				field : 'sfry',
				title : '交款人'
			}, {
				field : 'sfriqi',
				title : '缴费时间'
			}, {
				field : 'initriqi',
				title : '录入时间'
			}
			/* , {
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
			} */
			] ],
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
			width : 450,
			height : 430,
			left : 200,
			url : '../fees/toPayFeesAdd',
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

				$("#sfriqi").val(clock);
				loadCarNumBox();
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
							url : '../fees/payFees',
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
	function editRow(id) {
		SL.showWindow({
			title : '收费登记',
			width : 450,
			height : 430,
			left : 200,
			url : '../fees/toPayFeesAdd',
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

				$("#sfriqi").val(clock);
				loadCarNumBox();
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
							url : '../fees/payFees',
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
</script>
<body class="easyui-layout">
	<div region="north" style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang" style="height: 40px">
						车牌号：
						<input type="text" id="cph" style="width: 150px" />
						到期时间：
						<input id="endTime" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
						-
						<input id="endTime1" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
						<!-- 					</div> -->
						<!-- 					<div class="xia"> -->
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