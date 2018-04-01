<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.o../html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设备管理</title>

<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/jsjs/ajaxfileupload.js"></script>


<script type="text/javascript">
	var grid;
	$(function() {

		loadJSPButton(27);

		loadDataGrid();

		$("#h_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});

		$("#rukuBtn").click(function() {
			openRukuWin();

		});
		//退回
		$("#backBtn").click(function() {
			backFun();

		});
		$("#chukuBtn").click(function() {
			chukuFun();
		});
		//编辑
		$("#editBtn").click(function() {
			editFun();
		});
		//导入excel
		$("#daoruBtn").click(function() {
			openExcel();
		});
		//导出excel
		$("#daochuBtn").click(function() {
			outExcel();
		});
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					packBm : $('#packBm').val(),
					listnum : $('#equitment').val(),
					simNumber : $('#simNumber').val(),
					lytime : $('#lytime').val(),
					lytime1 : $('#lytime1').val(),
					state : $('#state').combobox('getValue'),
					ustate : $('#ustate').combobox('getValue'),
					test : $('#test').combobox('getValue'),
					department : $("#h_department").combotree("getValue")
				}
			});
		});
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid').datagrid(
			{
				url : '../devices/list',
				fit : true,
				nowrap : true, // false:折行
				rownumbers : true, // 行号
				striped : true, // 隔行变色
				pagination : true,
				pageSize : 20,
				pageList : [ 10, 20, 30, 50, 100 ],
				loadMsg : '数据加载中,请稍后……',
				columns : [ [
						{
							field : 'ck',
							checkbox : true
						},
						{
							field : 'packBm',
							title : '箱号'
						},
						{
							field : 'state',
							title : '出库状态',
							align : 'center',
							formatter : function(value, row) {
								var s = "";
								// 					if (value == "0") {
								// 						s = "<span  style='color:red;'>已退回</span>";
								// 					} else
								if (value == "1") {
									s = "<span  style='color:green;'>已出库</span>";
								} else if (value == "2") {
									s = "<span  style='color:blue;'>未出库</span>";
								} else if (value == "3") {
									s = "<span  style='color:#FF0000;'>退回</span>";
								}
								return s;
							}
						},
						{
							field : 'ustate',
							title : '使用状态',
							align : 'center',
							formatter : function(value, row) {
								var s = "";
								if (value == "0") {
									s = "<div  style='background-color:#999999;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未使用</div>";
								} else if (value == "1") {
									s = "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>使用</div>";
								}
								return s;
							}
						},
						{
							field : 'listnum',
							title : '设备编号'
						},
						{
							field : 'simNumber',
							title : '默认卡号'
						},
						{
							field : 'departmentName',
							title : '库存网点'
						},
						{
							field : 'test',
							title : '测试',
							align : 'center',
							formatter : function(value, row, index) {
								var s = "";
								if (value == 1) {
									s = "已检测";
								} else if (value == 0) {
									s = "<span style=\"color:red;\">未检测</span>";
								}
								return s;
							}
						},
						{
							field : 'ustype',
							title : '用途'
						},
						{
							field : 'lyr',
							title : '领用人'
						},
						{
							field : 'lytime',
							title : '领用时间'
						},
						{
							field : 'remark',
							title : '备注'
						},
						{
							field : '_mx',
							title : '出入库明细',
							align : 'center',
							formatter : function(value, row, index) {
								var str = "";
								str += "<a href=\"javascript:void(0)\"><span  onclick=\"javaScript:isRecdFun('"
										+ row.listnum.replace(
												/\s+/g, "")
										+ "');\">明细</span></a>";
								return str;
							}
						} ] ],
				toolbar : '#td_toolbar',
				onLoadSuccess : function(data) {
					grid.datagrid('clearSelections');
					if (data.total == 0) {
						var body = $(this).data().datagrid.dc.body2;
						body
								.find('table tbody')
								.append(
										'<tr><td width="'
												+ body.width()
												+ '" style="height: 35px; text-align: center;"><h1>暂无数据</h1></td></tr>');
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
	/*入库批量、单加控制显示*/
	function closedDiv() {
		$('#listnum').show();
		$('#listdiv').hide();
	}
	function showDiv() {
		$('#listdiv').show();
		$('#listnum').hide();
	}
	/*弹出入库窗口*/
	function openRukuWin() {
		SL.showWindow({
			title : '设备入库信息',
			iconCls : 'icon-add',
			width : 500,
			height : 340,
			url : '../devices/toDeviceAdd',
			onLoad : closedDiv,
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#devPostForm").form('enableValidation')
									.form('validate')) {
								var data = $("#devPostForm").serialize();
								$.ajax({
									cache : false,
									type : "POST",
									url : '../devices/addDevices',
									data : data,
									async : false,
									dataType : 'json',
									success : function(data) {
										if (data.success) {
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
	/*退回方法*/
	function backFun() {
		var selRow = grid.datagrid("getSelections");// 返回选中多行
		if (selRow.length == 0) {
			$.messager.alert({
				title : '提示',
				msg : '未选中设备，请至少选择一行数据。',
				showType : 'slide',
				top : 200,
				left : 400
			});
			return;
		}
		var ids = [];
		for (var i = 0; i < selRow.length; i++) {
			if (selRow[i].state != "3") {
				var id = selRow[i].id;
				ids.push(id);
			}
		}
		if (ids.length == 0) {
			$.messager.alert({
				title : '提示',
				msg : '该设备已退出或未检测，请选择正确数据。',
				showType : 'slide',
				top : 200,
				left : 400
			});
			return;
		} else if (ids.length != selRow.length) {
			$.messager.alert({
				title : '提示',
				msg : '部分设备已退出或未检测，请选择正确数据。',
				showType : 'slide',
				top : 200,
				left : 400
			});
			return;
		} else {
			openBackWin(ids);
		}
	}/*弹出退回窗口*/
	function openBackWin(ids) {
		SL.showWindow({
			title : '设备出库信息',
			iconCls : 'icon-add',
			width : 420,
			height : 280,
			url : '../devices/toBack',
			onLoad : function() {
				$("#b_department").combotree({
					url : '../dep/getDepTree',
					required : true,
					lines : true
				}); 
			},
			buttons : [{
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#b_form").form('enableValidation').form('validate')) {
						var data = {
							ids : ids,
							state : '3',
							department : $('#b_department').combotree('getValue'),
							lyr : $('#peCombx').val(),
							lytime : $('#b_lytime').val(),
							remark : $('#remark').val(),
							site : $('#site').val()
						};
						$.ajax({
							cache : false,
							type : "POST",
							url : "../devices/outRep",
							data : data,
							dataType : "json",
							cache : false,
							success : function(data) {
								if (data) {
									SL.closeWindow();
									grid.datagrid('reload');
								}
							}
						});
					} else {
						alert("请填写完整信息");
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
	/*出库方法*/
	function chukuFun() {
		var selRow = grid.datagrid("getSelections");// 返回选中多行
		if (selRow.length == 0) {
			$.messager.alert({
				title : '提示',
				msg : '未选中设备，请至少选择一行数据。',
				showType : 'slide',
				top : 200,
				left : 400
			});
			return;
		}
		var ids = [];
		for (var i = 0; i < selRow.length; i++) {
			if (selRow[i].state != "1") {
				var id = selRow[i].id;
				ids.push(id);
			}
		}
		if (ids.length == 0) {
			$.messager.alert({
				title : '提示',
				msg : '该设备已出库或已使用或未检测，请选择正确数据。',
				showType : 'slide',
				top : 200,
				left : 400
			});
			return;
		} else if (ids.length != selRow.length) {
			$.messager.alert({
				title : '提示',
				msg : '部分设备已使用或已出库或未检测，将无法出库，请选择正确数据。',
				showType : 'slide',
				top : 200,
				left : 400
			});
			return;
		} else {
			openChukuWin(ids);
		}
	}
	/*弹出出库窗口*/
	function openChukuWin(ids) {
		SL.showWindow({
			title : '设备出库信息',
			iconCls : 'icon-add',
			width : 420,
			height : 280,
			url : '../devices/toChuKu',
			onLoad : function() {
				$("#ck_department").combotree({
					url : '../dep/getDepTree',
					required : true,
					lines : true
				});
				// 				loadPerNumBox();
			},
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#ckform").form('enableValidation').form(
									'validate')) {
								var param = {
									ids : ids,
									state : '1',
									department : $('#ck_department').combotree(
											'getValue'),
									lyr : $('#peCombx').val(),
									// 							lyr:$('#peCombx').combobox('getValue'),
									// 							lyrid : $('#lyrid').val(),
									lytime : $('#ck_lytime').val(),
									remark : $('#remark').val(),
									site : $('#site').val()
								};
								$.ajax({
									cache : false,
									type : "POST",
									url : "../devices/outRep",
									data : param,
									dataType : "json",
									cache : false,
									success : function(data) {
										if (data) {
											SL.closeWindow();
											grid.datagrid('reload');
										}
									}
								});
							} else {
								alert("请填写完整信息");
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
	function loadPerNumBox() {
		$('#peCombx').combogrid({
			required : true,
			panelWidth : 500,
			idField : 'realname',
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
					if (selectRow1 == null || t != selectRow1.realname) {//没有选择或者选项不相等时清除内容
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
				$('#lyrid').val(row.id);
			}
		});
	}
	/*弹出出入库记录*/
	function isRecdFun(id) {
		SL.showWindow({
			title : '出入库明细',
			width : 720,
			height : 380,
			url : '../devices/toDetails', 
			onLoad : function() {
				loadDetails(id);
			},
			buttons : [ {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	}
	function loadDetails(id) {
		$('#detailsGrid').datagrid({
			url : '../devices/getListRecd',
			method : 'POST',
			queryParams : {
				'listnum' : id
			},
			fit : true,
			striped : true,
			fitColumns : true,
			singleSelect : false,
			rownumbers : true,
			pagination : false,
			nowrap : false,
			pageSize : 10,
			pageList : [ 10, 20, 50, 100, 150, 200 ],
			showFooter : true,
			columns : [ [ {
				field : 'site',
				title : '库存网点'
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
			} ] ]
		});
	}
	// 导入excel
	function openExcel() {
		$("#picForm").form('clear');
		$('#uploadPicWindow').window('open');
	}
	// 导出excel
	function outExcel() {
		// 获取条件
		var param = $("#gridForm").serialize();// form序列化
		window.location.href = encodeURI("../excel/exporsb?" + param);
	}
	// 保存ecxel
	function submitPic() {
		if (!$("#picForm").form('validate')) {
			return false;
		}
		var f = $("#file").val();
		if (f == null || f == "") {
			$("#picTip").html("<span style='color:Red'>错误提示:上传文件不能为空,请重新选择文件</span>");
			return false;
		} else {
			var d1 = /\.[^\.]+$/.exec(f);
			if (d1 == ".xls") {
			} else {
				$("#picTip").html("<span style='color:Red'>错误提示:格式不正确,支持的格式为：xls！</span>");
				return false;
			}
		}
		ajaxFileUploadPic();
	}
	function ajaxFileUploadPic() {
		$.ajaxFileUpload({
			url : '../excel/updevices',// 用于文件上传的服务器端请求地址
			secureuri : false, // 一般设置为false
			fileElementId : 'file', // 文件上传空间的id属性 <input type="file" id="file"
			type : 'post',
			dataType : 'jsonp', // 返回值类型 一般设置为json
			success : function(data) {alert(data);
				// 服务器成功响应处理函数
				grid.datagrid('reload');
				$('#uploadPicWindow').window('close');
			}
		});
		return false;
	}
	function excelMB() {
		window.location.href = "../excel/DEVICE.xls";
	}
	/*编辑方法*/
	function editFun() {
		var selRow = grid.datagrid("getSelections");// 返回选中多行
		if (selRow.length != 1) {
			$.messager.alert({
				title : '提示',
				msg : '请选择一行数据。',
				showType : 'slide',
				top : 200,
				left : 400
			});
			return;
		}
		openeditWin(selRow[0]);
	}
	/*弹出编辑窗口*/
	function openeditWin(data) {
		SL.showWindow({
			title : '编辑设备信息',
			iconCls : 'pic_140',
			width : 420,
			height : 460,
			url : '../devices/toEdit',
			onLoad : function() {
				$("#d_department").combotree({
					url : '../dep/getDepTree',
					required : true,
					lines : true
				});
				
				$('#editform').form('load', data); 
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#editform").form('enableValidation').form('validate')) {
						var param = {
							id :  $("#devicesid").val(),  
							packBm : $('#d_packBm').val(), 
							state : $('#d_state').combobox('getValue'),
							ustate: $("#d_ustate").combobox('getValue'),
							listnum : $('#d_listnum').val(), 
							simNumber : $('#d_simNumber').val(), 
							department : $('#d_department').combobox('getValue'),
							test: $("#d_test").combobox("getValue"),
							ustype : $('#d_ustype').val(),  
							lyr : $('#d_lyr').val(),  
							lytime : $('#d_lytime').val(),  
							remark : $('#d_remark').val(), 
						};
						$.ajax({
							cache : false,
							type : "POST",
							url : "../devices/editDevices",
							data : param,
							dataType : "json",
							cache : false,
							success : function(data) {
								if (data) {
									SL.closeWindow();
									grid.datagrid('reload');
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
	<div region="north"
		style="height: 80px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						箱 号 ：<input id="packBm" name="packBm" style="width: 150px" class="easyui-textbox"
							data-options="prompt:'例如：HBC9,HBD1.以,分开'" /> 库存网点：<input
							id="h_department" name="department" style="width: 180px"
							data-options="prompt:'---请选择部门---'" /> 领用时间：<input id="lytime"
							 name="lytime" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input
							id="lytime1"  name="lytime1" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
					</div>
					<div class="xia">
						设备号：<input id="equitment" name="listnum" style="width: 150px" />
						SIM卡号： <input id="simNumber" name="simNumber" style="width: 180px" />
						出库： <select id="state" name="state" class="easyui-combobox"
							style="width: 100px;" editable="false">
							<option value=""></option>
							<option value="1">已出库</option>
							<option value="2">未出库</option>
							<option value="3">退回</option>
						</select> 使用：<select id="ustate" name="ustate" class="easyui-combobox"
							style="width: 100px;" editable="false">
							<option value=""></option>
							<option value="1">入网使用</option>
							<option value="0">未使用</option>
						</select> 测试：<select id="test" name="test" class="easyui-combobox"
							style="width: 100px;" editable="false">
							<option value=""></option>
							<option value="0">未测试</option>
							<option value="1">已测试</option>
						</select> <a id="search_btn" href="#" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'">查询</a>
					</div>
				</div>
			</div>
		</form>
	</div>
	<div region="center">
		<table id="listGrid"></table>
	</div>
	<div id="td_toolbar"></div>
	<!-- 导入Excel -->
	<div id="uploadPicWindow" class="easyui-window" title="设备入库导入" closed="true"
		style="width: 420px; height: 220px; padding: 20px; background: #fafafa;"
		data-options="iconCls:'icon-save',closable:true, collapsible:true,minimizable:true,maximizable:true">
		<form id="picForm" action="" method="post">
			<div id="picTip"></div>
			<div style="margin-bottom: 20px">
				选择文件: <input type="file" name="fileName" id="file" style="width: 80%" />
			</div>
			<a href="#" onclick="return excelMB();">导入模板下载</a>
			<div id="formWindowfooterPic1" style="padding: 5px; text-align: right;">
				<a href="#" onclick="submitPic();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">提交</a> 
				<!-- <input type="button" onclick="submitPic()" style="width: 60px;height: 35px;" value="确定" />  --> 
			</div>
		</form>
	</div>
</body>
</html>