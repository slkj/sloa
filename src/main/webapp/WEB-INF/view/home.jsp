<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="js/jquery.min.js"></script>
    <script src="js/easyui/jquery.easyui.min.js"></script>
    <link href="js/easyui/themes/default/easyui.css" rel="stylesheet"/>
</head>
<body>
<style>


    .alphac {
        filter: Alpha(Opacity=70);
        -moz-opacity: 0.7;
        opacity: 0.7;
    }

    .cc {
        position: relative;
        width: 100%;
        height: 200px;
    }

    .groupSave {
        display: none;
    }

    .cc .panel-tool {
        display: none;
    }

    .checkBoxPart {
        width: 150px;
        height: 26px;
        line-height: 40px;
        padding-left: 20px;
    }

    .checkBoxPart input, .checkBoxPart lable {
        vertical-align: middle;
        vertical-align: middle;
        margin: 0px;
        margin-right: 4px;
    }

    #dd1, #dd2, #dd3, #dd4, #dd5, #dd6, #dd7, #dd8, #dd9 {
        overflow: hidden;
        position: absolute;
        border: 1px #e7eaec solid;
        border-radius: 4px;
    }

    .ddcontent {
        min-height: 50px;
        padding: 5px;
    }
</style>
<script type="text/javascript">
    //修改，筛选，保存
    $(function () {
        $(".groupSave").hide();
        var editFlag = false;
        $(".cc").height($(window).height() - 41);
        $(window).resize(function () {
            $(".cc").height($(window).height() - 41);
        });
        $('#dd1,#dd2,#dd3,#dd4,#dd5,#dd6,#dd7,#dd8,#dd9').draggable({edge: 5}).resizable();
        //选中的将变成最顶层
        $(".cc div").mousedown(function () {
            $(".cc div").css("z-index", "0").removeClass("alphac");
            $(this).css("z-index", "1").addClass("alphac");
        }).mouseup(function () {
            $(".cc div").removeClass("alphac");
        });

        $(".cc div").mousedown(function () {
            $(".cc div").css("z-index", "0").removeClass("alphac");
            $(this).css("z-index", "1").addClass("alphac");
        }).mouseup(function () {
            $(".cc div").removeClass("alphac");
        });
        $('#dd1,#dd2,#dd3,#dd4,#dd5,#dd6,#dd7,#dd8,#dd9').draggable('disable').resizable('disable');
        $("#mydialog input[type='checkbox']").each(function (i) {
            if ($(this).prop("checked")) {

            }
        });
        //初始化筛选
        for (var i = 1; i < 10; i++) {
            if ($("#dd" + i).is(":hidden")) {
                $("#cdd" + i).removeAttr("checked");
            }
            else {

                $("#cdd" + i).attr("checked", "true");
            }
        }
        $("#Edit").click(function () {

            $.messageBox5s('@Resource.Tip', '您现在可以进行部件删减，以及部件大小的调整！');
            $('#dd1,#dd2,#dd3,#dd4,#dd5,#dd6,#dd7,#dd8,#dd9').draggable('enable').resizable('enable').css("border", "1px #ff6600 dashed");
            $(".panel-tool").show();
            $(".groupSave").show();
            $(".groupEdit").hide();
            editFlag = true;
        });
        //单项去除
        $(".cc .panel-tool-close").click(function () {
            $(this).parent().parent().parent().hide();

            $.messageBox5s('@Resource.Tip', '您可以［部件筛选］中让他重新显示！');
        });
        $("#Save").click(function () {
            if (editFlag) {
                editFlag = false;
                //取出数据，保存html
                for (var i = 1; i < 10; i++) {
                    $("#content" + i).html("");
                }
                $('#dd1,#dd2,#dd3,#dd4,#dd5,#dd6,#dd7,#dd8,#dd9').draggable('disable').resizable('disable').css("border", "");
                $(".cc .panel-tool").hide();

                //此处进行保存数据
                //////////////////////////////////////////////////////////////////////////////////////
                $("#JsSet").html("");
                alert("这里来保存到数据库获取内容的代码：$('.cc').html()");
                alert($(".cc").html())
                /////////////////////////////////////////////////////////////////////////////////////
                //重新加载数据，重新绑定
                $(".cc div").unbind().mousedown(function () {
                    $(".cc div").css("z-index", "0").removeClass("alphac");
                    $(this).css("z-index", "1").addClass("alphac");
                }).mouseup(function () {
                    $(".cc div").removeClass("alphac");
                });
                LoadData();

                $.messageBox5s('@Resource.Tip', '保存成功！');


                $(".groupSave").hide();
                $(".groupEdit").show();
            } else {

                $.messageBox5s('@Resource.Tip', '没有什么需要保存的！');
            }
        });
        $("#Choice").click(function () {
            $("#modalwindow").window({
                title: '筛选',
                width: 250,
                height: 320,
                iconCls: 'fa fa-filter',
                resizable: false
            }).window('open');
        });
        $("#ChoiceSave").click(function () {
            $("#modalwindow").window("close");

        });
        $(".checkBoxPart input").click(function () {
            if ($(this).prop("checked")) {
                $("#" + $(this).val()).show();
            }
            else {
                $("#" + $(this).val()).hide();
            }
        });
        $("#Reset").click(function () {
            $.messager.confirm('复位提醒', '您确定要重置部件的位置和个数吗?', function (r) {
                if (r) {
                    alert("这里初始化原始的DIV");
                }
            });
        });
        LoadData();
    });
    //加载
    function LoadData() {
        //初始化筛选
        for (var i = 1; i < 10; i++) {
            $("#content" + i).html("<div class=\"panel-loading\">Loading...</div>");
        }
        //如果部件，没有被去掉，那么就加载数据
        if (!$("#dd1").is(":hidden")) {
            Load_1();
        }
        if (!$("#dd2").is(":hidden")) {
            Load_2();
        }
        if (!$("#dd3").is(":hidden")) {
            Load_3();
        }
        if (!$("#dd4").is(":hidden")) {
            Load_4();
        }
        if (!$("#dd5").is(":hidden")) {
            Load_5();
        }
        if (!$("#dd6").is(":hidden")) {
            Load_6();
        }
        if (!$("#dd7").is(":hidden")) {
            Load_7();
        }
        if (!$("#dd8").is(":hidden")) {
            Load_8();
        }
        if (!$("#dd9").is(":hidden")) {
            Load_9();
        }
    }
    //动态设置宽度
    function promptValue(id) {
        $.messager.prompt('设置部件宽度', '请输入宽度，格式：<font color="red">50%</font>或<font color="red">500px</font>', function (r) {
            if (r) {
                $("#" + id).width(r);
            }
        });
    }


    function Load_1() {
        $("#content1").html("我是框里的内容（1）");
    }
    function Load_2() {
        $("#content1").html("我是框里的内容（2）");
    }
    function Load_3() {
        $("#content1").html("我是框里的内容（3）");
    }
    function Load_4() {
        $("#content1").html("我是框里的内容（4）");
    }
    function Load_5() {
        $("#content1").html("我是框里的内容（5）");
    }
    function Load_6() {
        $("#content1").html("我是框里的内容（6）");
    }
    function Load_7() {
        $("#content1").html("我是框里的内容（7）");
    }
    function Load_8() {
        $("#content1").html("我是框里的内容（8）");
    }
    function Load_9() {
        $("#content1").html("我是框里的内容（9）");
    }

    function ShowInfo(name, url) {
        window.parent.addTab(name, "/MIS/InfoCenter/Show?id=" + url);
    }
    function SetWebpartLayout() {
        var _windowWidth = 1280;
        var _windowHeight = 800;
        $("#dd1,#dd2,#dd3,#dd4,#dd5,#dd6,#dd7,#dd8,#dd9").width(_windowWidth / 3 - 6).height(_windowHeight / 3 - 16);
        var ddw = $("#dd1").width();
        var ddh = $("#dd1").height()
        $("#dd1,#dd4,#dd7").css("left", 0);
        $("#dd2,#dd5,#dd8").css("left", ddw + 7);
        $("#dd3,#dd6,#dd9").css("left", ddw * 2 + 14);
        $("#dd1,#dd2,#dd3").css("top", 0);
        $("#dd4,#dd5,#dd6").css("top", ddh + 7);
        $("#dd7,#dd8,#dd9").css("top", ddh * 2 + 17);
        $(".ddcontent").height(ddh - 40)
    }
    $.extend({
        messageBox5s: function (title, msg) {
            $.messager.show({
                title: '<span class="fa fa-info">&nbsp;&nbsp;' + title + '</span>',
                msg: msg,
                timeout: 5000,
                showType: 'slide',
                style: {
                    left: '',
                    right: 30,
                    top: '',
                    bottom: 30,
                    width: 250,


                }
            });
        }
    });
    $.extend({
        messageBox10s: function (title, msg) {
            $.messager.show({
                title: '<span class="fa fa-info">&nbsp;&nbsp;' + title + '</span>',
                msg: msg,
                height: 'auto',
                width: 'auto',
                timeout: 10000,
                showType: 'slide',
                style: {
                    left: '',
                    right: 5,
                    top: '',
                    bottom: -document.body.scrollTop - document.documentElement.scrollTop + 5
                }
            });
        }
    });
    $.extend({
        show_alert: function (strTitle, strMsg) {
            $.messager.alert(strTitle, strMsg);
        }
    });


