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
					carNumber : $('#carNumber').val(),
					carOwner : $('#carOwner').val(),
					yearExamE1 : $('#yearExamE1').val(),
					yearExamE2 : $('#yearExamE2').val()
				}
			});
			
		});		
	});

	/*加载数据*/
	function loadDataGrid() {
		grid = $('#listGrid')
				.datagrid(
						{
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
							rowStyler : function(index, row) {

								Date.prototype.diff = function(date) {
									return (this.getTime() - date.getTime())
											/ (24 * 60 * 60 * 1000);
								 }
								// 构造两个日期，分别是系统时间和2013/04/08 12:43:45
								var now = new Date();
								var date = new Date(row.yearExamE);
								// 调用日期差方法，求得参数日期与系统时间相差的天数
								var diff = now.diff(date);
								// 打印日期差
								//alert(Math.abs(diff));
								if (diff > 30){
									return 'background-color:pink;font-weight:bold;';									
								}
							}, 
							columns : [ [
									{
										field : 'carNumber',
										title : '车牌号',
										align : 'center',
										width : 100
									},
									{
										field : 'carOwner',
										title : '车主',
										align : 'center',
										width : 80
									},
									{
										field : 'contactsTel',
										title : '联系电话',
										align : 'center',
										width : 90
									},
									{
										field : 'yearExamS',
										title : '年审日期',
										align : 'center',
										width : 90
									},
									{
										field : 'yearExamE',
										title : '到期时间',
										align : 'center',
										width : 100
									},
									{
										title : '操作',
										field : '_opt',
										width : 170,
										align : 'center',
										formatter : function(value, row, index) {
											var s = "";
											s += "<a href=\"javascript:void(0)\"><span onclick=\"javaScript:openWin();\">到期处理</span></a>";
										
											return s;
										}
									} ] ],
							/* toolbar : [ {
										text : '年审到期',
										iconCls : 'icon-add',
										handler : function() {
											openWin();
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
	function openWin() {
		SL.showWindow({
			title : '年审到期登记',
			iconCls : 'icon-add',
			width : 450,
			height : 420,
			top : 50,
			left : 100,
			url : '../vehicle/yearExamAdd',
			onLoad : function() {
				var row = $('#listGrid').datagrid('getSelected');
				$('#postForm').form('load',row);
				
			},
			buttons : [
					{
						text : '确定',
						iconCls : 'icon-add',
						handler : function() {
							if ($("#postForm").form('enableValidation').form(
									'validate')) {
								var data = $("#postForm").serialize();
							
									$.ajax({
										cache : false,
										type : "POST",
										url : '../vehicle/editYearExam',
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
	

</script>
</head>
<body class="easyui-layout">
	<div region="north"
		style="height: 40px; border-bottom: 1px #a7b1c2 dashed; padding: 5px;">
		<form id="gridForm">
			<div class="item">
				<div id="cot">
					<div class="shang">
						车牌号：<input id="carNumber" style="width: 150px" /> 
						车主：<input id="carOwner" style="width: 150px" /> 
						 到期时间：<input id="yearExamE1"
							class="Wdate" type="text"
							onFocus="WdatePicker({isShowClear:false,readOnly:true})" /> - <input
							id="yearExamE2" class="Wdate" type="text"
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