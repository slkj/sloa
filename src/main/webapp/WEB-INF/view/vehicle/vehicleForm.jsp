<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/common/taglibs.jsp"%>
<link href="${pageContext.request.contextPath}/css/StyleSheet.css" rel="stylesheet" />
<script type="text/javascript">
	var $form;
	var pkey;
	var mode;
	var upUrl = getContextPath() + '/vehicle/save';
	var imageUploadDialog;
	var carOwnerPhotoFilePath; //车主照片 文件路径
	var carPhotoFilePath; //车辆照片 文件路径
	var certificatePhotoFilePath; //车辆合格证照片路径
	var certificatePhoto2FilePath; //车辆合格证2照片路径
	var driverPhotoFilePath; //行驶证照片路径
	var comCode;
	$(function() {
		$form = $("#form");
		newOrEidt()
		$('#carAddCounty').combobox('reload', getContextPath() + '/company/queryComList');

	});
	function newOrEidt() {
		pkey = getUrlParam("pkey");
		mode = getUrlParam("mode");
		if (mode) {
			$(".show").each(function() {
				$(this).hide();
			});
		}
		if (pkey) {
			upUrl = getContextPath() + '/vehicle/edit';
			$.ajax({
				type : "post",
				dataType : "json",
				url : '../vehicle/queryOne?id=' + pkey,
				async : true,
				success : function(result) {
					if (result) {
						$form.form("load", result);
					} else {
						showError("系统异常");
					}
				}
			})
		}
	}
	function back() {
		self.location.href = getContextPath() + "/vehicle/vehicleListPage";
	}
	function save() {

		//校验
		var validate = $form.form('validate');
		if (validate == false) {
			return validate;
		}

		var data = serializeObject($form);
		if (carOwnerPhotoFilePath) {
			data.carOwnerPhoto = carOwnerPhotoFilePath;
		}
		if (carPhotoFilePath) {
			data.carPhoto = carPhotoFilePath;
		}
		if (certificatePhotoFilePath) {
			data.certificatePhoto = certificatePhotoFilePath;
		}
		if (certificatePhoto2FilePath) {
			data.certificatePhoto2 = certificatePhoto2FilePath;
		}
		if (driverPhotoFilePath) {
			data.driverPhoto = driverPhotoFilePath;
		}

		parent.$.messager.progress({
			text : common017
		});
		$.ajax({
			type : "post",
			dataType : "json",
			url : upUrl,
			data : data,
			async : true,
			success : function(result) {
				if (result.success) {
					parent.$.messager.progress('close');
					back();
				} else {
					parent.$.messager.progress('close');
					showError(result.msg);
				}
			}
		})
	}

	function uploadCarOwnerPhoto() {
		imageUploadDialog = uploadImageDialog('carOwnerPhoto', 'vehicle/vehicleForm');
	}
	function uploadCarPhoto() {
		imageUploadDialog = uploadImageDialog('carPhoto', 'vehicle/vehicleForm');
	}
	function uploadCertificatePhoto() {
		imageUploadDialog = uploadImageDialog('certificatePhoto', 'vehicle/vehicleForm');
	}
	function uploadCertificatePhoto2() {
		imageUploadDialog = uploadImageDialog('certificatePhoto2', 'vehicle/vehicleForm');
	}
	function uploadDriverPhoto() {
		imageUploadDialog = uploadImageDialog('driverPhoto', 'vehicle/vehicleForm');
	}
	function showCarOwnerPhoto() {
		var url;
		if (carOwnerPhotoFilePath) {
			url = getContextPath() + "/common/filedownload?filePath=" + carOwnerPhotoFilePath;
		} else {
			if (pkey) {
				url = getContextPath() + "/vehicle/getWithImage?imageType=carOwnerPhoto&pkey=" + pkey;
			} else {
				// 				url = getContextPath() + "/common/menuPage?url=noImage";
				return;
			}
		}
		dialogForShowImage(url);
	}

	function showCarPhoto() {
		var url;
		if (carOwnerPhotoFilePath) {
			url = getContextPath() + "/common/filedownload?filePath=" + carPhotoFilePath;
		} else {
			if (pkey) {
				url = getContextPath() + "/vehicle/getWithImage?imageType=carPhoto&pkey=" + pkey;
			} else {
				// 				url = getContextPath() + "/common/menuPage?url=noImage";
				return;
			}
		}
		dialogForShowImage(url);
	}
	function showCertificatePhoto() {
		var url;
		if (carOwnerPhotoFilePath) {
			url = getContextPath() + "/common/filedownload?filePath=" + certificatePhotoFilePath;
		} else {
			if (pkey) {
				url = getContextPath() + "/vehicle/getWithImage?imageType=certificatePhoto&pkey=" + pkey;
			} else {
				// 				url = getContextPath() + "/common/menuPage?url=noImage";
				return;
			}
		}
		dialogForShowImage(url);
	}
	function showCertificatePhoto2() {
		var url;
		if (carOwnerPhotoFilePath) {
			url = getContextPath() + "/common/filedownload?filePath=" + certificatePhoto2FilePath;
		} else {
			if (pkey) {
				url = getContextPath() + "/vehicle/getWithImage?imageType=certificatePhoto2&pkey=" + pkey;
			} else {
				// 				url = getContextPath() + "/common/menuPage?url=noImage";
				return;
			}
		}
		dialogForShowImage(url);
	}
	function showDriverPhoto() {
		var url;
		if (carOwnerPhotoFilePath) {
			url = getContextPath() + "/common/filedownload?filePath=" + driverPhotoFilePath;
		} else {
			if (pkey) {
				url = getContextPath() + "/vehicle/getWithImage?imageType=driverPhoto&pkey=" + pkey;
			} else {
				// 				url = getContextPath() + "/common/menuPage?url=noImage";
				return;
			}
		}
		dialogForShowImage(url);
	}

	function uploadImageFinish(callFlag, filePath) {
		imageUploadDialog.dialog("destroy");
		if (callFlag == 'carOwnerPhoto') {
			carOwnerPhotoFilePath = filePath;
		} else if (callFlag == 'carPhoto') {
			carPhotoFilePath = filePath;
		} else if (callFlag == 'certificatePhoto') {
			certificatePhotoFilePath = filePath;
		} else if (callFlag == 'certificatePhoto2') {
			certificatePhoto2FilePath = filePath;
		}
		if (callFlag == 'driverPhoto') {
			driverPhotoFilePath = filePath;
		}
		showInfo("图片上传成功！");
	}
	function dialogForShowImage(url) {
		var dialog = createDialog({
			frameID : 'imageShow',
			title : '图片',
			width : 900,
			height : 600,
			url : url,
			toolbar : [ {
				text : common009,
				iconCls : 'icon-cancel',
				handler : function() {
					dialog.dialog("destroy");
				}
			} ]
		});
	}
