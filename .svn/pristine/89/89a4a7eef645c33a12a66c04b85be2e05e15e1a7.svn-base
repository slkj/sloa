<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>维修</title>
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

		// 点击查询，根据条件检索
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				url : '../repair/list',
				queryParams : {
					carNumber : $('#cph').val(),
					guyName : $('#wxy').val(),
					wxTime : $('#repairTime').val(),
					wxTime1 : $('#repairTime1').val(),
					department : $("#h_department").combotree("getValue"),
					outcome : $('#outcome').combobox('getValue'),
					isLook : $('#isLook').combobox('getValue')
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
							url : '../repair/list',
							fit : true,
							fitColumns : true,
							nowrap : true, // false:折行
							rownumbers : true, // 行号
							striped : true, // 隔行变色
							pagination : true,
							singleSelect : true,
							checkOnSelect : true,
							autoRowHeight : false,// 设置行的高度，根据该行的内容。设置为false可以提高负载性能。
							pageSize : 15,
							pageList : [ 10, 15, 20, 30, 50, 100 ],
							loadMsg : '数据加载中,请稍后……',
							frozenColumns : [ [									
									{
										field : 'outcome',
										title : '维修结果',
										formatter : function(value, row, index) {
											if (row.outcome == '1') {
												return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>解决</div>";
											} else if (row.outcome == '0') {
												return "<div  style='background-color:red;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未解决</div>";
											}
										}
									},
									{
										field : 'isLook',
										title : '审核结果',
										align : 'center',
										formatter : function(value, row, index) {
											if (row.isLook == '1') {
												return '<span style="color:green;">已通过</span>';
											} else if (row.isLook == '0') {
												return '<span style="color:orange;">未审核</span>';
											}else if (row.isLook == '-1') {
												return '<span style="color:red;">未通过</span>';
											}
										}
									}, {
										field : 'carNumber',
										title : '车牌号'
									}, {
										field : 'guyName',
										title : '维修人'
									} ] ],
							columns : [ [ {
								field : 'cost',
								title : '收费金额'
							}, {
								field : 'wxTime',
								title : '维修时间'
							}, {
								field : 'site',
								title : '维修地点'
							},
							{
								field : 'operator',
								title : '录入员'
							}, {
								field : 'operatorTime',
								title : '录入时间'
							},{
								title : '操作',
								field : '_opt',
								width : 50,
								align : 'center',
								formatter : function(value, row, index) {
									var s = "";
									s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:openWin(2);\">编辑</span></a>";
									s += "&nbsp;|&nbsp;";
									s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:remove();\">删除</span></a>";
									return s;
								}
							}   ] ],
							toolbar : [ {
								text : '登记',
								iconCls : 'icon-add',
								handler : function() {
									openWin(1);
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
	
	
	/*弹出入库窗口*/
	function openWin(type) {
		SL.showWindow({
			title : '维修单',
			width : 720,
			height : 370,
			url : '../repair/toRepairAdd',
			onLoad : function() {
				loadUserNameBox();
				loadCarNumOfRepair('#carNumber');	
				loadEquipmentBox('#newdevice');
				loadSimBox('#newsim');
				if(type==2){			
					var row = $('#listGrid').datagrid('getSelected');
					$('#postForm').form('load',row);
				}else{
					loadRepairNumBox();
				}
			},
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#postForm").form('enableValidation').form(
									'validate')) {
								var data = $("#postForm").serialize();
								if(type==1){
								$.ajax({
									cache : false,
									type : "POST",
									url : '../repair/save',
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
							}else{
								$.ajax({
									cache : false,
									type : "POST",
									url : '../repair/edit',
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
	 执行删除
	 **/
	 function remove(){
			var row = $('#listGrid').datagrid('getSelected');
			if (row){
				$.messager.confirm('提示','确定要删除该记录吗?',function(r){
					if (r){
						$.ajax({
							url : "../repair/delete?id=" + row.id,
							success : function(result) {
								if (result) {
									grid.datagrid('load');
								}else{
									$.messager.show({
										title: 'Error',
										msg: result.msg
									});
								}
							}
						});
					}
				});
			}
		}
	 function loadCarNumOfRepair(id) {
			$(id).combogrid({
				delay:2000,
				/* required : true, */
				panelWidth : 500,
				idField : 'carNumber',
				textField : 'carNumber',
				url : '../vehicle/list',
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
					$("#carId").val(row.id);
					$('#olddevice').textbox('setValue', row.equitment);
					$('#oldsim').textbox('setValue', row.simNumber);					
				}
			});
		}
	function loadRepairNumBox() {
		var now = new Date();
		$('#repairNum').textbox("setValue",""+now.getFullYear()+(now.getMonth() + 1)
				+now.getDate()+now.getHours()+now.getMinutes()+now.getSeconds());
	}
	function loadUserNameBox() {
		/* $('#guy').combobox({
			url : '../user/queryAll',
			valueField : 'id',
			textField : 'realname',
			//required : true
			onSelect : function(index, row) {
					selectRow = row;
					$('#contact').textbox('setValue', row.phone);				
				}
		}); */
		$("#guyName").combogrid({
			delay:2000,
			panelWidth : 500,
			idField : 'realname',
			textField : 'realname',
			url : '../user/list',
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
			columns : [ [ {
				field : 'realname',
				title : '姓名',
				width : 50
			}, {
				field : 'phone',
				title : '联系方式',
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
				selectRow = row;
				$("#guy").val(row.id);
				$('#contact').textbox('setValue', row.phone);					
			}
		});
	}
	function loadEquipmentBox(id) {
		$(id).combogrid({
			delay:2000,
			//required : true,
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
	function loadSimBox(id) {
		$(id).combogrid({
			delay:2000,
			//required : true,
			panelWidth : 500,
			idField : 'telnum',
			textField : 'telnum',
			url : '../sim/list',
			queryParams : {
				state : '0'
			},
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
			columns : [ [ {
				field : 'telnum',
				title : 'SIM卡号',
				width : 50
			}, {
				field : 'ustate',
				title : '出库状态',
				width : 50,
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<span  style='color:blue;'>未出库</span>";
					} else if (value == "1") {
						s = "<span  style='color:green;'>已出库</span>";
					} else if (value == "2") {
						s = "<span  style='color:red;'>已回收</span>";
					}
					return s;
				}
			}, {
				field : 'state',
				title : '使用状态',
				width : 50,
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<div  style='background-color:#999999;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未用</div>";
					} else if (value == "1") {
						s = "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已用</div>";
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
						'telnum' : q
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
</script>
</head>

<body class="easyui-layout" data-options="fit:true">
		<div region="north"
		style="height: 60px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
			<form id="gridForm">
				车牌号：<input type="text" id="cph" style="width: 150px" /> 
				维修员： <input type="text" id="wxy" style="width: 150px"> 
				所属部门：<input
					id="h_department" name="department" style="width: 180px"
					data-options="prompt:'---请选择部门---'" /> 
				<br>	
				维修解决：<select id="outcome"
					class="easyui-combobox" style="width: 100px;">
					<option value=""></option>
					<option value="0">未解决</option>
					<option value="1">已解决</option>
				</select> 
				审核状态： <select id="isLook" class="easyui-combobox"
					style="width: 100px;">
					<option value=""></option>
					<option value="-1">未通过</option>
					<option value="1">已通过</option>
					<option value="0">未审核</option>
				</select> 
				维修时间： <input id="repairTime" class="Wdate" type="text"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input
					id="repairTime1" class="Wdate" type="text"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> 
					<a
					id="search_btn" href="#" class="easyui-linkbutton"
					iconCls="icon-search">查询</a>
			</form>
		</div>
	
	<div region="center">
		<table id="listGrid"></table>
	</div>
</body>
</html>