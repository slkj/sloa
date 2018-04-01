<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单管理</title>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
	var grid;
	$(function() {
		grid = $('#listGrid').treegrid({
			url : '../module/list',
			loadMsg : '数据加载中....',
			fit : true,
			nowrap : true, //false:折行
			striped : true, //隔行变色
			// 			singleSelect : true, //单选
			checkOnSelect : true,
			idField : 'id',
			treeField : 'name',
			lines : true,
			animate : true,
			height : 450,
			columns : [ [ {
				field : 'name',
				title : '资源名称',
				width : 180
			}, {
				field : 'url',
				title : 'url'
			}, {
				field : 'icon',
				title : '图标'
			}, {
				field : 'description',
				title : '说明'
			}, {
				field : 'opt',
				title : '操作',
				width : 100,
				align : 'center',
				formatter : function(value, row) {
					var s = "";
					s += "<a href=\"javascript:void(0)\" onclick=\"editRow('" + row.id + "');\">编辑</a>";
					s += "|";
					s += "<a href=\"javascript:void(0)\" onclick=\"javaScript:deleteRow();\"> 删除 </a>";
					if (row.parent_id == "0") {
						return "";
					}
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
				// 				grid.treegrid('collapseAll');
				// 				grid.treegrid('expand', '1');//展开该节点
			}
		});
	});
	/*弹出入库窗口*/
	function openRukuWin() {
		SL.showWindow({
			title : '菜单信息',
			iconCls : 'icon-add',
			width : 400,
			height : 370,
			url : '../module/menusInfo',
			onLoad: function () {
				$("#p_menus").combotree({
					url : '../module/getCombotree',
					lines : true,
					required : true
				});
			},
			buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler : function() {
					if ($("#postForm").form('enableValidation').form('validate')) {
						$.ajax({
							cache : false,
							type : "POST",
							url : '../module/addModule',
							data : $("#postForm").serialize(),
							async : false,
							success : function(data) {
								SL.closeWindow();
								grid.treegrid('reload'); // 重新载入所有行
							}
						});

					}
				}
            }, {
                text: '关闭',
                iconCls: 'icon-cancel',
                handler: function () {
                    SL.closeWindow();
                }
            }]
		});
	}
	function deleteRow() {
		var node = grid.treegrid('getSelected');
		if (node) {
			var nodes = grid.treegrid('getChildren', node.id);
			if (nodes.length > 0) {
				alert("该项下包含内容不能执行删除操作！");
			} else if (confirm("确定要删除该菜单吗？")) {
				$.ajax({
					type : "POST",
					url : '../module/delModule',
					data : {
						id : node.id
					},
					cache : false,
					async : false,
					success : function(data) {
						grid.treegrid('reload');
					}
				});
			}
		}
	}
	function editRow(id) {
		SL.showWindow({
			title : '菜单信息',
			iconCls : 'icon-add',
			width : 500,
			height : 370,
			url : '../module/menusInfo',
			onLoad : function() {
				$("#p_menus").combotree({
					url : '../module/getCombotree',
					lines : true,
					required : true
				});
				$.ajax({
					type : "POST",
					url : '../module/queryOne/' + id,
					async : false,
					cache : false,
					success : function(data) {
						$("#postForm").form('load', data);
					}
				});
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					if ($("#postForm").form('enableValidation').form('validate')) {
						$.ajax({
							cache : false,
							type : "POST",
							url : '../module/editModule',
							data : $("#postForm").serialize(),
							async : false,
							success : function(data) {
								SL.closeWindow();
								grid.treegrid('reload'); // 重新载入所有行
							}
						});

					}
				}
			}, {
				text : '关闭',
				iconCls: 'icon-cancel',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	}

	//展开
	function redo() {

		var node = grid.treegrid('getSelected');//获取节点
		if (node) {
			grid.treegrid('expandAll', node.id);//展开该节点
		} else {
			grid.treegrid('expandAll');//展开所有节点
		}
	}
	//折叠
	function undo() {
		var node = grid.treegrid('getSelected');
		if (node) {
			grid.treegrid('collapseAll', node.id);
		} else {
			grid.treegrid('collapseAll');
		}
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center">
		<table id="listGrid"></table>
	</div>
</body>
</html>