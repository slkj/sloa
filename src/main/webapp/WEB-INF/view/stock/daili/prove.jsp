<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>证明管理</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript" src="../js/ajaxfileupload.js"></script>
<script type="text/javascript" src="../js/AjaxButtion.js"></script>
<script type="text/javascript">
	var grid;
	$(function() {

		loadJSPButton(31);

		loadDataGrid();

		$("#h_department").combotree({
			url : '../dep/getDepTree',
			lines : true
		});
		$('#ustype').combobox({
			url : '../data/ustypeJson.json',
			valueField : 'id',
			textField : 'text',
			panelHeight : 300,
			editable : false, // 不允许手动输入
			onLoadSuccess : function() { // 数据加载完毕事件
				$("#ustype").combobox('setText', '请选择');
			}
		});
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					number : $('#number').val(),
					ustype : $('#ustype').combobox('getValue'),
					carNumber : $('#carNumber').val(),
					ustate : $('#ustate').combobox('getValue'),
					state : $('#state').combobox('getValue'),
					department : $("#h_department").combotree("getValue"),
					startTime : $('#startTime').val(),
					endTime : $('#endTime').val()
				}
			});
			//	$('#gridForm').form('clear');
		});
	});
	function loadDataGrid() {
		grid = $('#listGrid').datagrid({
			method : 'post',
			url : '../prove/list',
			fit : true,
			fitColumns : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			pagination : true,
			// singleSelect : true,
			checkOnSelect : true,
			autoRowHeight : false,// 设置行的高度，根据该行的内容。设置为false可以提高负载性能。
			pageSize : 20,
			pageList : [ 10, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [ {
				field : 'ck',
				checkbox : true
			}, {
				field : '_img',
				title : '照片',
				align : 'center',
				formatter : function(value, row, index) {
					if (row.imgPath != null) {
						return "<a  href=\"javascript:void(0)\"  onclick=\"javaScript:showImg('" + index + "');\"><img  src=\"../images/img_inc.png\" /></a>";
					}
					return "";
				}
			}, {
				field : 'ustate',
				title : '使用状态',
				align : 'center',
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
			}, {
				field : 'ustype',
				title : '类型'
			}, {
				field : 'number',
				title : '编号'
			}, {
				field : 'state',
				title : '出库状态',
				align : 'center',
				formatter : function(value, row) {
					var s = "";
					if (value == "0") {
						s = "<span  style='color:blue;'>未出库</span>";
					} else if (value == "1") {
						s = "<span  style='color:green;'>已出库</span>";
					} else if (value == "2") {
						s = "<span  style='color:read;'>已回收</span>";
					}
					return s;
				}
			}, {
				field : 'usriqi',
				title : '出库日期'
			}, {
				field : 'departmentName',
				title : '领用部门'
			}, {
				field : 'usman',
				title : '领用人'
			}, {
				field : 'purpose',
				title : '用途',
				formatter : function(value, row, index) {
					var s = "";
					if (row.purpose == 1) {
						s = "续费";
					}
					if (row.purpose == 0) {
						s = "新装";
					}
					return s;
				}
			}, {
				field : 'carNumber',
				title : '车牌号'
			}, {
				field : 'remark',
				title : '备注'
			}, {
				field : 'fees',
				title : '是否收款',
				align : 'center',
				formatter : function(value, row, index) {
					var s = "";
					if (row.fees == 1) {
						s = "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>已收款</div>";
					}
					return s;
				}
			}, {
				field : 'payee',
				title : '收款人'
			}, {
				field : '_pp',
				title : '出入库明细',
				// width : 100,
				align : 'center',
				formatter : function(value, row, index) {
					var str = "";
					str += "<a href=\"javascript:void(0)\"><span  onclick=\"javaScript:isRecdFun('" + row.id + "');\">明细 </span></a>";
					// 					str += " <a href=\"javascript:void(0)\"><span  onclick=\"javaScript:canceled('" + row.id + "');\">详细</span></a>";
					// 					str += " | <a href=\"javascript:void(0)\"><span onclick=\"javaScript:editRow(" + index + ");\">编辑</span></a>";
					// 					str += " | <a href=\"javascript:void(0)\"><span  onclick=\"javaScript:canceled('" + row.id + "');\">作废</span></a>";
					return str;

				}
			} ] ],
			toolbar : '#td_toolbar',
			onLoadSuccess : function(data) {
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
			url : '../prove/toDetailsPage',
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
			url : '../prove/getListRecd',
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
						证明编号：<input id="number" name="number" style="width: 165px" /> 证明类型：<input id="ustype"
							name="ustype" style="width: 170px" /> 所在部门：<input id="h_department" name="department"
							style="width: 200px" data-options="prompt:'---请选择部门---'" /> 车辆牌号：<input id="carNumber"
							name="carNumber" style="width: 170px" />
					</div>
					<div class="xia">
						出库状态：<select id="state" class="easyui-combobox" name="state" style="width: 170px;">
							<option value=""></option>
							<option value="0">未出库</option>
							<option value="1">已出库</option>
							<option value="-1">已回收</option>
						</select> 使用状态：<select class="easyui-combobox" id="ustate" name="ustate" style="width: 170px;">
							<option value=""></option>
							<option value="0">未使用</option>
							<option value="1">已使用</option>
							<option value="3">已作废</option>
						</select> 领用时间：<input id="startTime" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input id="endTime"
							class="Wdate" type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> <a
							id="search_btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
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