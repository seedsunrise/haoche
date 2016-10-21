$(function(){
    var orderCarInfo = {
        init: function() {
            this.initEvent();
            this.initLinkInfo();
            this.initLoanEvent();
            this.initSubmitAction();
        },
        // 贷款
        initLoanEvent: function() {
            var self = this;
            $("#DownPaymentRatio").on("change", function(){
                var ratio = $(this).val();
                var salePrice = $("#UserSalePrice").val();
                var downPayment = salePrice * ratio / 100;
                var capital = salePrice-downPayment;

                $(".DownPayment").text(downPayment + "元");
                $(".Capital").text(capital + "元");
                $("#CapitalValue").val(capital);
                $("#UserDownPayment").val(downPayment);
                $("#UserCapital").val(capital);
                $("#LoadCompany").trigger("change");
                self.calculateLoanTotal();
            });
            $("#PeriodNumber").on("change", function(){
                $("#LoadCompany").trigger("change");
            });
            $("#LoadCompany").on("change", function(){
                var channelId = $(this).val();
                var downPayment = $("#UserCapital").val();
                var periodNumber = $("#PeriodNumber").val();
                if (periodNumber <= 0 ) {
                    return;
                }
                if (channelId && downPayment && periodNumber) {
                    $.ajax({
                        url: "/deal/getCarLoanRate",
                        type: "post",
                        dataType: "json",
                        data: {
                            "channelId": channelId,
                            "downPayment": downPayment,
                            "periodNumber": periodNumber
                        },
                        success: function(data) {
                            $("#channelRateYear").text(data.channelRateYear/100+"%/年");
                            $("#payments").text(data.payments+"元/月");
                            $(".EachMonthPayments").text(data.payments + "元");
                            $("#totalInterest").text(data.totalInterest+"元");
                        },
                        error: function(e) {
                            Message.alert(e.responseJSON.message);
                        }
                    });
                }
            });
        },
        calculateLoanTotal: function() {
            var total = 0;
            // 首付
            var downPayment = this.parseMoney($('#UserDownPayment').val());
            // 车险
            var insuranceTotalPrice = this.parseMoney($("#HiddenInsuranceTotalPrice").val());
            var servicePrice = this.parseMoney($("#ServicePrice").val());
            // 贷款本金
            var userCapital = this.parseMoney($("#UserCapital").val());
            total = downPayment + insuranceTotalPrice  + servicePrice + userCapital + 3300;
            $(".OrderLoanTotalPrice").text(total + "元");
            $("#TotalSalePrice").val(total);
        },
        initSubmitAction: function() {
            var self = this;
            $(".SubmitInsuranceCarOrder").on("click", function(){
                var $btn = $(this);
                var BuyUserName = $("#BuyUserName").val();
                if (!BuyUserName) {
                    Message.alert($("#BuyUserName").attr("placeholder"));
                    return;
                }
                var BuyUserMobile = $("#BuyUserMobile").val();
                if (!BuyUserMobile) {
                    Message.alert($("#BuyUserMobile").attr("placeholder"));
                    return;
                }
                var BuyUserIdCardNumber = $("#BuyUserIdCardNumber").val();
                if (!BuyUserIdCardNumber) {
                    Message.alert($("#BuyUserIdCardNumber").attr("placeholder"));
                    return;
                }
                var BuyUserAddress = $("#BuyUserAddress").val();
                if (!BuyUserAddress) {
                    Message.alert($("#BuyUserAddress").attr("placeholder"));
                    return;
                }
                var SaleUserMobile = $("#SaleUserMobile").val();
                if (!SaleUserMobile) {
                    Message.alert($("#SaleUserMobile").attr("placeholder"));
                    return;
                }
                var data = {
                    orderCarParam: {
                        buyUserName: BuyUserName,
                        buyUserMobile:  BuyUserMobile,
                        buyUserIdCardNumber: BuyUserIdCardNumber,
                        buyUserAddress: BuyUserAddress,
                        saleUserMobile: SaleUserMobile,
                        insurace: self.parseMoney($("#HiddenInsuranceTotalPrice").val()),
                        buyPrice: self.parseMoney($("#BuyPrice").val()) + self.parseMoney($("#ServicePrice").val()),
                        salePriceReal: self.parseMoney($("#BuyPrice").val()),
                        orderType: "2",
                        totalSalePrice: self.parseMoney($('#TotalSalePrice').val()),
                        carId: $("#CarId").val()
                    },
                    details: self.getQuoteData()
                };

                // 贷款下单
                if ($btn.hasClass("SubmitLoanCarOrder")) {
                    data.orderCarParam.buyPrice =  self.parseMoney($("#ServicePrice").val()) + self.parseMoney($("#UserDownPayment").val()) + 3300;
                    data.orderCarParam.orderType = "1";
                    data.orderCarParam.loanAmount = self.parseMoney($("#UserCapital").val());
                    data.orderCarParam.downPay = self.parseMoney($("#UserDownPayment").val());
                    data.orderCarParam.downPayPer = $("#DownPaymentRatio").val();
                }
                $btn.addClass("Disabled").text("提交中...");
                $.ajax({
                    url: "/deal/saveOrderCarInfo",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(data),
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        $btn.removeClass("Disabled").text("提交");
                        var $vexContent = vex.dialog.alert("提交成功!");
                        setTimeout(function(){
                            location.href = "/carGoods/list";
                        }, 1500)
                    },
                    error: function(e) {
                        $btn.removeClass("Disabled").text("提交");
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
            });
        },
        initLinkInfo: function() {
            $(".LinkInfo").on("change", function(){
                $($(this).data("linkid")).text($(this).val());
            });
            $(".MainItemStatus").on("change", function(){
                if (!$(this).is(":checked")) {
                    $(this).parent().parent().find(".SubItemStatus").removeAttr("checked");
                }
            });
            $(".SubItemStatus").on("change", function(){
                if ($(this).is(":checked")) {
                    $(this).parent().parent().find(".MainItemStatus").prop("checked", "checked");
                    $(this).prop("checked", "checked");
                }
            });
        },
        initEvent: function() {
            var self = this;
            $(".ShowOrderCarInfoWrapper").on("click", function(){
                if($(this).data("nextstep")=="2"){
                    if($("#BuyUserName").val()=="" || $("#BuyUserMobile").val()==""
                    || $("#BuyUserIdCardNumber").val()=="" || $("#BuyUserAddress").val()==""
                    || $("#SaleUserMobile").val()==""){
                        vex.dialog.alert("必输项不能为空");
                        return ;
                    }
                }
                // 贷款
                if ($(".ChoseLoan")[0] && $(this).data("nextstep") == "0") {
                    if ( !self.parseMoney($("#DownPaymentRatio").val()) ) {
                        vex.dialog.alert("请选择首付比例!");
                        return;
                    }
                    if ( !self.parseMoney($("#PeriodNumber").val()) ) {
                        vex.dialog.alert("请选择贷款期限!");
                        return;
                    }
                    if ( !self.parseMoney($("#LoadCompany").val()) ) {
                        vex.dialog.alert("请选择贷款金融!");
                        return;
                    }
                }

                $(".OrderCarInfoWrapper").hide();
                $($(this).data("show")).show();

                //  隐藏的select chose bug
                $($(this).data("show")).find(".NoCustomSelect").chosen({
                        no_results_text: "没有找到"
                });
                $(".GoodsStepOn").removeClass("GoodsStepOn");
                var next = $(this).data("nextstep");
                if ($(".ChoseLoan")[0]) {
                    next = next + 1;
                }
                $(".GoodsStepWrapper .GoodsStep").eq(next).addClass("GoodsStepOn");
            });
            var $all = $(".InsuranceGroup");
            if ($all.length) {
                // $all.eq(0).show();
                var firstGroupId = $all.eq(0).data("groupid");
                // $(".InsuranceGroup-" + firstGroupId).show().addClass("OnInsuranceGroup");
                this.selectInsuranceGroup(firstGroupId);
            }
            var self = this;
            $('#InsuranceSelect').on("change", function(){
                $all.hide();
                $(".OnInsuranceGroup").removeClass("OnInsuranceGroup");
                self.selectInsuranceGroup($(this).val());
                self.calculateInsurance();
                self.calculateLoanTotal();
            });
            $("body").delegate(".OnInsuranceGroup input[type='checkbox']", "change", function(){
                self.calculateInsurance();
                self.calculateLoanTotal();
            });
            self.calculateInsurance();

            self.calculateLoanTotal();
        },
        selectInsuranceGroup: function(selectInsuranceGroupId) {
            $(".InsuranceGroup-" + selectInsuranceGroupId).show().addClass("OnInsuranceGroup");
            var $priceWrapper = $(".InsuranceGroupWrapper-" + selectInsuranceGroupId);
            var strongPrice = $priceWrapper.find("input[name='交强险']").val();
            var otherPrice = $priceWrapper.find("input[name='车船使用税']").val();
            $(".StrongInsurance").text(strongPrice + "元").data("price", strongPrice);
            $(".UseInsurance").text(otherPrice + "元").data("price", otherPrice);
        },
        calculateInsurance: function() {
            var self = this;
            var otherPrice = 0;
            var totalInsurance = 0;
            $(".OnInsuranceGroup .InsuranceGroupItem").each(function(){
                var $this = $(this);
                var $mainStatus = $this.find(".MainItemStatus");
                var $subStatus = $this.find('.SubItemStatus');
                if ($mainStatus.is(":checked")) {
                    otherPrice += self.parseMoney($this.find(".MainPrice").data("price"));
                    if ($subStatus[0] && $subStatus.is(":checked")) {
                        otherPrice += self.parseMoney($this.find(".SubPrice").data("price"));
                    }
                }
            });
            var strongPriceAndBoatPrice = self.parseMoney($(".StrongInsurance").data("price")) + self.parseMoney($(".UseInsurance").data("price"));
            totalInsurance += otherPrice + strongPriceAndBoatPrice;
            $(".StrongAndBoatPrice").text(strongPriceAndBoatPrice + "元");
            $(".OtherPriceTotal").text(otherPrice + "元");
            $(".InsuranceTotalPrice").text(totalInsurance + "元");
            $("#HiddenInsuranceTotalPrice").val(totalInsurance);
            var total = this.parseMoney($("#ServicePriceAndSalePrice").val()) + totalInsurance;
            $(".OrderTotalPrice").text(total + "元");
            $("#TotalSalePrice").val(total);
        },
        parseMoney: function (value) {
            var price = parseInt(value, 10);
            if (!isNaN(price)) {
                return price;
            }
            return 0;
        },
        getQuoteData: function() {
            var data = [];
            var self = this;
            $(".OnInsuranceGroup .InsuranceGroupItem").each(function(){
                var $this= $(this);
                var detail = {
                    id: $this.data("detailid")
                };
                if ($this.find(".Coverage")[0]) {
                    detail.coverage = self.parseMoney($this.find(".Coverage").val());
                }
                // 价格
                detail.price = self.parseMoney($this.find(".MainPrice").data("price"));

                var $detailCheck = $this.find('.MainItemStatus');
                // 该项是否有可选,有,再判断是否选中,否则默认选中
                if (($detailCheck[0] && $detailCheck.is(":checked")) || !$detailCheck[0]) {
                    detail.isConfirm = 1;
                } else {
                    detail.isConfirm = 0;
                }
                var $deductibleCheck = $this.find(".SubItemStatus");
                if (($deductibleCheck[0] && $deductibleCheck.is(":checked")) || !$deductibleCheck[0]) {
                    detail.isConfirmDeductible = 1;
                } else {
                    detail.isConfirmDeductible = 0;
                }
                // 不计免赔
                detail.nonDeductible = self.parseMoney($this.find(".SubPrice").data("price"));
                detail.infoId = self.parseMoney($this.data("infoid"));
                if ($this.find(".IsImported")[0]) {
                    detail.isImported = self.parseMoney($this.find(".IsImported").val());
                }
                data.push(detail);
            });
            return data;
        }
    };
    orderCarInfo.init();
});