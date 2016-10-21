$(function(){
    var $reportTpl = $('#ReportTpl');
    var data = $reportTpl.data("value").data;
    if (data) {
        // jsp 已经占用 <% %> 先使用{{}},再使用 <% %>
        var tpl = $reportTpl.html().replace(/\{\{/g,"<%").replace(/\}\}/g, "%>")
        $(".PrintIdentifyLayout").append(_.template(tpl, {variable: 'dts'})(data));
    }
});

