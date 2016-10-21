$(function(){
    var Appointment = {
        init: function() {
            this.initReview();
        },
        initDateTimePicker: function() {
            $.fn.datetimepicker.dates['zh-CN'] = {
                days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
                daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
                daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
                months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                today: "今天",
                suffix: [],
                meridiem: ["上午", "下午"]
            };
            $('.DateTimePicker').datetimepicker({
                format: "yyyy年mm月dd日 hh:ii",
                autoclose: true,
                startDate: new Date,
                pickerPosition: 'top-right',
                language: 'zh-CN'
            });
        },
        initReview: function() {
            var self = this;
            $(".ReviewAppointment").on("click", function(){
                var $dialog = $($(this).data("dialog"));
                $dialog.show();
                var $this = $(this);
                $.ajax({
                    url: $this.data("url"),
                    type: 'get',
                    dataType: "html",
                    success: function(data) {
                        $dialog.find(".AppointmentDataWrapper").html(data);
                        if ($dialog.hasClass("DialogReviewedAppointment")) {
                            self.initDateTimePicker();
                            self.setProjectCheckItemList();
                        }
                    },
                    error: function(e) {
                        Message.alert(e.responseText);
                    }
                });
            });
            $("body").delegate(".ProjectCheckItemList input[type='checkbox']", "change", function(){
                self.setProjectCheckItemList();
            });
        },
        setProjectCheckItemList: function() {
            var out = [];
            $(".ProjectCheckItemList input:checked").each(function(){
                out.push($(this).val());
            });
            $("#InputProjectList").val(JSON.stringify(out));
        }
    };
    Appointment.init();
});