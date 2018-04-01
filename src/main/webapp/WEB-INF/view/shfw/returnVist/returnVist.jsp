<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
	var grid;
	$(function() {
		loadDataGrid();

		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					carNumber : $('#carNumber').val(),
					carcompany : $('#carcompany').val(),
					callman : $('#callman').val(),
					calltime : $('#calltime').val(),
					calltime1 : $('#calltime1').val()
				}
			});
			$('#gridForm').form('clear');
		});
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid')
				.datagrid(
						{
							url : '../returnVist/list',
							fit : true,
							// fitColumns : true,
							nowrap : true, // false:折行
							rownumbers : true, // 行号
							striped : true, // 斑马线
							autoRowHeight : false,// 设置行的高度
							pagination : true,
							// checkOnSelect : false,
							pageSize : 20,
							pageList : [ 10, 20, 30, 50, 100 ],
							loadMsg : '数据加载中,请稍后……',
							frozenColumns : [ [ {
								field : 'carNumber',
								title : '车牌号',
								align : 'center',
								width : 100
							}, {
								field : 'cartype',
								title : '车辆类型',
								align : 'center',
								width : 100
							}, {
								field : 'carman',
								title : '联系人',
								align : 'center',
								width : 80
							}, {
								field : 'carphone',
								title : '联系电话',
								align : 'center',
								width : 90
							}, {
								field : 'carcompany',
								title : '所属公司',
							}, ] ],
							columns : [ [
									{
										field : 'fromphone',
										title : '回访电话号码',
									},
									{
										field : 'causes',
										title : '回访原因',
									},
									{
										field : 'calltime',
										title : '回访时间',
									},
									{
										field : 'callman',
										title : '回访员',
									},
									{
										field : 'carstate',
										title : '接听状态',
										formatter : function(value, row) {
											var s = "";
											if (value == "0") {
												s = "<span  style='color:green;'>正常</span>";
											} else if (value == "1") {
												s = "<span  style='color:blue;'>未接通</span>";
											} else if (value == "2") {
												s = "<span  style='color:red;'>空号</span>";
											}
											return s;
										}
									},
									{
										field : 'advice',
										title : '反馈意见',
									},
									{
										title : '操作',
										field : '_options',
										align : 'center',
										width : 110,
										formatter : function(value, row, index) {
											var s = "";
											//s += "<a href=\"javascript:void(0)\"  onclick=\"javaScript:editRow('" + row.id + "');\"><span>编辑</span></a>";
											//s += " &nbsp;|&nbsp;";
											s += "<a href=\"javascript:void(0)\" onclick=\"javaScript:deleteRow('"
													+ row.id
													+ "');\"><span >删除&nbsp&nbsp&nbsp</span></a>";
											return s;
										}
									} ] ],
							toolbar : [ {
								text : '新增',
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
			title : '客户回访信息',
			iconCls : 'icon-add',
			width : 700,
			height : 420,
			url : '../returnVist/toReturnVistAdd',
			onLoad : function() {
				loadCarNumBox();
			},
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#postForm").form('enableValidation').form(
									'validate')) {
								var data = $("#postForm").serialize();
								$.ajax({
									cache : false,
									type : "POST",
									url : '../returnVist/insert',
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
				field : 'carType',
				title : '车辆类型',
				width : 50
			}, {
				field : 'contacts',
				title : '联系人',
				width : 50
			}, {
				field : 'contactsTel',
				title : '联系电话',
				width : 50
			}, {
				field : 'companyName',
				title : '所属公司',
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
				$('#cartype').textbox('setValue', row.carType);
				$('#carman').textbox('setValue', row.contacts);
				$('#carphone').textbox('setValue', row.contactsTel);
				$('#carcompany1').textbox('setValue', row.companyName);
			}
		});
	}
	/**
	 执行删除
	 **/
	function deleteRow(id) {
		if (confirm("确定要删除该记录吗？")) {
			$.ajax({
				url : "../returnVist/delete?id=" + id,
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
	<div region="north"
		style="height: 105px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot"><br/>
					<div class="shang">
						车牌号：<input id="carNumber" style="width: 150px" /> 所属公司：<input
							id="carcompany" style="width: 180px" /> 回访员：<input id="callman"
							style="width: 180px" />
					</div>
					<div class="xia">
						<br /> 回访时间：<input id="calltime" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input
							id="calltime1" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> <a
							id="search_btn" href="#" class="easyui-linkbutton"
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