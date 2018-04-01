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
			frozenColumns : [ [ {
				field : '_oo',
				title : '续费',
				align : 'center',
				formatter : function(value, row, index) {
					var str = "";
					str += " <a href=\"javascript:void(0)\"><span onclick=\"javaScript:pay('" + index + "',1);\">续费</span></a>";
					return str;
				}

			},{
				field : 'plateColor',
				title : '车牌颜色',
				align : 'center',
				formatter : function(value, row, index) {
					//0：蓝色  1：黄色  2：黑色 3：白色
					if (value == 0) {
						return "<div  style='background-color:blue;text-align:center;color:#FFFFFF;'>蓝色</div>";
					}
					if (value == 1) {
						return "<div  style='background-color:yellow;text-align:center;'>黄色</div>";
					}
					if (value == 2) {
						return "<div  style='background-color:black;text-align:center;color:#FFFFFF;'>黑色</div>";
					}
					if (value == 2) {
						return "<div  style='background-color:white;text-align:center;'>白色</div>";
					}
					
				}
			}, {
				field : 'carNumber',
				title : '车牌号'
			} ] ],
			columns : [ [ {
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
					// 					s += "<a href=\"javascript:void(0)\"  onclick=\"javaScript:pay('" + index + "',0);\"><span>入网登记</span></a>";
					// 					s += " &nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"  onclick=\"javaScript:infoRow('" + row.id + "',1);\"><span>详细</span></a>";
					//if($("#userDepart").val()==5){
					s += " &nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"  onclick=\"javaScript:editRow('" + row.id + "',2);\"><span>编辑</span></a>";
					s += " &nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\" onclick=\"javaScript:deleteRow('" + row.id + "');\"><span >删除</span></a>";
					//}		
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
		//top.addTab('编辑', '/WEB-INF/view/vehicle/toCarEdit?id=' + id);
		top.addTab('车辆详细信息', 'vehicle/vehicleInfo?id=' + id);
	}
	/*弹出入库窗口  车辆详细信息 */
	function editRow(id, bt) {
		//top.addTab('车辆详细信息', 'vehicle/toCarInfo?id=' + id);
		//window.location.href='../../WEB-INF/view/vehicle/carEdit.jsp?id=' + id;
		top.addTab('编辑', 'vehicle/vehicleEdit?id=' + id);
	}
	function pay(index, type) {
		var data = grid.datagrid('getData').rows[index];
		SL.showWindow({
			title : '-   车牌号：' + data.carNumber,
			width : 600,
			height : 400,
			url : '../fees/toFeesAdd',
			onLoad : function() {
				//$("#carNumber").textbox('setValue',data.carNumber);
				loadCarNumBox('#carNumber');
				loadProveBox('#number');
				if (type == 1) {
					$("input:radio[name='purpose'][value=1]").attr("checked", true);
				} else {
					$("input:radio[name='purpose'][value=0]").attr("checked", true);
				}
			},
			buttons : [ {
				text : '保存',
				iconCls : 'icon-save',
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
	/**
	 执行删除
	 **/
	function deleteRow(id) {
		if (confirm("确定要删除吗？")) {
			$.ajax({
				url : "../vehicle/delete?id=" + id,
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