</script>
<div id="modalwindow" class="easyui-window" style="width:250px; height:320px;"
     data-options="modal:true,closed:true,minimizable:false,shadow:false">
    <div class="mvctool bgb">
        <a id="ChoiceSave" style="float: left;" class="l-btn l-btn-plain"><span class="l-btn-left"><span
                class="l-btn-text fa fa-save" style="font-size:14px"></span><span
                style="font-size:12px">完成</span></span></a>
        <div class="datagrid-btn-separator"></div>
    </div>
    <div class="checkBoxPart">
        <input id="cdd1" type="checkbox" value="dd1"/>
        <lable>待办事项</lable>
    </div>
    <div class="checkBoxPart">
        <input id="cdd2" type="checkbox" value="dd2"/>站内信箱
    </div>
    <div class="checkBoxPart">
        <input id="cdd3" type="checkbox" value="dd3"/>最新信息
    </div>
    <div class="checkBoxPart">
        <input id="cdd4" type="checkbox" value="dd4"/>我的申请
    </div>
    <div class="checkBoxPart">
        <input id="cdd5" type="checkbox" value="dd5"/>我的批准
    </div>
    <div class="checkBoxPart">
        <input id="cdd6" type="checkbox" value="dd6"/>我的项目
    </div>
    <div class="checkBoxPart">
        <input id="cdd7" type="checkbox" value="dd7"/>会议邀请
    </div>
    <div class="checkBoxPart">
        <input id="cdd8" type="checkbox" value="dd8"/>共享中心
    </div>
    <div class="checkBoxPart">
        <input id="cdd9" type="checkbox" value="dd9"/>备忘记事
    </div>
