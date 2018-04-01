<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>司机卡制作</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	var grid;
	$(function() {
		loadDataGrid();
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					carNumber : $('#carID').val(),
					driverName : $('#driverName').val(),
					drivingNo : $('#drivingNo').val()
				}
			});
			$('#gridForm').form('clear');
		});
	});
	/**
	 获取用户列表数据
	 **/
	function loadDataGrid() {
		grid = $("#listGrid")
				.datagrid(
						{ // title : '用户列表',
							method : 'post',
							url : '../driver/list',
							loadMsg : '数据加载中....',
							fit : true,
							nowrap : true, // false:折行
							rownumbers : true, // 行号
							striped : true, // 隔行变色
							singleSelect : true,// 是否单选
							pagination : true,
							pageSize : 20,
							pageList : [ 10, 20, 30, 50 ],
							columns : [ [
									{
										field : 'carNumber',
										title : '车牌号',
										width : 150
									}, {
										field : 'deviceNum',
										title : '设备号',
										width : 100
									}, {
										field : 'driverNo',
										title : '司机卡号',
										width : 100
									}, {
										field : 'driverName',
										title : '司机姓名',
										width : 100
									}, {
										field : 'drivingNo',
										title : '驾驶证号',
										width : 100
									}, {
										field : 'madeTime',
										title : '制作日期',
										width : 100
									}, {
										field : 'collar',
										title : '领卡人',
										width : 150
									}, {
										field : 'companyId',
										title : '所属公司',
										width : 150
									}, {
										field : 'opt',
										title : '操作',
										align : 'center',
										width : 150,
										formatter : function(value, row, index) {
											var s = "";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:editRow('"
													+ row.id
													+ "');\">编辑</span></a>";
											s += "&nbsp;|&nbsp;";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:removeIt('"
													+ row.id
													+ "');\">删除</span></a>";
											return s;
										}
									} ] ],
							toolbar : [ {
								text : '新增',
								iconCls : 'icon-add',
								handler : function() {
									openRukuWin();
								}
							} ],
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
	/**
	 执行删除
	 **/
	function removeIt(id) {
		if (confirm("确定要删除该数据吗？")) {
			$.ajax({
				url : "../driver/delete?id=" + id,
				success : function(data) {
					if (data) {
						grid.datagrid('load');
					}
				}
			});
		}
	}

	/*弹出入库窗口*/
	function openRukuWin() {
		SL.showWindow({
			title : '添加信息',
			iconCls : 'icon-add',
			width : 380,
			height : 420,
			url : '../driver/toDriverAdd',
			onLoad : function() {
				loadCompanyBox('#companyId');
				loadCarNumBox('#carNumber');
				loadEquipmentBox('#deviceNum');
			},
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#comForm").form('enableValidation').form(
									'validate')) {
								ajaxSubmit();
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
	/**
	 编辑 
	 **/
	function editRow(id) {
		SL.showWindow({
			title : '编辑信息',
			iconCls : 'icon-add',
			width : 380,
			height : 420,
			url : '../driver/toDriverAdd',
			onLoad : function() {
				// 				loadCompanyBox('#companyId');
				// 				loadCarNumBox('#carNumber');
				// 				loadEquipmentBox('#deviceNum');
				$.ajax({
					type : "POST",
					url : '../driver/queryOne?id=' + id,
					async : false,
					cache : false,
					success : function(data) {
						$("#comForm").form('load', data);
					}
				});
			},
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#comForm").form('enableValidation').form(
									'validate')) {
								ajaxSubmit();
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
	/**
	 将form转为AJAX提交
	 **/
	function ajaxSubmit() {
		var url = "";
		if ($("#id").val().length <= 0) {
			url = '../driver/save';
		} else {
			url = '../driver/edit';
		}
		$.ajax({
			url : url,
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
</script>

</head>
<body class="easyui-layout">
	<div region="north"
		style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item" style="height: 38px;">
				<div id="cot">
					<div class="xia">
						车牌号:<input id="carID" name="carNumber" style="width: 150px" />
						司机姓名:<input id="driverName" name="driverName" style="width: 150px" />
						驾驶证号:<input id="drivingNo" name="drivingNo" style="width: 150px" />
						<a id="search_btn" href="#" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'">查询</a>
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