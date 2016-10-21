$(function(){
    var Deal = {
        init: function() {
            this.initOrderStatusActive()
            this.initMaintain();
            this.initMaintainFollow();
            this.initCheckBoxAjaxSubmit();
            this.initLinkChange();
            this.initDatetimepicker();
            this.initShowLoanInfo();

        },
        initShowLoanInfo: function() {
            $('.ShowLoanInfo').on("click", function(){
                $('#DialogShowLoanInfo').show();
            });
        },
        initDatetimepicker: function() {
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
                format: "yyyy年mm月dd日 hh:ss",
                autoclose: true,
                startDate: new Date,
                language: 'zh-CN'
            });
        },
        initLinkChange: function() {
            $(".LinkChange").on("change", function(){
                var linkIdentify = $(this).data("linkchange");
                if (linkIdentify && $(linkIdentify)[0]) {
                    $(linkIdentify).val($(this).val());
                }
            });
        },
        initCheckBoxAjaxSubmit: function() {
            $(".CheckBoxAjax").on("change", function () {
                var $this = $(this);
                var $form = $($this.data("form"));
                var successMsg = $this.data("successmsg") || "保存成功!";
                var errorMsg = $this.data("errormsg") || "保存失败!";
                $.ajax({
                    url: $form.prop("action"),
                    method: "post",
                    dataType: "json",
                    data: $form.serialize(),
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function() {
                        Message.alert(successMsg);
                    },
                    error: function() {
                        Message.alert(errorMsg);
                    }
                });
            });
        },
        initMaintainFollow: function() {
            $(".CheckAction").on("change", function(){
                var targetClass = $(this).data("check");
                var isCheckValue = $(this).data("ischeck");
                var notCheckValue = $(this).data("notcheck");
                if (targetClass && $(targetClass)[0]) {
                    if ($(this).is(":checked")) {
                        $(targetClass).val(isCheckValue);
                    } else {
                        $(targetClass).val(notCheckValue);
                    }
                }
            });
        },
        initMaintain: function() {
            var self = this;
            $(".OpenDialog").on("click", function(){
                var dialogIdentify = $(this).data("open");
                if (dialogIdentify) {
                    $("body").addClass("vex-open");
                    $(dialogIdentify).show();
                }
            });
            $(".DialogClose").on("click", function(){
                var dialogIdentify = $(this).data("close");
                if (dialogIdentify) {
                    $("body").removeClass("vex-open");
                    $(dialogIdentify).hide();
                }
            });
            $(".MaintainCheckItemList input").on("click", function(){
                var $this = $(this);
                var $label = $this.parent();
                $($label.parent().data("maintain")).val(self.formMaintain($label));
            });
            self.initCheckItemList();
        },
        initCheckItemList: function() {
            $(".MaintainCheckItemList").each(function(){
                var checked = $($(this).data("maintain")).val();
                var result;
                if (checked) {
                    result = checked.split(",");
                }
                if (result && result.length) {
                    $(this).find("input[type='checkbox']").each(function(){
                        if (result.indexOf($(this).val()) != -1) {
                            $(this).prop("checked", true);
                        }
                    });
                }
            });

        },
        formMaintain: function($sourceLabel) {
            var $parent = $sourceLabel.parent();
            var out = [];
            $parent.find("input:checked").each(function(){
                out.push($(this).val());
            });
            return out.join(",");
        },
        // 当前流程图标激活
        initOrderStatusActive: function() {
            var activeNum = parseInt($("#nextOrderStatus").val(), 10) - 1;
            for (var i=0; i<activeNum ;i++){
                $('.orderFlow .n'+(i+1)).addClass('active');
            }
        }
    };
    Deal.init();

    // // 关闭  订单跟进
    // $('.close').click(function(){
    //     $('html').css('overflow','auto');
    //     // $('.windowBg').hide();
    //     $('.OverLay').hide();
    // });

    // 弹出 订单跟进
    $('#callOrdFow').click(function() {
        if ( nextOrderStatus > 6 || nextOrderStatus < 2 ) {
            return false;
        }
        // $('html').css('overflow', 'hidden');
        var $alertBox = $('.DealOverLay');
        // $alertBox.height($(window).height() * 0.8);
        // $('.windowBg').show();
        $alertBox.show();
        return false;

    });

    // 支付额度选择
    $('#orderFlowHack1').show();
    $('#tableHack1').show();

    $('#paySelect1').click(function(){
        $('.paySel').removeClass('payOn');
        $(this).addClass('payOn');
        $('#alreadyPay1').val('').attr('placeholder','支付金额不得低于1000');

        $('.orderFlowHack').hide().removeClass('ordFl_on');
        $('#orderFlowHack1').show().addClass('ordFl_on');
        $('.tableHack').hide();
        $('#tableHack1').show();
        $('input[name="statusId"]').val(2);
        $('.FormBtnSubmit').addClass('Disabled');
    });

    $('#paySelect2').click(function(){
        $('.paySel').removeClass('payOn');
        $(this).addClass('payOn');
        $('#alreadyPay1').val('').attr('placeholder','支付金额不得低于'+$('#shouldPay2').html());

        $('.orderFlowHack').hide().removeClass('on');
        $('#orderFlowHack2').show().addClass('on');
        $('.tableHack').hide();
        $('#tableHack2').show();
        $('input[name="statusId"]').val(3);
        $('.FormBtnSubmit').addClass('Disabled');
    });

    $('#paySelect3').click(function(){
        $('.paySel').removeClass('payOn');
        $(this).addClass('payOn');
        $('#alreadyPay1').val('').attr('placeholder','支付金额需等于'+$('#shouldPay3').html());

        $('.orderFlowHack').hide().removeClass('ordFl_on');
        $('#orderFlowHack3').show().addClass('ordFl_on');
        $('.tableHack').hide();
        $('#tableHack3').show();
        $('input[name="statusId"]').val(3);
        $('.FormBtnSubmit').addClass('Disabled');

    });

    var TotalSalePricePayTotalNow = parseFloat($("#TotalSalePrice-PayTotalNow").val());
    // 输入 银行放款金额 ，动态计算其他金额值
    $('#loanAmountInput').blur(function(){
        var price, check = checkNum( $(this));

        if( check ) {
            price = (TotalSalePricePayTotalNow- parseInt($(this).val())).toFixed(1);
            if (price <0 ) {
                price = 0;
            }
            $('#loanAmountSpan').html( $(this).val());
            $('#shouldPaySpan').html( price );
            $('.FormBtnSubmit').removeClass('Disabled');
        }else{
            $(this).val('').attr('placeholder','输入银行放款金额');
            $('.FormBtnSubmit').addClass('Disabled');
        }
    });

    var orderType = $("#orderType").val();
    var orderStatus = $("#OrderStatusOrderStatus").val();
    var orderId = $("#OrderInfoOrderId").val();
    // 输入 支付金额
    $('#alreadyPay1').blur(function(){

        var   txt,price,
            check= checkNum($(this));
        var $BtnSubmit = $('.FormBtnSubmit');

        if (orderType == 1){
            txt = '支付金额不得低于1000';
            if( check && parseInt($(this).val()) >= 1000  ){
               $BtnSubmit.removeClass('Disabled');
                return;
            }
        }else {
            var num = $('.payOn').attr('id').slice(9,10);
            if( num == 1){
                txt = '支付金额不得低于1000';
                if( check && parseInt($(this).val()) >= 1000  ){
                    $BtnSubmit.removeClass('Disabled');
                    return;
                }
            }
            if( num == 2){
                price = parseInt($('#shouldPay2').html()) ;
                txt = '支付金额不得低于'+price;
                if( check && parseInt($(this).val()) >=  price ){
                    $BtnSubmit.removeClass('Disabled');
                    return;
                }
            }
            if( num == 3){
                price = parseInt($('#shouldPay3').html()) ;
                txt = '支付金额需等于'+price;
                if( check && parseInt($(this).val()) >= price ){
                    $BtnSubmit.removeClass('Disabled');
                    return;
                }
            }
        }

        $(this).val('').attr('placeholder',txt);
        $BtnSubmit.addClass('Disabled');
    });

    $('#alreadyPay2').blur(function(){
        var price,
            check = checkNum( $(this));

        var $shouldPaySpan = $('#shouldPaySpan');
        if ( $shouldPaySpan.html()==''){
            $(this).val('').attr('placeholder','请先确定应付额度');
            $('.FormBtnSubmit').addClass('Disabled');
            return;
        }
        if (orderType == 1){
            price = parseInt($shouldPaySpan.html()?$shouldPaySpan.html():0);
        }
        if (orderType == 2) {
            price = (parseFloat($("#TotalSalePrice30-PayTotalNow").val())).toFixed(1);
        }
        if(check  && parseFloat($(this).val()) >= price ){
            $('.FormBtnSubmit').removeClass('Disabled');
        }else{
            $(this).val('').attr('placeholder','首付金额应不低于'+price);
            $('.FormBtnSubmit').addClass('Disabled');
        }
    });

    $('#alreadyPay4').blur(function(){

        var check = checkNum( $(this)),
            price =TotalSalePricePayTotalNow.toFixed(1);
        if(check  && parseInt($(this).val()) >= price){
            $('.FormBtnSubmit').removeClass('Disabled');
        }else{
            $(this).val('').attr('placeholder','本次支付金额应为'+price);
            $('.FormBtnSubmit').addClass('Disabled');
        }
    });
    $("#alreadyPay4").trigger("blur");

    // 判断输入为数字
    function checkNum(obj) {
        if ( obj.val()==''|| isNaN( obj.val() )) {
            return false;
        }
        return true;
    }

    // if (orderType == 1 && orderStatus == 2) {
    //     $.ajax({
    //         url: "/deal/getLoanAmount?orderId=" + orderId,
    //         method: "post",
    //         dataType: "json",
    //         success: function(data) {
    //             $("#loanAmountInput").val(data.data).trigger("blur");
    //         },
    //         error: function(e) {
    //             Message.alert("获取银行放款金额失败");
    //         }
    //     });
    // }
    $("#UpdateLoanAmountInput").on("click", function(){
        var loanAmount = parseFloat($("#loanAmountInput").val());
        if (isNaN(loanAmount)) {
            Message.alert("请输入银行放款金额");
            return;
        }
        $.ajax({
            url: "/deal/saveBankApproval",
            method: "post",
            dataType: "json",
            data: {
                orderId: orderId,
                bankLoanAmount: loanAmount
            },
            beforeSend: function(xhr){
                xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
            },
            success: function() {
                Message.alert("保存放款金额成功!");
            },
            error: function(e) {
                Message.alert("保存放款金额失败!");
            }
        });
    });
});