</div>
<div class="mvctool" style="height:30px;">
    <div class="groupEdit">
        <a id="Edit" style="float: left;" class="l-btn l-btn-plain"><span class="l-btn-left"><span
                class="l-btn-text fa fa-pencil" style="font-size:14px"></span><span
                style="font-size:12px">编辑部件</span></span></a>
    </div>
    <div class="groupSave" style="display: block;">
        <a id="Save" style="float: left;" class="l-btn l-btn-plain"><span class="l-btn-left"><span
                class="l-btn-text fa fa-save" style="font-size:14px"></span><span
                style="font-size:12px">完成</span></span></a>
        <div class="datagrid-btn-separator"></div>
        <a id="Choice" style="float: left;" class="l-btn l-btn-plain"><span class="l-btn-left"><span
                class="l-btn-text fa fa-filter" style="font-size:14px"></span><span
                style="font-size:12px">部件筛选</span></span></a>
        <div class="datagrid-btn-separator"></div>
        <a id="Reset" style="float: left;" class="l-btn l-btn-plain"><span class="l-btn-left"><span
                class="l-btn-text fa fa-refresh" style="font-size:14px"></span><span style="font-size:12px">部件复位</span></span></a>
    </div>
</div>
<div class="cc">

    <div id="dd1" class="easyui-draggable panel" data-options="handle:'#title1'">
        <div id="title1" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                待办事项
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd1')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content1" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <div id="dd2" class="easyui-draggable" data-options="handle:'#title2'">
        <div id="title2" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                站内信箱
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd2')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content2" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <div id="dd3" class="easyui-draggable" data-options="handle:'#title3'">
        <div id="title3" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                最新信息
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd3')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content3" class="panel-body ddcontent" style="border: 0">
        </div>
    </div>
    <div id="dd4" class="easyui-draggable" data-options="handle:'#title4'">
        <div id="title4" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                我的申请
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd4')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content4" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <div id="dd5" class="easyui-draggable" data-options="handle:'#title5'">
        <div id="title5" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                我的批准
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd5')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content5" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <div id="dd6" class="easyui-draggable" data-options="handle:'#title6'">
        <div id="title6" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                我的项目
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd6')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content6" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <div id="dd7" class="easyui-draggable" data-options="handle:'#title7'">
        <div id="title7" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                会议邀请
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd7')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content7" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <div id="dd8" class="easyui-draggable" data-options="handle:'#title8'">
        <div id="title8" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                共享中心
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd8')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content8" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <div id="dd9" class="easyui-draggable" data-options="handle:'#title9'">
        <div id="title9" class="panel-header" style="border: 0">
            <div class="panel-title" style="">
                备忘录
            </div>
            <div class="panel-tool">
                <a href="javascript:promptValue('dd9')" class="panel-tool-max"></a><a href="javascript:void(0)"
                                                                                      class="panel-tool-close"></a>
            </div>
        </div>
        <div id="content9" class="panel-body ddcontent" style="border: 0">
            <div class="panel-loading">
                Loading...
            </div>
        </div>
    </div>
    <script id="JsSet">
        $(function () {
            SetWebpartLayout();
        });
        $(window).resize(function () {
            SetWebpartLayout();
        });
    </script>

</div>
</body>
</html>
