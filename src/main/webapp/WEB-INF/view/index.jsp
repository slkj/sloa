<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>神龙科技智能办公系统</title>
	<%@ include file="/common/taglibs.jsp"%>
    <script type="text/javascript" src="js/index.js"></script>
    <script type="text/javascript">
        var _menus;
        /*ajax获取菜单数据*/
        function loadModuleData() {
            $.ajax({
            	url : "module/listByUser",
                async: false,
                dataType: "json",
                cache: false,
                success: function (data) {
                    if (data.length > 0) {

                        _menus =data;
                        addNav(data);
                    }
                }
            });
        }

    </script>

</head>
<body class="easyui-layout">
<!-- begin of header -->
<div class="wu-header" data-options="region:'north'">
    <div class="wu-header-left">
        <div class="define-logo">
<!--             <div id="LoginTopLine"></div> -->
<!--             <div id="LoginBotoomLine"></div> -->
        </div>
    </div>
    <div class="wu-header-right">
        <p><strong class="easyui-tooltip">${sessionUser.realname }</strong>，欢迎您！</p>
        <p><a href="http://hbslkj.com:89/mygpsonline/" target="_blank">网上查车</a>|<a id="openJSZC" href="#">技术支持</a>
            |<a id="loginOut" href="#">安全退出</a>
        </p>
    </div>
</div>
<!-- end of header -->
<!-- begin of sidebar -->
<div class="wu-sidebar" data-options="region:'west',split:true,border:true,title:'导航菜单'">
    <div id='wnav' class="easyui-accordion" fit="true" border="false">
        <!--  导航内容 -->
    </div>


</div>
<!-- end of sidebar -->
<!-- begin of main -->
<div class="wu-main" data-options="region:'center'">
    <div id="tabs" class="easyui-tabs" fit="true" border="false">
        <div title="欢迎使用" style="padding: 20px; overflow: hidden;" id="home">
           <iframe scrolling="auto" frameborder="0"  src="Welcome" style="width:100%;height:100%;"></iframe>
        </div>
    </div>
</div>
<!-- end of main -->
<!-- begin of footer -->
<div class="wu-footer" data-options="region:'south',border:true,split:true">
    Copyright &copy; 2017 神龙科技 All Rights Reserved
</div>
<div id="dd" class="easyui-dialog" title="技术支持" style="width: 550px; height: 330px;text-align:center"
     data-options="iconCls:'icon-tip',resizable:true,modal:false,closed:true">


    <table style="width:100%;" cellpadding="2" cellspacing="0" border="0">
        <tr>
            <td>
                <pre>24<span style="font-family:宋体;">小时监控</span>:0310-5101568  0310-5101568 </pre>
                <pre><span style="font-family:宋体;">售后服务：</span>0310-5101509 </pre>
                <pre><span style="font-family:宋体;">审批系统技术支持：</span>18132242203</pre>
                <pre><span style="font-family:宋体;font-size: 14px;color: red">关注左侧微信公众号，实时监控车辆动态</span></pre>
            </td>
            <td>
                <img src="images/slwx_258.jpg" alt=""/>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<div id="mm" class="easyui-menu" style="width: 150px;">
    <div id="mm-tabupdate">刷新</div>
    <div class="menu-sep"></div>
    <div id="mm-tabclose">关闭</div>
    <div id="mm-tabcloseall">全部关闭</div>
    <div id="mm-tabcloseother">除此之外全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-tabcloseright">当前页右侧全部关闭</div>
    <div id="mm-tabcloseleft">当前页左侧全部关闭</div>
    <div class="menu-sep"></div>
    <div id="mm-exit">退出</div>
</div>
</body>
<!-- end of footer -->
</html>
