$(function(){
    window.DatePicker = {
        // 日期控件初始化
        initDatetimepicker: function() {
            $.fn.datepicker.dates['zh-CN'] = {
                days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
                daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
                daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
                months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                today: "今天",
                suffix: [],
                meridiem: ["上午", "下午"]
            };

            $(".DatePicker").each(function(){
                var $this = $(this);
                var $start = $($this.data("start"));
                var format = "yyyy年mm月dd日";
                if ($this.data("format")) {
                    format = $this.data("format");
                }
                var option = {};
                if ($start[0] && $start.val()) {
                    option = {
                        format: format,
                        language: 'zh-CN',
                        autoclose: true,
                        startDate: $start.val()
                    };
                } else {
                    option =  {
                        format: format,
                        autoclose: true,
                        language: 'zh-CN'
                    }
                }
                if ($this.data("viewmode")) {
                    option.format = "yyyy年mm月";
                    option.viewMode = "months";
                    option.minViewMode = "months";
                }
                $this.datepicker(option);
            });

            $('.DatePicker').each(function(){
                var value = $(this).val();
                if (!value || /年/.test(value)) {
                    return;
                }
                // 20160520 格式
                if ($(this).hasClass("DatePickerShort")) {
                    // Q端录入数据没有日期,默认为1号
                    if (value[6] == "0" && value[7] == "0") {
                        value = value.substring(0,7) + "1";
                    }
                    $(this).datepicker('update', new Date(value.substring(0,4) + "-" + value.substring(4,6) + "-" + value.substring(6,8)));
                } else if (/年/.test(value)){
                    $(this).datepicker('update', new Date(value.replace("年","-").replace("月","-")));
                } else {
                    $(this).datepicker('update', new Date(value));
                }
            });
        }
    };

    window.DatePicker.initDatetimepicker();
});