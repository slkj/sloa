<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
					transferType : $('#transferType').combobox('getValue'),
					endDate1 : $('#endDate1').val(),
					endDate2 : $('#endDate2').val(),
					carNumber : $('#cph').val()
				}
			});
			
		});		
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid')
				.datagrid(
						{
							url : '../transfer/list',
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
							columns : [ [
									{
										field : 'oldCarNumber',
										title : '车牌号',
										align : 'center',
										width : 100
									},
									{
										field : 'transferType',
										title : '异动类型',
										align : 'center',
										width : 80,
										formatter : function(value, rec) {
											if(value == '1') return '车辆过户';
											else if(value == '2') return '牌照变更';
											else return '';
										}
									},									
									{
										field : 'newCarNumber',
										title : '现车牌号',
										align : 'center',
										width : 90
									},
									{
										field : 'oldOwner',
										title : '原车主',
										align : 'center',
										width : 90
									},
									{
										field : 'newOwner',
										title : '现车主',
										align : 'center',
										width : 90
									},
									{
										field : 'oldPhone',
										title : '原联系方式',
										align : 'center',
										width : 100
									},
									{
										field : 'newPhone',
										title : '现联系方式',
										align : 'center',
										width : 100
									},
									{
										field : 'riqi',
										title : '日期',
										align : 'center',
										width : 80
									},									
									{
										title : '操作',
										field : '_options',
										align : 'center',
										width : 200,
										formatter : function(value, row, index) {
											var s = "";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:openWin(1);\">变更登记</span></a>";
											s += "&nbsp;|&nbsp;";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:openWin(2);\">编辑</span></a>";
											s += "&nbsp;|&nbsp;";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:remove();\">删除</span></a>";
											return s;
										}
									} ] ],
									/* toolbar : [ {
										text : '车辆变更登记',
										iconCls : 'icon-add',
										handler : function() {
											openWin(1);
										}
									} ], */
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
	/*弹出添加窗口*/
	function openWin(type) {
		SL.showWindow({
			title : '变更信息登记',
			iconCls : 'icon-add',
			width : 800,
			height : 500,
			top : 50,
			left : 100,
			url : '../transfer/transferAdd',
			onLoad : function() {
				loadCarNumOfTransfer('#carNumber');
				var row = $('#listGrid').datagrid('getSelected');
				if(type==2){				
				$('#postForm').form('load',row);
				}else{
					$('#carNumber').combogrid('setValue', row.oldCarNumber);
					$("#vId").val(row.vId);
				}
				
				/* loadProveBox('#number'); */
			},
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#postForm").form('enableValidation').form(
									'validate')) {
								var data = $("#postForm").serialize();
								if(type==1){
								$.ajax({
									cache : false,
									type : "POST",
									url : '../transfer/save',
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
								else{
									$.ajax({
										cache : false,
										type : "POST",
										url : '../transfer/edit',
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
	 function remove(){
			var row = $('#listGrid').datagrid('getSelected');
			if (row){
				$.messager.confirm('提示','确定要删除该记录吗?',function(r){
					if (r){
						$.ajax({
							url : "../transfer/delete?id=" + row.id,
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
	 function loadCarNumOfTransfer(id) {
			$(id).combogrid({
				delay:2000,
				/* required : true, */
				panelWidth : 500,
				idField : 'carNumber',
				textField : 'carNumber',
				url : '../vehicle/list',
				loadMsg : '数据加载中,请稍后……',
				onChange : function(newValue, oldValue) {
					artChanged = true;//记录是否有改变（当手动输入时发生)
				},
				columns : [ [ {
					field : 'carNumber',
					title : '车牌号',
					width : 50
				}, {
					field : 'carOwner',
					title : '户主',
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
							'carNumber' : q
						});
						$(this).combogrid('setValue', q);
					}
				},
				onSelect : function(index, row) {
					selectRow = row;
					$("#vId").val(row.id);
					$('#oldDevice1').textbox('setValue', row.equitment);
					$('#oldSIM1').textbox('setValue', row.simNumber);
					$('#oldCompany1').textbox('setValue', row.companyName);
					$('#oldOwner1').textbox('setValue', row.carOwner);
					$('#oldPhone1').textbox('setValue', row.contactsTel);
				}
			});
		}
</script>
</head>
<body class="easyui-layout">
	<div region="north"
		style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						车牌号：<input id="cph" style="width: 150px" /> 
						变更类型：	
							<select id="transferType"
					class="easyui-combobox" style="width: 150px;" editable="false">
						<option selected="selected" value=""></option>
						<option value="1">车辆过户</option>
						<option value="2">牌照变更</option>
				</select>					
						 日期：<input id="endDate1"
							class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input
							id="endDate2" class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" />
							 <a id="search_btn"
							href="#" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'">查询</a>
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