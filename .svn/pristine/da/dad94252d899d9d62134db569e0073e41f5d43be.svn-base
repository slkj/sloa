<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>神龙科技智能办公系统</title>
<%@ include file="/common/taglibs.jsp"%>

<script type="text/javascript">
	var grid;
	$(function() {
		loadDataGrid();
		$("#search_btn").click(function() {
			$('#listGrid').datagrid({
				queryParams : {
					username : $('#username').val(),
					realname : $('#realname').val(),
					status : $('#statusSelect').val()
				}
			});
		});
	});
	/* 获取用户列表数据 */
	function loadDataGrid() {
		grid = $("#listGrid")
				.datagrid(
						{
							method : 'post',
							url : '../user/list',
							loadMsg : '数据加载中....',
							fit : true,
							nowrap : true, // false:折行
							rownumbers : true, // 行号
							striped : true, // 隔行变色
							singleSelect : true,// 是否单选
							pagination : true,
							pageSize : 20,
							pageList : [ 10, 20, 30, 50 ],
							columns : [ [
									{
										field : 'ck',
										checkbox : true
									},
									{
										title : '状态',
										field : 'status',
										formatter : function(value, rec) {
											return value == 'enabled' ? '启用'
													: '<span style="color:red">禁用</span>';
										}
									},
									{
										title : '用户名',
										field : 'username',
										width : 100
									},

									{
										title : '姓名',
										field : 'realname',
										width : 150
									},
									{
										title : '联系方式',
										field : 'phone'
									},
									{
										field : 'departName',
										title : '所属部门'
									},
									{
										title : '最后登录',
										field : 'lastTime'
									},
									{
										title : '创建时间',
										field : 'create_time'
									},
									{
										title : '操作',
										field : '_opt',
										width : 170,
										align : 'center',
										formatter : function(value, row, index) {
											var s = "";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:editUser();\">编辑</span></a>";
											s += "&nbsp;|&nbsp;";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:removeUser();\">删除</span></a>";
											return s;
										}
									} ] ],
							toolbar : '#toolbar',
							onLoadSuccess : function() {
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
	function removeUser(){
		var row = $('#listGrid').datagrid('getSelected');
		if (row){
			$.messager.confirm('提示','确定要删除该用户吗?',function(r){
				if (r){
					$.ajax({
						url : "../user/delete?id=" + row.id,
						success : function(result) {
							if (result) {
								grid.datagrid('load');
							}else{
								$.messager.show({
									title: 'Error',
									msg: result.msg
								});
							}
						}
					});
				}
			});
		}
	}
	var url;
	function newUser(){
		$('#dlg').dialog('open').dialog('setTitle','新增用户');
		$('#fm').form('clear');
		$('#roleId').combobox({
			url : '../role/queryAll',
			valueField : 'id',
			textField : 'name',
			required : true
		});
		$("#depCombobox").combotree({
			url : '../dep/getDepTree',
			lines : true,
			required : true
		});
		url = '../user/save';
	}
	function editUser(){
		var row = $('#listGrid').datagrid('getSelected');
		if (row){
			$('#dlg').dialog('open').dialog('setTitle','编辑用户');
			$('#roleId').combobox({
				url : '../role/queryAll',
				valueField : 'id',
				textField : 'name',
				required : true
			});
			$("#depCombobox").combotree({
				url : '../dep/getDepTree',
				lines : true,
				required : true
			});
			
			
			$('#fm').form('load',row);
			url = '../user/editUser';
		}
	}
	function saveUser(){
		$.ajax({
			url : url,
			type : "POST",
			data : $('#fm').serialize(),
			success: function(result){
				if (result.success){
					$('#dlg').dialog('close');
					$('#listGrid').datagrid('reload');
				} else {
					$.messager.show({
						title: 'Error',
						msg: result.msg
					});
				}
			}
		});
		
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center">
		<table id="listGrid"></table>
	</div>
		<div id="toolbar">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新 增</a> 
<!-- 			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编 辑</a>  -->
<!-- 			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">移 除</a> -->
				
			<span>丨用户名: </span> <input id="username" class="easyui-textbox" style="width: 150px"> 
			姓名：<input id="realname" class="easyui-textbox" style="width: 150px">
			状态: <select id="statusSelect">
					<option value="enabled">启用</option>
					<option value="disabled">禁用</option>
				</select> 
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" id="search_btn">查询</a>
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
						<li><span class="ttl">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</span> <label> <input name="sex" type="radio" value="男"
								checked="checked" />男
						</label> <label><input name="sex" type="radio" value="女" />女</label></li>
						<li><span class="ttl">联系电话：</span><input name="phone" style="width: 70%;" /></li>
						<li><span class="ttl">电子邮件：</span><input name="email" style="width: 70%;" /></li>
						<li><span class="ttl">联系地址：</span><input name="address" style="width: 70%;" /></li>
						<li><span class="ttl">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：</span> <input name="remark" data-options="multiline:true"
							style="height: 60px; width: 70%" /></li>
					</ul>
				</form>
			</div>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a> 
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
	</div>
</body>
</html>