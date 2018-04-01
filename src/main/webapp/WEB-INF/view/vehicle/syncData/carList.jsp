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
			columns : [ [ {
				field : 'carNumbe1r',
				title : '是否同步',
				align : 'center',
				formatter : function(value, row, index) {
					if (index % 2 == 0) {
						return "<div  style='background-color:gray;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>否</div>";
					}
					return "<div  style='background-color:green;text-align:center;margin:0px;padding:0px;color:#FFFFFF;'>是</div>";
				}
			}, {
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
			}, {
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
			}, {
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
				title : '操作',
				field : '_options',
				align : 'center',
				width : 200,
				formatter : function(value, row, index) {
					var s = "";
					s += "<a href=\"javascript:void(0)\" onclick=\"javaScript:syncRow('" + index + "');\"><span >同步</span></a>";
					return s;
				}
			} ] ],
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
	//同步窗口
	function syncRow(index) {
		var data = grid.datagrid('getData').rows[index];
		SL.showWindow({
			title : '-   车牌号：' + data.carNumber,
			width : 600,
			height : 360,
			url : '../vehicle/toSyncPage',
			onLoad : function() {
				$("#login_ex").click(function() {
					loginExlive();
				})
				$("#carName").textbox('setValue', data.carNumber);
				$("#gprs").textbox('setValue', data.equitment);
				$("#cpys").val(data.plateColor);
				$("#sim").textbox('setValue', data.simNumber);

			},
			buttons : [ {
				text : '同步',
				iconCls : 'icon-save',
				handler : function() {
					if($("#loginState").val() == 0){
						alert("未登录，请先登录");
						return ;
					}
					if ($("#postForm").form('enableValidation').form('validate')) {
						var data = $("#postForm").serialize();
						$.ajax({
							type : "POST",
							cache : false,
							url : '../exlive/addToExlive',
							data : data,
							async : false,
							success : function(data) {
								if (data.success) {
									SL.closeWindow();
									grid.datagrid('reload');
								} else {
									alert(data.msg);
								}
							}
						});

					}else{
						alert("请完善信息。");
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

	function loginExlive() {

		$.ajax({
			type : "POST",
			url : "../exlive/getGroup",
			cache : false,
			async : false,
			data : {
				serverId : $("#serverId").textbox('getValue'),
				userName : $("#userName").textbox('getValue'),
				userPwd : $("#userPwd").textbox('getValue')
			},
			dataType : "json",
			error : function(data) {
				alert('Error loading XML document' + data);
			},
			success : function(data) {
				$("#scuText").html("登录成功，请选择车辆分组信息。");
				$("#complb").combobox("loadData", data.listCom);
				$("#grouplb").combobox("loadData", data.listGroup);
				$("#loginState").val("1");
			}
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
</body>
</html>