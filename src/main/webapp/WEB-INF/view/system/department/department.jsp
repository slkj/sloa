<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门管理</title>
<%@ include file="/common/taglibs.jsp"%>
<script type="text/javascript">
	var $grid;
	$(function() {
		$grid = $('#listGrid').treegrid({
			url : '../dep/list',
			loadMsg : '数据加载中....',
			fit : true,
			nowrap : true, //false:折行
			striped : true, //隔行变色
			// 			singleSelect : true, //单选
			checkOnSelect : true,
			idField : 'id',
			treeField : 'd_name',
			lines : true,
			animate : true,
			height : 450,
			columns : [ [ {
				field : 'd_name',
				title : '部门 名 称',
				width : 180
			}, {
				field : 'd_fuzeren',
				title : '负责人'
			}, {
				field : 'd_tel',
				title : '联系电话'
			}, {
				field : 'd_fax',
				title : '传真'
			}, {
				field : 'd_email',
				title : 'Email'
			}, {
				field : 'd_add',
				title : '地址'
			}, {
				field : 'opt',
				title : '操作',
				width : 100,
				align : 'center',
				formatter : function(value, row) {
					var s = "";
					s += "<a href=\"javascript:void(0)\" onclick=\"editData('" + row.id + "');\">编辑</a>";
					s += "|";
					s += "<a href=\"javascript:void(0)\" onclick=\"javaScript:removeIt();\"> 删除 </a>";
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
					openWin();
				}
			} ],
			onLoadSuccess : function() {
			}
		});
	});
	/*弹出入库窗口*/
	function openWin(id) {
		SL.showWindow({
			title : '添加部门信息',
			iconCls : 'icon-add',
			width : 500,
			height : 370,
			url : 'depInfo',
			onLoad : function() {
				$("#p_dep").combotree({
					url : '../dep/getDepTree',
					lines : true,
					required : true
				});
				if (typeof (id) != "undefined") {
					$.ajax({
						type : "POST",
						url : '../dep/queryOneDep?id=' + id,
						async : false,
						cache : false,
						success : function(data) {
							$("#postForm").form('load', data);
						}
					});
				}
			},
			buttons : [ {
				text : '确定',
				iconCls : 'icon-add',
				handler : function() {
					saveAjax();
				}
			}, {
				text : '关闭',
				handler : function() {
					SL.closeWindow();
				}
			} ]
		});
	}
	function editData(id) {
		openWin(id);
	}
	//执行删除
	function removeIt() {
		var node = $grid.treegrid('getSelected');
		if (node) {
			var nodes = $grid.treegrid('getChildren', node.id);
			if (nodes.length > 0) {
				$.messager.alert('提示', '该项下包含级部门不能执行删除操作！"');
			} else {
				$.messager.confirm('提示', '确定要删除该部门吗?', function(r) {
					if (r) {
						$.ajax({
							url : '../dep/delDep?id=' + node.id,
							success : function(result) {
								if (result) {
									$grid.treegrid('reload');
								} else {
									$.messager.show({
										title : 'Error',
										msg : result.msg
									});
								}
							}
						});
					}
				});
			}
		}
	}
	function saveAjax() {
		var url = "";
		if ($("#depid").val().length <= 0) {
			url = '../dep/saveDep';
		} else {
			url = '../dep/editDep';
		}
		if ($("#postForm").form('enableValidation').form('validate')) {
			$.ajax({
				cache : false,
				type : "POST",
				url : url,
				data : $("#postForm").serialize(),
				async : false,
				success : function(result) {
					if (result.success) {
						$grid.treegrid('reload');
						SL.closeWindow();
					} else {
						$.messager.show({
							title : 'Error',
							msg : result.msg
						});
					}
				}
			});

		}
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center">
		<table id="listGrid"></table>

	</div>
	<div id="dlg" class="easyui-dialog" style="width: 400px; height: 440px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="pop_cont_input">
			<form id="fm" metdod="post">
				<input id="id" name="id" type="hidden" />
				<ul class="ulColumn2">
					<li><span> 用 户 名 ：</span><input name="username" type="text" style="width: 70%;" /></li>
					<li><span> 角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</span><input id="roleId" name="roleId" style="width: 70%;" /></li>
					<li><span class="ttl">所属部门：</span><input id="depCombobox" name="departcode" style="width: 70%;"></input></li>
					<!-- 					<li><span class="ttl">职务：</span><input name="office" style="width: 70%;"></li> -->
					<li><span class="ttl">真实姓名：</span><input name="realname" style="width: 70%;"></li>
					<li><span class="ttl">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</span> <label> <input name="sex" type="radio" value="男" checked="checked" />男
					</label> <label><input name="sex" type="radio" value="女" />女</label></li>
					<li><span class="ttl">联系电话：</span><input name="phone" style="width: 70%;" /></li>
					<li><span class="ttl">电子邮件：</span><input name="email" style="width: 70%;" /></li>
					<li><span class="ttl">联系地址：</span><input name="address" style="width: 70%;" /></li>
					<li><span class="ttl">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</span> <input name="remark" data-options="multiline:true" style="height: 60px; width: 70%" /></li>
				</ul>
			</form>
		</div>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a> <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>
</body>
</html>