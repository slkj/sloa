/*	function loadCompanyBox(id) {
		$(id).combogrid({
			delay:2000,
			required : true,
			panelWidth : 500,
			idField : 'compName',
			textField : 'compName',
			url : '../company/list',
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
//			onHidePanel : function() {
//				var t = $(this).combogrid('getValue');
//				if (artChanged) {
//					if (selectRow == null || t != selectRow.compName) {//没有选择或者选项不相等时清除内容
//						alert('请选择，不要直接输入');
//						$(this).combogrid('setValue', '');
//					} else {
//						//do something...
//					}
//				}
//				artChanged = false;
//				selectRow = null;
//			},
			columns : [ [ {
				field : 'compName',
				title : '公司名称',
				width : 50
			}, {
				field : 'contactMenber',
				title : '联系人',
				width : 50
			}, {
				field : 'contactWay',
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
						'compName' : q
					});
					$(this).combogrid('setValue', q);
				}
			},
			onSelect : function(index, row) {alert($('#companyId').val());
				selectRow = row;
				//$('#deviceId').textbox('setValue', row.equitment);
				$('#companyId').textbox('setValue', row.id);alert($('#companyId').val());
			}
		});
	}	*/
	function loadEquipmentBox(id) {
		$(id).combogrid({
			delay:2000,
			required : true,
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
//			onHidePanel : function() {
//				var t = $(this).combogrid('getValue');
//				if (artChanged) {
//					if (selectRow == null || t != selectRow.listnum) {//没有选择或者选项不相等时清除内容
//						alert('请选择，不要直接输入');
//						$(this).combogrid('setValue', '');
//					} else {
//						//do something...
//					}
//				}
//				artChanged = false;
//				selectRow = null;
//			},
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
			required : true,
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
//			onHidePanel : function() {
//				var t = $(this).combogrid('getValue');
//				if (artChanged) {
//					if (selectRow == null || t != selectRow.telnum) {//没有选择或者选项不相等时清除内容
//						alert('请选择，不要直接输入');
//						$(this).combogrid('setValue', '');
//					} else {
//						//do something...
//					}
//				}
//				artChanged = false;
//				selectRow = null;
//			},
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
	function loadProveBox(id) {
		$(id).combogrid({
			delay:2000,
			required : true,
			panelWidth : 350,
			idField : 'number',
			textField : 'number',
			url : '../prove/list',
			queryParams : {
				ustate : '0'
			},
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
//			onHidePanel : function() {
//				var t = $(this).combogrid('getValue');
//				if (artChanged) {
//					if (selectRow == null || t != selectRow.number) {//没有选择或者选项不相等时清除内容
//						alert('请选择，不要直接输入');
//						$(this).combogrid('setValue', '');
//					} else {
//						//do something...
//					}
//				}
//				artChanged = false;
//				selectRow = null;
//			},
			columns : [ [ {
				field : 'number',
				title : '证明编号',
				width : 100
			},{
				field : 'ustype',
				title : '使用类型',
				width : 80
			}, {
				field : 'ustate',
				title : '使用状态',
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
				$('#proverId').val(row.id);
			}
		});
	}	
	function loadCarNumBox(id) {
		$(id).combogrid({
			delay:2000,
			required : true,
			panelWidth : 500,
			idField : 'carNumber',
			textField : 'carNumber',
			url : '../vehicle/list',
			loadMsg : '数据加载中,请稍后……',
			onChange : function(newValue, oldValue) {
				artChanged = true;//记录是否有改变（当手动输入时发生)
			},
//			onHidePanel : function() {
//				var t = $(this).combogrid('getValue');
//				if (artChanged) {
//					if (selectRow == null || t != selectRow.carNumber) {//没有选择或者选项不相等时清除内容
//						alert('请选择，不要直接输入');
//						$(this).combogrid('setValue', '');
//					} else {
//						//do something...
//					}
//				}
//				artChanged = false;
//				selectRow = null;
//			},
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
				$('#owner').textbox('setValue', row.carOwner);
			}
		});
	}

	