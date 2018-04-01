<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公司信息管理</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	var grid;
	$(function() {
		loadDataGrid();

		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					compName : $('#compName').val()
				}
			});
			$('#gridForm').form('clear');
		});
	});
	/**
	 获取用户列表数据
	 **/
	function loadDataGrid() {
		grid = $("#listGrid").datagrid({ // title : '用户列表',
			method : 'post',
			url : '../company/list',
			loadMsg : '数据加载中....',
			fit : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			singleSelect : true,// 是否单选
			pagination : true,
			pageSize : 20,
			pageList : [ 10, 20, 30, 50 ],
			columns : [ [ {
				field : 'compName',
				title : '公司名称'
			}, {
				field : 'contactMenber',
				title : '联系人',
				width : 100
			}, {
				field : 'contactWay',
				title : '联系电话',
				width : 100
			}, {
				field : 'email',
				title : '邮箱',
				width : 100
			}, {
				field : 'mobile',
				title : '电话',
				width : 100
			}, {
				field : 'qq',
				title : 'QQ',
				width : 100
			}, {
				field : 'compAddress',
				title : '地址',
				width : 150
			},{
				field : 'sfbz',
				title : '收费标准',
				align : 'right',
				styler : function(value, row, index) {
					return 'color:red;';
				},
				formatter : function(val, row, index) {
					if(row.sfbz != null){
						return '&yen; ' + row.sfbz;
					}
					return "";

				}
			}, {
				field : 'opt',
				title : '操作',
				align : 'center',
				width : 150,
				formatter : function(value, row, index) {
					var s = "";
					s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:comInfo('" + row.id  + "');\">收费标准</span></a>";
					s += "&nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:editRow('" + row.id + "');\">编辑</span></a>";
					s += "&nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:removeIt('" + row.id + "');\">删除</span></a>";
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
			// pageSize : 20,
			// pageList : [ 1, 10, 15, 20, 30, 50 ],
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}
	/**
	 执行删除
	 **/
	function removeIt(id) {
		if (confirm("确定要删除该公司吗？")) {
			$.ajax({
				url : "../company/delete?id=" + id,
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
			title : '添加公司信息',
			iconCls : 'icon-add',
			width : 700,
			height : 500,
			url : '../company/toAddPage',
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#comForm").form('enableValidation').form('validate')) {
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
	function comInfo(id){
		SL.showWindow({
			title : '收费标准',
			iconCls : 'icon-add',
			width : 400,
			height : 150,
			url : '../company/toSfbzPage',
			onLoad : function() {
				$.ajax({
					type : "POST",
					url : '../company/queryOne?id=' + id,
					async : false,
					cache : false,
					success : function(data) {
						$("#comForm").form('load', data);
					}
				});
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#comForm").form('enableValidation').form('validate')) {
						$.ajax({
						url : "../company/sfbz",
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
	 编辑用户新
	 **/
	function editRow(id) {
		SL.showWindow({
			title : '编辑公司信息',
			iconCls : 'icon-add',
			width : 700,
			height : 500,
			url : '../company/toEditPage',
			onLoad : function() {

				$.ajax({
					type : "POST",
					url : '../company/queryOne?id=' + id,
					async : false,
					cache : false,
					success : function(data) {
						$("#comForm").form('load', data);
					}
				});
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#comForm").form('enableValidation').form('validate')) {
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
			url = '../company/save';
		} else {
			url = '../company/editCompany';
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
	<div region="north" style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item" style="height: 38px;">
				<div id="cot">
					<div class="xia">
						公司名称:<input id="compName" name="compName" style="width: 150px" />
						<!-- 组织机构代码:<input  id="organizationCode" name="organizationCode" style="width: 150px" />  -->
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