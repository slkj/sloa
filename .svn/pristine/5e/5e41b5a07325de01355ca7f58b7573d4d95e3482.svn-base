<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.o../html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SIM卡管理</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
<script type="text/javascript" src="../js/AjaxButtion.js"></script>
<script type="text/javascript">
	$(function() {
		loadJSPButton();
		loadDataGrid();
		$("#sim_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					telnum : $('#telnum').val(),
					lyr : $('#lyr').val(),
					state : $('#state').combobox('getValue'),
					ustate : $('#ustate').combobox('getValue'),
					department : $("#sim_department").combotree("getValue")
				}
			});
			//	$('#gridForm').form('clear');
		});
	});

	function loadJSPButton() {
		var button = loadButton(10);
		var str = "";
		$.each(button.mButton, function(i, o) {
			str += '<a id="'+o.url+'" href="#" ' + 'class="easyui-linkbutton" data-options="iconCls:\'' + o.icon + '\',plain:\'true\'">' + o.name + '</a>';
		});
		var targetObj = $("#td_toolbar").append(str);
		$.parser.parse(targetObj);
	}

	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			method : 'post',
			url : '../sim/list',
			fit : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			pagination : true,
			pageSize : 20,
			pageList : [ 10, 15, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				field : 'ustate',
				title : '出库状态',
				align : 'center',
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<span  style='color:green;'>未出库</span>";
					} else if (value == "1") {
						s = "<span  style='color:blue;'>已出库</span>";
					} else if (value == "2") {
						s = "<span  style='color:read;'>已回收</span>";
					}
					return s;
				}
			}, {
				field : 'state',
				title : '使用状态',
				align : 'center',
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<div  style='background-color:#999999;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>未用</div>";
					} else if (value == "1") {
						s = "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已用</div>";
					}
					return s;
				}
			}, {
				field : 'telnum',
				title : 'SIM号码'
			}, {
				field : 'lyr',
				title : '领用人'
			}, {
				field : 'departmentName',
				title : '领用部门'
			}, {
				field : 'outtime',
				title : '领用时间',
				sortable : true,
				order : 'desc',
			}, {
				field : 'lrr',
				title : '操作人'
			}, {
				field : 'remark',
				title : '备注'
			}, {
				field : 'opt',
				title : '出入库明细',
				align : 'center',
				formatter : function(value, row, index) {
					var str = "";
					str += "<a href=\"javascript:void(0)\"><span  onclick=\"javaScript:isRecdFun('" + row.telnum + "');\">明细 </span></a>";
					return str;
				}
			}] ],
			toolbar : '#td_toolbar',
			onLoadSuccess : function() {
				grid.datagrid('clearSelections');
				if (data.total == 0) {
					var body = $(this).data().datagrid.dc.body2;
					body.find('table tbody').append('<tr><td width="' + body.width() + '" style="height: 35px; text-align: center;"><h1>暂无数据</h1></td></tr>');
				}
			}
		});
		// 设置分页控件
		grid.datagrid('getPager').pagination({
			beforePageText : '第',// 页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}
	/*弹出出入库记录*/
	function isRecdFun(id) {
		SL.showWindow({
			title : '出入库明细',
			width : 720,
			height : 380,
			url : '../sim/toDetails', 
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
			url : '../sim/getListRecd',
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
</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 80px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						所在部门：<input id="sim_department" name="department" class="easyui-textbox" style="width: 150px"
							data-options="prompt:'SIM卡现存放部门'" /> 出库状态: <select id="ustate" name="ustate"
							class="easyui-combobox" style="width: 150px;" editable="false">
							<option value=""></option>
							<option value="1">已出库</option>
							<option value="2">未出库</option>
							<option value="3">退回</option>
						</select> 使用状态: <select class="easyui-combobox" id="state" name="state" panelheight="auto"
							style="width: 150px">
							<option value=""></option>
							<option value="1">已用</option>
							<option value="0">未用</option>
						</select>
					</div>
					<div class="xia">
						SIM号码：<input id="telnum" name="telnum" style="width: 150px" /> 领用人 ：<input id="lyr"
							name="lyr" style="width: 150px" /> <a id="search_btn" href="#" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'">查询</a>
					</div>
				</div>
			</div>
			<!--表格DIV结束-->
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
		<form id="picForm" enctype="multipart/form-data" method="post">
			<!-- <div id="picTip"></div> -->
			<div style="margin-bottom: 20px">
				选择文件: <input type="file" name="file" id="file" style="width: 80%" />
			</div>
			<a href="#" onclick="return excelMB();">导入模板下载</a>
			<div id="formWindowfooterPic1" style="padding: 5px; text-align: right;">
				<a href="#" onclick="submitPic();" class="easyui-linkbutton" data-options="iconCls:'icon-save'">提交</a>
			</div>
		</form>
	</div>
</body>
</html>