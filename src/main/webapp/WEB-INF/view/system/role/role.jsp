<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
	var $grid;
	$(function() {
		loadDataGrid();
	});
	function loadDataGrid() {
		$grid = $('#listGrid').datagrid({
			method : 'post',
			url : '../role/list',
			fit : true,
			nowrap : true, // false:折行
			rownumbers : true, // 行号
			striped : true, // 隔行变色
			singleSelect : true,// 是否单选
			pagination : true,
			pageSize : 15,
			pageList : [ 10, 15, 20, 30, 50, 100 ],
			loadMsg : '数据加载中,请稍后……',
			columns : [ [ {
				title : '角色名称',
				field : 'name',
				width : 150
			}, {
				title : '资源描述',
				field : 'dscript',
				width : 220
			}, {
				field : 'opt',
				title : '操作',
				align : 'center',
				formatter : function(value, row, index) {
					var s = "";
					s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:delRow('" + index + "');\">删除</span></a>";
					s += "&nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:editFun('" + index + "');\">编辑</span></a>";
					s += "&nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:loadUser('" + index + "');\">用户</span></a>";
					s += "&nbsp;|&nbsp;";
					s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:loadModlue('" + index + "');\">设置权限</span></a>";
					return s;
				}
			} ] ],
			toolbar : [ {
				id : '',
				text : '添加',
				iconCls : 'icon-add',
				handler : function() {
					addFun();
				}
			} ],
			onLoadSuccess : function() {
				$('#listGrid').datagrid('clearSelections');
			}
		});
		// 设置分页控件
		$grid.datagrid('getPager').pagination({
			beforePageText : '第',// 页数文本框前显示的汉字
			afterPageText : '页    共 {pages} 页',
			displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}
	function addFun() {
		SL.showWindow({
			title : '角色信息',
			iconCls : 'icon-add',
			width : 500,
			height : 260,
			url : '../role/roleInfo',
			left : 100,
			top : 100,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					// 保存数据
					fCallback("../role/save");
				}
			}, {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	};
	/**
	 * 弹出编辑窗口
	 */
	function editFun(index) {
		var data = $grid.datagrid('getData').rows[index];
		SL.showWindow({
			title : '编辑角色信息',
			iconCls : 'icon-add',
			width : 500,
			height : 260,
			url : '../role/roleInfo',
			onLoad : function() {
				// 先加载数据
				$("#roleForm").form('load', data);
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					// 保存数据
					fCallback("edit");
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
	 * ajax保存角色信息
	 */
	function fCallback(url) {
		if ($("#comForm").form('enableValidation').form('validate')) {
			var data = $("#roleForm").serialize();
			$.ajax({
				cache : false,
				type : "POST",
				url : url,
				data : data,
				async : false,
				success : function(data) {
					if (data) {
						$grid.datagrid('reload');// 刷新datagrid
						SL.closeWindow();
					} else {
						SL.sysSlideShow({
							title : 'Error',
							msg : "出现异常。"
						});
					}
				}
			});
		}
	}
	/* 加载角色下用户列表 */
	function loadUser(index) {
		var data = $grid.datagrid('getData').rows[index];
		$('#right-panel').panel({
			title : "[" + data.name + "]-用户列表",
			href : '../role/allotUser',
			onLoad : function() {
				$('#userdg').datagrid({
					url : '../user/listByRole?id=' + data.id,
					loadMsg : '数据加载中....',
					fit : true,
					rownumbers : true, // 行号
					pagination : true,
					pageSize : 20,
					pageList : [ 1, 10, 15, 20, 30, 50 ],
					columns : [ [ {
						field : 'username',
						title : '用户名',
						width : 120
					}, {
						field : 'realname',
						title : '姓名',
						width : 120
					}, {
						field : '_cd',
						title : '所属公司/部门',
						formatter : function(value, row, index) {
							var str = row.companyName == null ? row.departName : row.companyName;
							return str;
						}
					} ] ]
				});
				// 设置分页控件
				$('#userdg').datagrid('getPager').pagination({
					beforePageText : '第',// 页数文本框前显示的汉字
					afterPageText : '页    共 {pages} 页',
					displayMsg : ' {from} - {to} 共 {total} 条'
				});
			}
		});
	}
	/* 加载角色功能权限列表 */
	function loadModlue(index) {
		var data = $grid.datagrid('getData').rows[index];
		$("#roleId").val(data.id);
		$('#right-panel').panel({
			title : "[" + data.name + "]:当前权限",
			href : '../role/allotRes',
			onLoad : function() {
				$('#reslist').tree({
					url : '../module/role2Module?roleId=' + data.id,
					loadMsg : '数据加载中....',
					lines : true,
					checkbox : true
				});
			}
		});
	}
	/* 删除角色 */
	function delRow(index) {
		var data = $grid.datagrid('getData').rows[index];
		$.messager.confirm('提示', '请检查该角色下用户,删除后拥有该角色用户将无法获取功能权限。', function(r) {
			if (r) {
				$.ajax({
					url : "../role/delete?id=" + data.id,
					success : function(data) {
						if (data) {
							$grid.datagrid('reload');
						} else {
							$.messager.show({
								title : 'Error',
								msg : '不好意思，出错了！'
							});
						}
					}
				});
			}
		});
	}
	/* 保存权限设置 */
	function roleModule() {
		var nodes = $('#reslist').tree('getChecked', [ 'checked', 'indeterminate' ]);
		var ids = [];
		for (var i = 0; i < nodes.length; i++) {
			ids.push(nodes[i].id);
		}
		if (ids.length > 0) {
			var param = {
				roleid : $("#roleId").val(),
				ids : ids
			};
			$.ajax({
				url : "../role/saveRoleRes",
				type : "POST",
				data : param,
				async : false,
				dataType : "json",
				cache : false,
				success : function(data) {
					if (data) {
						$.messager.show({
							msg : '设置成功！'
						});
						;
					} else {
						$.messager.show({
							title : 'Error',
							msg : '不好意思，出错了！'
						});
					}
				}
			});
		} else {
			alert("请选择分配资源!");
		}
	}
</script>
</head>
<body class="easyui-layout">
	<input id="roleId" type="hidden" />
	<div region="center">
		<div class="easyui-layout" fit="true">
			<div data-options="region:'center'" style="padding: 1px;">
				<table id="listGrid"></table>
			</div>
			<div id="right-panel" data-options="region:'east',title:'权限设置',split:true" style="width: 400px;">
			</div>
		</div>
	</div>
</body>
</html>