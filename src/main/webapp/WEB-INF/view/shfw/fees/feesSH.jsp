<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>服务费管理</title>
<%@ include file="/common/taglibs.jsp"%>
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
					riqi : $('#jfEndTime').val(),
					riqi1 : $('#jfEndTime1').val(),
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
			queryParams : {
				fees : '0'
			},
			singleSelect : true,
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
				title : '收款确认',
				align : 'center',
				formatter : function(value, row, index) {

					if (row.fees == 0) {
						return "<a href=\"#\" onclick=\"fees('" + row.id + "')\">收款</a></div>";
					} else if (row.fees == 1) {
						return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已入网</div>";
					}

				}
			}, {
				field : 'amounts',
				title : '实收金额',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(value, row, index) {
					return row.amounts == 0 ? "" : '&yen; ' + row.amounts;
				}
			}, {
				field : 'payee',
				title : '收款人'
			}, {
				field : 'qr_time',
				title : '操作时间'
			} ] ],
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
			width : 450,
			height : 420,
			url : 'feesAdd.jsp',
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
									$.messager.show({
										title : 'Error',
										msg : '不好意思，出错了！'
									});
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
	/*弹出收费窗口*/
	function fees(id) {
		SL.showWindow({
			title : '服务费信息',
			iconCls : 'icon-add',
			width : 450,
			height : 250,
			url : '../fees/feesConfirm',
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
									$.messager.show({
										title : 'Error',
										msg : '不好意思，出错了！'
									});
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
						</select>缴费时间：<input id="jfEndTime" class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input id="jfEndTime1" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> <a id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
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