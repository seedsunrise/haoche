<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="summer" uri="/summer"%>
<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>打印鉴定报告</title>
    <link rel="shortcut icon" href="/resources/image/favicon.ico"/>
    <link rel="bookmark" href="/resources/image/favicon.ico"/>
    <script src='<c:url value="/resources/javascript/lib/jquery-2.2.3.min.js" />'></script>
    <script src='<c:url value="/resources/javascript/lib/underscore.js" />'></script>
    <script src='<c:url value="/resources/javascript/print/printIdentify.js" />'></script>
    <style>
        html,body,a,abbr,acronym,address,applet,article,aside,audio,b,big,blockquote,canvas,caption,center,cite,code,dd,del,details,dfn,div,dl,dt,em,embed,fieldset,figcaption,figure,footer,form,h1,h2,h3,h4,h5,h6,header,hgroup,i,iframe,img,ins,kbd,label,legend,li,mark,menu,nav,object,ol,output,p,pre,q,ruby,s,samp,section,small,span,strike,strong,input,sub,summary,sup,table,tbody,td,tfoot,th,thead,time,tr,tt,u,ul,var,video{margin:0;padding:0;border:0;font-size:100%;font:inherit;vertical-align:baseline}
        body {  color:#3c3d3d; font:12px/1.5 "Arial", "Microsoft YaHei", "微软雅黑", "SimSun", "宋体";    }
        a { cursor: pointer}

        /*  -----------------------------
           打印
          ----------------------------- */
        @media print {
            .nextPage {page-break-after:always;}
            .MainTitle {    display: none;  }
        }
        .MainTitle {
            /*display: none;*/
            width: 190mm;
            margin: 0 auto;
            margin-bottom: 50px;
            height: 100px;
            line-height: 100px;
            font-size: 26px;;
            color: #1b1b1b;
            border-bottom: 2px solid #ff5f52;
        }
        .MainTitle span {
            position: relative;
            margin-left: 54px;
        }
        .MainTitle span:before {
            position: absolute;
            top: -1px;
            left: -20px;
            content: " ";
            width: 5px;
            height: 30px;
            background: #ff5f52;
        }
        .PrintBtn {
            float: right;
            margin-top: 25px;
            margin-right: 30px;
            width: 155px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            font-size: 24px;
            color: #fff;
            font-weight: bold;
            background: #ff5f52;
            border-radius: 25px;
            text-decoration: none;
        }
        .PrintBtn:hover {
            text-decoration: none;
            opacity: 0.9;
        }

        /*  -----------------------------
           正文
          ----------------------------- */

        body { background-color: #fff;}

        .PrintIdentifyLayout {
            width: 190mm;height:277mm;margin:0 auto;background-color: #fff;
            page-break-before: auto;   page-break-after: always;    /* 分页 */
        }

        #head { height: 10mm; margin-bottom:8mm ; overflow: hidden}

        #head img { width: 45px;float: left;height: 36px;    }

        #head .headTitle {
            height:36px;border-bottom:2px solid #6e6e6e;margin-left: 55px;box-sizing:border-box;
        }
        #head .t3 { display: inline-block; font-size:25px; line-height: 30px;}
        #head .t4 { display: inline-block; font-size:14px;line-height: 36px; float: right;text-align: right;}


        /*  -----------------------------
           通用
          ----------------------------- */

        /* 排版 */
        .fl     { float:left; display:inline;}  /* float=block = width:100% , inline可取消100%*/
        .fr     { float:right; display:inline}
        .fb     { font-weight: bold}
        .c333   { color:#333 !important;}
        .alignR { text-align: right;}
        .alignC { text-align: center;}
        .alignL { text-align: left;}
        .mgT10  { margin-top: 10px}
        .mgT40  { margin-top: 40px}
        .mgT60  { margin-top: 60px}
        .mgT100 { margin-top: 100px}
        .mgT300 { margin-top: 300px}


        .caption {font-family: 黑体;
            font-size: 25px;
            line-height: 25px;
            font-weight: bold;
            padding:10px 10px 15px 0 !important;
            text-align: left;
            border-bottom: 2px solid rgb(110, 110, 110);
            background: none;
            clear: both;
        }

        .smCaption {font-weight: normal;color:#6e6e6e;font:14px/20px "Arial", "Microsoft YaHei", "微软雅黑", "SimSun", "宋体"; }


        /* 通用 表格 */
        /*.t2 { font-family: '黑体';font-size: 25px;line-height: 25px;font-weight: bold ;padding-bottom: 15px; text-align: left; border-bottom:2px solid #6e6e6e;}*/

        .tb { width: 100%; border-bottom: 2px solid #c5c2c2; line-height: 19px;
            display: inline-table;           /* 方便 并列多个 表格*/
            border-collapse: collapse;      /* 合并单元格 = 0 间距 */
            word-break:break-all;           /* 换行：让英文似中文 */}

        .tb th ,
        .tb td { padding:10px !important;
            line-height: 14px;}

        .tb-th ,
        .tb th { font-weight: bold ;text-align: left;
            border-top: 3px solid #6e6e6e;border-bottom: 2px solid #c5c2c2;}

        .tb-th {padding: 10px 10px 10px 0;font-size:16px}

        .tb td { border-bottom: 1px solid #c5c2c2;border-top:1px solid #c5c2c2;color:#6e6e6e;}

        .tb th:first-child ,
        .tb td:first-child { padding: 10px 0 !important;color: #3b3c3c;border-right:1px solid #c5c2c2;}

        .caption i,
        .tb-th i,
        .tb i { display: block;float:right;width: 14px; height: 14px; background-image: url('/resources/image/icon_att.png'); -webkit-background-size: 100% 100%;background-size: 100% 100%;
        }

        .caption i{margin-top: 10px;}
        .tb-th i {margin-top: 5px;}

        /*.caption b,*/
        /*.tb-th b,*/
        /*.tb b { display: none;float:right;width: 14px; height: 14px; background-image: url('/assets/img/icon_att.png'); -webkit-background-size: 100% 100%;background-size: 100% 100%;*/
        /*}*/

        /*.caption b {margin-top: 10px;}*/
        /*.tb-th b {margin-top: 5px;}*/


        .tb-col4 td { width: 25% }
        .tb-col3 td{ width: 33%}


        .noBrdB { border-bottom: none }
        .noBrdT td { border-top:none;}
        .noBrd {border:none !important;}
        .brdL { border-left: 1px solid #c5c2c2 !important;}
        /*  -----------------------------
           具体
          ----------------------------- */

        /* 事故鉴定  --------------*/
        #accident .feature:last-child tr:last-child td{border-bottom:1px solid #c5c2c2}
        #accident  th:first-child { width:50%}

        /* 车架 */
        #tb-carframe td {border-bottom: none;border-top:none}

        /*  外观鉴定 --------------*/

        /* 同行特殊表格 */
        .feature { clear: both; }
        .feature .caption { border-width: 4px;}
        .feature .tb {border-bottom: none;}
        .feature .tb th ,
        .feature .tb td { border-top:none;border-right:none;}
        .feature .tb { width: 48%;}

        .feature tr:last-child td { border-bottom: none}

        /* 灯光 */
        #tb-light tr:last-child td{border-bottom:1px solid #c5c2c2}
        /* 全车玻璃*/
        #tb-glass th:first-child { width:35%}




        /* 随车工具*/
        #tb-tools tr:last-child td{border-bottom:1px solid #c5c2c2}

        /*小贴士*/
        #tb-alt td { border-top: none;}

        /* 电脑代码 --------------*/
        #tb-PC th:last-child,
        #tb-PC td:last-child {        text-align: center; }
        #tb-PC tr:last-child td{border-bottom:1px solid #c5c2c2}



        /* 机舱 */
        #tb-nacelle1 td {border-bottom: none;}
        .tb-nacelle th,
        .tb-nacelle td{border-right: 1px solid #c5c2c2}

        .tb-nacelle th:last-child,
        .tb-nacelle td:last-child { border-right:none}


        /* 轮胎-备注 --------------*/
        #tb-tyre th,
        #tb-tyre td { border-right: 1px solid #c5c2c2}

        #tb-tyre th { border-top: none}

        #tb-tyre th:last-child,
        #tb-tyre td:last-child  { border-right: none;}


        /* 刹车片 */
        #tb-brake tr:last-child td{border-bottom:1px solid #c5c2c2}


        /* 路试 */
        #tb-roadTest td { width: 33%; border-right: none}

    </style>
</head>
<body>

<div class="PrintIdentifyLayout">
    <h2 class="MainTitle clearfix">
        <span>打印车辆参数配置</span>
        <a class="PrintBtn" onclick="window.print()">打印</a>
    </h2>
    <div id="head" class="clearfix">
        <img src='/resources/image/TitleLogoBlack.png' >
        <div class="headTitle"><span class='t4'>专注高品质二手车</span><span class='t3'>鉴定报告</span></div>
    </div>
    <script type="text/template" id="ReportTpl" data-value='${report}'>
    {{  if ( dts ) { }}
    <!-- 事故鉴定 -->
    <div id="accident" >
        <p class="caption">事故鉴定</p>
        <p class="tb-th">车架号</p>
        <table id="tb-carframe" class="tb noBrdB">
            {{ var carframe = dts[3].data[0];}}
            <tr><td width="30%">{{=carframe.checkName}}</td><td>{{=carframe.checkContent.checkChildContent.name}}{{=carframe.isAbNormal?'<i></i>':''}}</td></tr>
        </table>
        <div class="feature clearfix">
            <p class="tb-th">撞击事故</p>

            <table  class="tb fl">
                {{ var ram = dts[0].data; }}
                <tr><th>部位</th><th>鉴定结果</th></tr>
                <tr>
                    {{   for( var i=0;i<2;i++){
                        var ram_i =ram[i];
                        for (var j=0,n=ram_i.checkContent.length;j<n;j++){

                    }}
                    <td>{{=ram_i.checkContent[j].checkChild.name}}</td>
                    <td>{{=ram_i.checkContent[j].checkChildContent.name}}{{=ram_i.isAbNormal?'<i></i>':''}}</td>
                </tr>
                {{ } } }}

                {{ for (var i=2;i<6;i++) {
                    var ram_i = ram[i] ;
                }}
                <tr>
                    <td>{{=ram_i.checkName }}</td>
                    <td>{{=ram_i.checkContent.checkChildContent.name }}{{=ram_i.isAbNormal?'<i></i>':''}}</td>
                </tr>
                {{ } }}


            </table>
            <table  class="tb fr">
                <tr><th>部位</th><th>鉴定结果</th></tr>
                {{ for (var n=ram.length,i= 6;i<n;i++) {
                    var ram_i = ram[i];
                }}
                <tr>
                    <td>{{=ram_i.checkName }}</td>
                    <td>{{=ram_i.checkContent.checkChildContent.name }}{{=ram_i.isAbNormal?'<i></i>':''}}</td>
                </tr>
                {{ } }}
            </table>
        </div>
        {{ for ( var j=1; j<3;j++ ) {
            var opn = dts[j].optionName , ds = dts[j].data ;}}

        <div class="feature clearfix">

            <p class="tb-th">{{=opn}}鉴定</p>
            <table class="tb fl">
                <tr><th>部位</th><th>鉴定结果</th></tr>

                {{ for (var i=0,n= Math.floor(ds.length/2); i<n;i++ ){
                    var accident_i = ds[i]  ;
                }}
                <tr>
                    <td>{{=accident_i.checkName }}</td>
                    <td>{{=accident_i.checkContent.checkChildContent.name }}{{=accident_i.isAbNormal?'<i></i>':''}}</td>
                </tr>
                {{ } }}
            </table>
            <table class="tb fr">
                <tr><th>部位</th><th>鉴定结果</th></tr>
                {{  for (var n= ds.length,i= Math.round(n/2); i<n;i++ ){
                    var accident_i = ds[i] ;
                }}
                <tr>
                    <td>{{=accident_i.checkName }}</td>
                    <td>{{=accident_i.checkContent.checkChildContent.name }}{{=accident_i.isAbNormal?'<i></i>':''}}</td>
                </tr>
                {{ } }}
            </table>
        </div>

        {{ } }}
    </div>

    <div>
        <!-- 外观鉴定 -->
        <p class="caption mgT10">外观鉴定</p>
        {{ var view = dts[4].data ; }}
        <table class="tb tb-col5 noBrdB">
            <tr><th>部位</th><th>光泽</th><th>曲面</th><th>色差</th><th>瑕疵损伤</th></tr>

            {{   for ( var i=0,n=view.length;i<n;i++) {
            var view_i = view[i],
            view_ic= view_i.checkContent;
            }}
            <tr>
                <td>{{=view[i].checkName }}</td>
                {{ for ( var j=0,m= view_ic.length; j<m;j++) { }}
                <td>{{=view_ic[j].checkChildContent.name }}
                    {{ if (j==m-1){ }}
                    {{= view_i.isAbNormal ?'<i></i>':'' }}
                    {{ } }}</td>
                {{  }  }}
            </tr>
            {{ } }}

        </table>

    </div>
    <!-- 全车玻璃 -->
    <div id="tb-glass" class="feature clearfix">
        <p class="tb-th">全车玻璃</p>
        {{  var glass = dts[5].data ; }}

        <table class="tb fl">
            <tr><th>部位</th><th>鉴定结果</th></tr>
            {{ for (var i=0,n= Math.floor(glass.length/2); i<n;i++ ){
                var glass_i = glass[i];
            }}
            <tr>
                <td>{{=glass_i.checkName }}</td>
                <td>{{=glass_i.checkContent.checkChildContent.name }}{{= glass_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
        <table class="tb fr">
            <tr><th>部位</th><th>鉴定结果</th></tr>
            {{ for (var n= glass.length,i= Math.round(n/2); i<n;i++ ){
                var glass_i = glass[i];
            }}
            <tr>
                <td>{{=glass_i.checkName }}</td>
                <td>{{=glass_i.checkContent.checkChildContent.name }}{{= glass_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
    </div>

    <!-- 灯光 -->
    <div id="tb-light" class="feature clearfix">
        <p class="tb-th">灯光鉴定</p>
        {{  var light = dts[6].data ; }}
        <table class="tb fl">
            <tr><th>部位</th><th>工作状态</th><th>外观结果</th></tr>
            {{ for (var i=0,n= Math.floor(light.length/2); i<n;i++ ){
                var light_i = light[i];
            }}
            <tr>
                <td>{{=light_i.checkName }}</td>
                <td>{{=light_i.checkContent[0].checkChildContent.name }}</td>
                <td>{{=light_i.checkContent[1].checkChildContent.name }}{{= light_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
        <table class="tb fr">
            <tr><th>部位</th><th>工作状态</th><th>外观结果</th></tr>
            {{ for (var n= light.length,i= Math.round(n/2); i<n;i++ ){
                var light_i = light[i];
            }}
            <tr>
                <td>{{=light_i.checkName }}</td>
                <td>{{=light_i.checkContent[0].checkChildContent.name }}</td>
                <td>{{=light_i.checkContent[1].checkChildContent.name }}{{= light_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
    </div>

    <!-- 内饰信息 -->
    <p class="caption mgT10">内饰信息</p>
    <table class="tb tb-col4 noBrdB">
        <tr><th>部位</th><th>磨损</th><th>脏污</th><th>破损</th></tr>

        {{ var trim = dts[7].data ;
            for ( var i=0,n=trim.length;i<n;i++) {
                var trim_i = trim[i],
                        trim_ic =  trim_i.checkContent;
        }}
        <tr>
            <td>{{=trim_i.checkName }}</td>
            {{ for ( var j=0,m= trim_ic.length; j<m;j++) { }}
            <td>{{=trim_ic[j].checkChildContent.name}}
                {{ if (j==m-1){ }}
                {{= trim_i.isAbNormal ?'<i></i>':'' }}
                {{ } }}
            </td>
            {{ } }}
        </tr>
        {{ } }}
    </table>


    <!-- 电子设备 -->
    <div id="tb-ED" class="feature clearfix">
        <p class="tb-th">电子设备</p>
        {{  var ED = dts[8].data;            }}
        <table class="tb fl">
            <tr><th width="50%">部位</th><th>鉴定结果</th></tr>
            {{ for (var i=0,n= Math.floor(ED.length/2); i<n;i++ ){
                var ED_i = ED[i];
            }}
            <tr>
                <td>{{=ED_i.checkName }}</td>
                <td>{{=ED_i.checkContent.checkChildContent.name }}{{= ED_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
        <table class="tb fr">
            <tr><th width="50%">部位</th><th>鉴定结果</th></tr>
            {{ for (var n= ED.length,i= Math.round(n/2); i<n;i++ ){
                var ED_i = ED[i];
            }}
            <tr>
                <td>{{=ED_i.checkName }}</td>
                <td>{{=ED_i.checkContent.checkChildContent.name }}{{= ED_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
    </div>

    <!-- 随车工具 -->
    <div id="tb-tools" class="feature clearfix">
        <!-- 注意：此表数据结构有些不同-->
        {{  var tools = dts[11].data[0] ,tools_c = tools.checkContent;            }}
        <p class="tb-th">随车工具{{= tools.isAbNormal ?'<i></i>':'' }}</p>
        <table class="tb fl">
            <tr><th width="50%">名称</th><th>结果</th></tr>
            {{ for (var i=0,n= Math.floor(tools_c.length/2); i<n;i++ ){
                var tools_ci = tools_c[i];
            }}
            <tr>
                <td width="35%">{{=tools_ci.checkChild.name }}</td>
                <td>{{=tools_ci.checkChildContent.name }}</td>
            </tr>
            {{ } }}
        </table>
        <table class="tb fr">
            <tr><th width="50%">名称</th><th>结果</th></tr>
            {{ for (var n= tools_c.length,i= Math.round(n/2); i<n;i++ ){
                var tools_ci = tools_c[i];
            }}
            <tr>
                <td width="35%">{{=tools_ci.checkChild.name }}</td>
                <td>{{=tools_ci.checkChildContent.name }}</td>
            </tr>
            {{ } }}
        </table>
    </div>

    <!-- 小贴士 -->
    <table id="tb-alt" class="tb" >
        <tr>
            <td width="10%" class="noBrd fb c333">小贴士</td>
            <td>1.剩余胎纹：可按照平均6000km/mm快速估算你继续使用里程<br>
                2.制造日期：如“2615”表示2015年第26周出厂</td>
            <td width="25%" class="brdL fb c333">备注</td>
        </tr>

    </table>

    <!-- 电脑代码 -->
    {{ var PC = dts[9].data[0] ,PC_c = PC.checkContent;}}
    <p class="caption mgT60">电脑代码{{= PC.isAbNormal ?'<i></i>':'' }}</p>
    <div id="tb-PC" class="feature clearfix">

        <table class="tb fl">
            <tr><th>鉴定类型</th><th>结果</th></tr>
            {{ for (var i=0,n= Math.floor(PC_c.length/2); i<n;i++ ){
                var PC_ci = PC_c[i];
            }}
            <tr>
                <td>{{=PC_ci.checkChild.name }}</td>
                <td>{{=PC_ci.checkChildContent.name }}</td>
            </tr>
            {{ } }}
        </table>
        <table class="tb fr">
            <tr><th>鉴定类型</th><th>结果</th></tr>
            {{ for (var n= PC_c.length,i= Math.round(n/2); i<n;i++ ){
                var PC_ci = PC_c[i];
            }}
            <tr>
                <td>{{=PC_ci.checkChild.name }}</td>
                <td>{{=PC_ci.checkChildContent.name }}</td>
            </tr>
            {{ } }}
        </table>
    </div>


    <!-- 机舱状况 -->
    <p class="caption mgT60">机舱状况</p>
    <table id="tb-nacelle1" class="tb tb-nacelle noBrdB">
        {{ var nacelle = dts[14].data ;}}
        <tr><th width="25%">查看部位</h>
            <th >程度</th>
            <th >拆卸痕迹</th>
        </tr>
        {{ var nacelle0 = nacelle[0] ;}}
        <tr>
            <td>{{=nacelle0.checkName}}</d>
            <td>{{=nacelle0.checkContent[0].checkChildContent.name}}</td>
            <td>{{=nacelle0.checkContent[1].checkChildContent.name}}{{= nacelle0.isAbNormal ?'<i></i>':'' }}</td>
        </tr>
    </table>
    <table class="tb tb-nacelle ">

        {{ for ( var i=1,n= nacelle.length;i<n;i++) {
            var nacelle_i = nacelle[i];
        }}
        <tr>
            <td width="25%">{{=nacelle_i.checkName}}</d>
            <td>{{=nacelle_i.checkContent.checkChildContent.name}}{{= nacelle_i.isAbNormal ?'<i></i>':'' }}</td>
        </tr>

        {{ } }}
    </table>


    <!-- 底盘及结构 -->
    <p  class="caption mgT100">底盘及结构</p>
    <div id="tb-chassis" class="feature clearfix">
        <p class="tb-th">底盘悬挂减震器</p>
        {{  var chassis = dts[15].data ;            }}
        <table class="tb fl">
            <tr><th>部位</th><th>结果</th></tr>
            {{ for (var i=0,n= Math.floor(chassis.length/2); i<n;i++ ){
                var chassis_i = chassis[i];
            }}
            <tr>
                <td>{{=chassis_i.checkName }}</td>
                <td>{{=chassis_i.checkContent.checkChildContent.name }}{{= chassis_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
        <table class="tb fr">
            <tr><th>部位</th><th>结果</th></tr>
            {{ for (var n= chassis.length,i= Math.round(n/2); i<n;i++ ){
                var chassis_i = chassis[i];
            }}
            <tr>
                <td>{{=chassis_i.checkName }}</td>
                <td>{{=chassis_i.checkContent.checkChildContent.name }}{{= chassis_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
    </div>
    <!-- 轮胎 -->

    <table id='tb-tyre' class="tb noBrdB">
        {{ var tyre = dts[10].data ;}}
        <p class="tb-th">轮胎</p>
        <tr><th width="15%">轮胎部位</th>
            <th width="20%">剩余胎纹(mm)</th>
            <th width="20%">制造日期</th>
            <th width="20%">轮胎规格</th>
            <th width="25%">更换建议</th>
        </tr>


        {{    for ( var i=0;i<4;i++) {
            var tyre_i=tyre[i],
                    tyre_i_rc= tyre_i.resultContent;
        }}
        <tr>
            <td>{{=tyre_i.checkName }}</td>
            <td>{{=tyre_i_rc? tyre_i_rc[0].resultContent:''}}</td>
            <td>{{=tyre_i_rc? tyre_i_rc[1].resultContent:''}}</td>
            <td>{{=tyre_i_rc? tyre_i_rc[2].resultContent:''}}</td>
            <td>{{=tyre_i.checkContent.checkChildContent.name }}{{= tyre_i.isAbNormal ?'<i></i>':'' }}</td>
        </tr>
        {{ } }}

    </table>
    <table class="tb noBrdB">
        {{    for ( var i=4,n=tyre.length;i<n;i++) {
            var tyre_i=tyre[i];
        }}
        <tr>
            <td width="25%">{{=tyre_i.checkName }}</td>
            <td>{{=tyre_i.checkContent.checkChildContent.name }}{{= tyre_i.isAbNormal ?'<i></i>':'' }}</td>
        </tr>
        {{ } }}

    </table>

    <!-- 刹车片 -->
    <div id="tb-brake" class="feature clearfix">
        <p class="tb-th">刹车片剩余寿命<span class="smCaption">（正常行驶4万公里更换）</span></p>
        {{  var brake = dts[12].data;            }}
        <table class="tb fl">
            <tr><th width="50%">部位</th><th>鉴定结果</th></tr>
            {{ for (var i=0,n= Math.floor(brake.length/2); i<n;i++ ){
                var brake_i = brake[i];
            }}
            <tr>
                <td>{{=brake_i.checkName }}</td>
                <td>{{=brake_i.checkContent.checkChildContent.name }}{{= brake_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
        <table class="tb fr">
            <tr><th width="50%">部位</th><th>鉴定结果</th></tr>
            {{ for (var n= brake.length,i= Math.round(n/2); i<n;i++ ){
                var brake_i = brake[i];
            }}
            <tr>
                <td>{{=brake_i.checkName }}</td>
                <td>{{=brake_i.checkContent.checkChildContent.name }}{{= brake_i.isAbNormal ?'<i></i>':'' }}</td>
            </tr>
            {{ } }}
        </table>
    </div>


    <!-- 路试 -->
    <p class="caption mgT40">路试</p>
    <table id="tb-roadTest" class="tb tb-col3 brdB">
        {{ var roadTest = dts[13].data[0] ,roadTest_c =roadTest.checkContent; }}
        <tr>
            <td>{{=roadTest_c[0].checkChildContent.name }}</td>
            <td>{{=roadTest_c[1].checkChildContent.name }}{{= roadTest.isAbNormal ?'<i></i>':'' }}</td>
        </tr>
    </table>
    {{ } }}
    </script>
</div>
</body>
</html>