</script>
</head>

<body class="easyui-layout" data-options="border:false" style="height: 100%">
	<div data-options="region:'north',border:false" style="height: 40px">
		<table>
			<tr>
				<td class="show">
					<a href="javascript:void(0);" class="easyui-linkbutton" style="margin: 5 0 0 5" data-options="iconCls:'icon-add',plain:true" onclick="save();">保存</a>
				</td>
				<!-- 				<td class="show"> -->
				<!-- 					<div class="datagrid-btn-separator"></div> -->
				<!-- 				</td> -->
				<!-- 				<td> -->
				<!-- 					<a href="javascript:void(0);" class="easyui-linkbutton" style="margin: 5 0 0 5" data-options="iconCls:'icon-back',plain:true" onclick="back();">返回</a> -->
				<!-- 				</td> -->
			</tr>
		</table>
	</div>
	<div data-options="region:'center',border:true" style="height: 100%; padding-left: 15px">
		<form id="form" method="post">
			<input name="id" type="hidden" />
			<div class="itemForm" style="width: 740px">
				<div class="formtitle">
					<span>客户信息</span>
				</div>
				<div style="height: 160px">
					<div class='item col4' style="width: 600px">
						<label class="labelWidth2">
							<span style="color: red">*</span>
							客户名称
						</label>
						<input class="easyui-combobox" name="customerName" 
						data-options="valueField:'id',textField:'compName',required:true,
											url:'../company/queryComList'"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							联系人
						</label>
						<input class="easyui-textbox" type="text" name="linkman" data-options="required:true"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							联系人电话
						</label>
						<input type="text" name="linkmanTel" class="easyui-textbox" data-options="required:true,validType:'mobile'" />
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							车主
						</label>
						<input class="easyui-textbox readonly" type="text" name="carOwner" data-options="required:true"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							车主电话
						</label>
						<input type="text" name="carOwnerTel" class="easyui-textbox" data-options="required:true,validType:'mobile'" />
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							身份证号
						</label>
						<input type="text" name="driver2" class="easyui-textbox" data-options="required:true,validType:'idcard'" />
					</div>
					<div class='item col4'>
						<label class="labelWidth2">家庭住址</label>
						<input class="easyui-textbox" type="text" name="driver2Tel" data-options="required:true"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">原车主</label>
						<input class="easyui-textbox" type="text" name="driver1"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">原车牌号</label>
						<input type="text" name="driver1Tel" class="easyui-textbox" data-options="validType:'carNo'" />
					</div>
				</div>
				<div style="height: 10px"></div>
				<div class="formtitle">
					<span>落籍信息</span>
				</div>
				<div style="height: 200px">
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							档案号
						</label>
						<input type="text" name="pkey" class="easyui-textbox" data-options="required:true" />
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							车牌号
						</label>
						<input type="text" name="carPlateNo" class="easyui-textbox" data-options="required:true,validType:'carNo'" />
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							车牌颜色
						</label>
						<!-- 						<select class="easyui-combobox" type="text" name="carPlateCol" id="carPlateCol" data-options="required:true,  valueField:'key',textField:'value', panelHeight:120, -->
						<!-- 											url:'http://202.98.11.190:8080/drbs/common/getLookupDetailFromCode?lookupCode=CARPLATE_COLOR'"></select> -->
						<select class="easyui-combobox" name="carPlateCol">
							<option value="Y">黄色</option>
							<option value="U">蓝色</option>
							<option value="B">黑色</option>
							<option value="W">白色</option>
							<option value="O">其他</option>
						</select>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							车辆类型
						</label>
						<select class="easyui-combobox" name="carType2">
							<option value="燃油车">燃油车</option>
							<option value="双燃料">双燃料</option>
							<option value="新能源">新能源</option>

						</select>

					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							营运证号
						</label>
						<input class="easyui-textbox" type="text" name="transportNo" validType="length[0,30]" data-options="required:true"></input>
					</div>

					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							车辆品牌
						</label>
						<select class="easyui-combobox" type="text" name="carBrand" id="carBrand" data-options="valueField:'key',textField:'value',required:true,
											url:'../common/VEHICLE_CARTYPE.json'"></select>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">
							<span style="color: red">*</span>
							车身颜色
						</label>
						<input class="easyui-textbox" type="text" name="carColor" validType="length[0,50]" data-options="required:true"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">行驶证初次登记</label>
						<input class="Wdate" style="width: 200px" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy/MM/dd'})" name="terminalGYS"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">车辆型号</label>
						<input class="easyui-textbox" type="text" name="vehicleModel"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">汽车制造厂</label>
						<select class="easyui-textbox" type="text" name="hgzDataSource"></select>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">车辆识别代码/车架号</label>
						<input class="easyui-textbox" type="text" name="vin2" id="vin2"></input>
					</div>
					<div class='item col4'>
						<label class="labelWidth2">发动机号</label>
						<input class="easyui-textbox" type="text" name="engineNo"></input>
					</div>
					<div class="item col4">
						<label class="labelWidth2">车辆出厂日期</label>
						<input class="Wdate" style="width: 200px" onfocus="WdatePicker({readOnly:true,dateFmt:'yyyy/MM/dd'})" name="carProductEndDateString"></input>
					</div>

				</div>
				<div style="height: 10px"></div>
				<div class="formtitle">
					<span>上传图片</span>
				</div>
				<div style="height: 100px;">
					<div class='item show' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="uploadCarOwnerPhoto();">上传车主照片</a>
					</div>
					<div class='item show' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="uploadCarPhoto();">上传车身照片</a>
					</div>
					<div class='item show' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="uploadCertificatePhoto();">上传车辆登记证照片</a>
					</div>
					<div class='item show' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="uploadCertificatePhoto2();">上传车辆登记证2照片</a>
					</div>
					<div class='item show' style="width: 190">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="uploadDriverPhoto();">上传车辆合格证/行驶证照片</a>
					</div>
					<div class='item' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="showCarOwnerPhoto();">查看车主照片</a>
					</div>
					<div class='item' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="showCarPhoto();">查看车身照片</a>
					</div>
					<div class='item' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="showCertificatePhoto();">查看车辆登记证照片</a>
					</div>
					<div class='item' style="width: 150">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="showCertificatePhoto2();">查看车辆登记证照片</a>
					</div>
					<div class='item' style="width: 190">
						<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="showDriverPhoto();">查看车辆合格证/行驶证照片</a>
					</div>
					<div class='item' style="width: 500">
						<span style="color: red; margin-left: 10px">备注：小于3M，jpg、jpeg格式，且车身照片为车辆左前方45角度图片</span>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>