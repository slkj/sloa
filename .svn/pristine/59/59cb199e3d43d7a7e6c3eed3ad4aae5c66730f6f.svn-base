function loadJSPButton(mid) {
	var button = loadButton(mid);
	var str = "";
	$.each(button.mButton, function(i, o) {
		str += '<a id="' + o.url + '" href="#" ' + 'class="easyui-linkbutton" data-options="iconCls:\'' + o.icon + '\',plain:\'true\'">' + o.name + '</a>';
	});
	var targetObj = $("#td_toolbar").append(str);
	$.parser.parse(targetObj);
}
function loadButton(mid) {
	var obj;
	$.ajax({
		url : "../module/getRolePer?mid=" + mid,
		type : "POST",
		async : false,
		dataType : "json",
		cache : false,
		success : function(data) {
			obj = parseData(data);
		}
	});
	return obj;
}
function parseData(data) {
	var obj = {};
	var mButton = new Array();
	var colButton = new Array();
	$.each(data, function(i, o) {
		if (o.priority == '3') {
			mButton.push(o);
		}
		if (o.priority == '4') {
			colButton.push(o);
		}
	});
	obj.mButton = mButton;
	obj.colButton = colButton;
	// alert(mButton.length+"=="+colButton.length);
	return obj;
}
