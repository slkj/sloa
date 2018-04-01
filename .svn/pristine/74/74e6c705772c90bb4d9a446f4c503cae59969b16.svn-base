<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="../js/combox.js"></script>
<script type="text/javascript">
	var grid;
	$(function() {
		loadDataGrid();
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					companyName : $('#companyName').val(),
					equitment : $('#equitment').val(),
					simNumber : $('#simNumber').val(),
					carNumber : $('#cph').val()
				}
			});

		});
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../vehicle/list',
			fit : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 斑马线
			autoRowHeight : false,// 设置行的高度
			pagination : true,
			singleSelect : true,// 是否单选
			pageSize : 15,
			pageList : [ 10, 15, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [  {
				field : 'carNumber',
				title : '车牌号'
			},{
				field : 'carType',
				title : '车辆类型',
				align : 'center',
				width : 100
			}, {
				field : 'contacts',
				title : '联系人',
				align : 'center',
				width : 80
			}, {
				field : 'contactsTel',
				title : '联系电话',
				align : 'center',
				width : 90
			}, {
				field : 'equitment',
				title : '设备ID',
				align : 'center',
				width : 90
			}, {
				field : 'simNumber',
				title : 'SIM卡号',
				align : 'center',
				width : 100
			}, {
				field : 'networkNo',
				title : '入网证明编号',
				align : 'center',
				width : 100
			},
			/* {
				field : 'installers',
				title : '安装人',
				align : 'center',
				width : 80
			},
			{
				field : 'installtime',
				title : '安装时间',
				align : 'center',
				width : 80
			}, */
			{
				field : 'feeseEnd',
				title : '到期时间',
				align : 'center',
				width : 80
			}, {
				field : 'companyName',
				title : '所属公司',
				resizable : true,
				align : 'center',
			}, {
				field : 'uprice',
				title : '收费标准/年',
				resizable : true,
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					if (row.uprice != 0) {
						return '&yen; ' + row.uprice;
					}
					return "";

				}
			}, {
				title : '操作',
				field : '_options',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					var s = "";
					s += "<a href=\"javascript:void(0)\"  onclick=\"javaScript:infoRow('" + row.id + "',1);\"><span>详细</span></a>";
					s += " &nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"  onclick=\"javaScript:editRow('" + row.id + "',2);\"><span>收费标准</span></a>";
					return s;
				}
			} ] ],
			toolbar : '#td_toolbar',
			onLoadSuccess : function(data) {
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

	/*弹出入库窗口     编辑*/
	function infoRow(id, bt) {
		top.addTab('车辆详细信息', 'vehicle/vehicleInfo?id=' + id);
	}
	/*弹出入库窗口  车辆详细信息 */
	function editRow(id, bt) {
		SL.showWindow({
			title : '收费标准',
			iconCls : 'icon-add',
			width : 400,
			height : 150,
			url : '../vehicle/toSfbzPage',
			onLoad : function() {
				$.ajax({
					type : "POST",
					url : '../vehicle/queryOne?id='+id,
					async : false,
					cache : false,
					success : function(data) {
						$("#comForm").form('load', data);
					}
				});
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#comForm").form('enableValidation').form('validate')) {
						$.ajax({
						url : "../vehicle/sfbz",
						type : "POST",
						data : $('#comForm').serialize(),
						success : function(data) {
							if (data) {
								SL.closeWindow();
								grid.datagrid('load');
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
	<input type="hidden" id="userDepart" value="${userSession.departcode }" />
	<div region="north" style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						车牌号：<input id="cph" style="width: 150px" /> 所属公司：<input id="companyName" style="width: 180px" /> 设备号：<input id="equitment" style="width: 150px" /> SIM卡号： <input id="simNumber"
							style="width: 180px" /> <a id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center">
		<table id="listGrid"></table>
	</div>
	<!-- <div class="page_Toolbar" id="td_toolbar"></div> -->
</body>
</html>