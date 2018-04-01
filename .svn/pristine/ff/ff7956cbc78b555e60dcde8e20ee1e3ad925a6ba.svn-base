<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.o../html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出入库记录</title>

<%@ include file="/common/taglibs.jsp"%>



<script type="text/javascript">
	var grid;
	$(function() {

		loadDataGrid();

		$("#h_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});

		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					listnum : $('#numberText').val(),
				}
			});
			//	$('#gridForm').form('clear');
		});
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			url : '../prove/getListRecd',
			fit : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			pagination : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [  {
				field : 'devices_id',
				title : '编号'
			},{
				field : 'site',
				title : '出库点'
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
			} ] ],
			onLoadSuccess : function(data) {
				grid.datagrid('clearSelections');
				if (data.total == 0) {
					var body = $(this).data().datagrid.dc.body2;
					body.find('table tbody').append('<tr><td width="' + body.width() + '" style="height: 35px; text-align: center;"><h1>暂无数据</h1></td></tr>');
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
</script>
</head>

<body class="easyui-layout">
	<div region="north" style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						 证明编号：<input id="numberText" name="number" style="width: 200px" /> 
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