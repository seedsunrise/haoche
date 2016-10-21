$(function(){
    var  InsuranceQuote = {
        init: function() {
            var self = this;
            this.initClickEvent();
            this.initCarInsuranceList();
            $(".ChangeReadOnly").on("click", function(){
                $("#HasInsuranceQuoteForm input").removeAttr("readonly");
                $("#HasInsuranceQuoteForm input[type='text']").each(function(){
                    if ($(this).val() == 0) {
                        $(this).val("");
                    }
                });
                $(".SpanImportedInfo").hide();
                $(".DeductibleCheck").addClass("DeductibleCheckEdit");
                $(".HiddenImportedInfo").show();
                $(this).hide();
            });
            $("#HasInsuranceQuoteForm").delegate("input", "change", function(){
                self.calculateTotal();
            });
            $("body").delegate(".DialogHasInsuranceQuote .DetailCheck", "change", function(){
                var $this = $(this);
                if (!$this.is(":checked")) {
                    $this.parent().parent().find(".DeductibleCheck").removeAttr("checked");
                }
            });
            $("body").delegate(".DialogHasInsuranceQuote .DeductibleCheck", "change", function(){
                var $this = $(this);
                if ($this.is(":checked")) {
                    $this.parent().find(".DetailCheck").prop("checked", true);
                }
            });
            $(".FormatRestTime").each(function(){
                var text = $(this).text();
                if (text && text != "下一年保险未生效") {
                    var tmp = text.split(",");
                    var out = '';
                    if (tmp.length > 1) {
                        out += "剩余:";
                        if (parseInt(tmp[0], 10) > 0) {
                            out += tmp[0] + "年";
                        }
                        if (parseInt(tmp[1], 10) > 0) {
                            out += tmp[1] + "个月";
                        }
                        if(parseInt(tmp[2], 10) > 0){
                            out += tmp[2] + "天到期";
                        }

                    }
                    $(this).text(out);
                }
            });
        },
        initCarInsuranceList: function() {
            var self = this;
            $(".ChoseInsurance").on('click', function(){
                var $checked = $("#ChoseInsuranceForm").find("input[type='radio']:checked");
                if (!$checked[0]) {
                    vex.dialog.alert("请选择保单");
                    return;
                }
                Util.Ajax({
                    url: "/carInsurance/chooseQuote",
                    data: {
                        "id": $checked.data("infoid")
                    },
                    $btn: $(this)
                });
            });

            $('body').delegate('.GetPayInsuranceInfo', 'click', function(){
                $(".PayInsuranceInfoWrapper input, .PayInsuranceInfoWrapper textarea").val("");
                $(".PayInsuranceInfoWrapper .PreShowList").html("");
                $(".HiddenImportedInfo").hide();
                if ($(".HiddenImportedInfo").val() == "0") {
                    $(".SpanImportedInfo").text("国产").show();
                } else {
                    $(".SpanImportedInfo").text("进口").show();
                }
                $(".ChangeReadOnly").show();
                var $btn = $(this);
                $(".DialogPayInsurance").show();
                Util.Ajax({
                    url: $btn.data("url"),
                    $btn: $btn,
                    dataType: "html",
                    nameSpace: "GetPayInsuranceInfo",
                    noInterActive: true
                });
            });

            $('body').on("GetPayInsuranceInfo:SUCCESS", function(e, data){
                $(".DialogPayInsurance .PayInsuranceInfoWrapper .AjaxInfo").html(data.data);
                $(".SubmitInsurancePayInfo").removeClass("Disabled");
                var price = $(".InsuranceTotalPrice").val();
                $(".PayInsurancePrice").attr("placeholder", "支付金额不得低于" + price + "元")
                    .data("price", price);
            });

            $('body').delegate('.GetRenewalPayInsuranceInfo', 'click', function(){
                var $btn = $(this);
                $(".DialogRenewalPayInsurance").show();
                $(".DialogRenewalPayInsurance .AjaxInfo").html("");
                Util.Ajax({
                    url: $btn.data("url"),
                    $btn: $btn,
                    dataType: "html",
                    nameSpace: "GetRenewalPayInsuranceInfo",
                    noInterActive: true,
                    normalText: "选择此项保单"
                });
            });
            $('body').on("GetRenewalPayInsuranceInfo:SUCCESS", function(e, data){
                $(".DialogRenewalPayInsurance .PayInsuranceInfoWrapper .AjaxInfo").html(data.data);
                $(".SubmitInsurancePayInfo").removeClass("Disabled");
                var price = $(".InsuranceTotalPrice").val();
                $(".PayInsurancePrice").attr("placeholder", "支付金额不得低于" + price + "元")
                    .data("price", price);
            });

            $('body').delegate(".SubmitInsurancePayInfo", "click", function(e){
                var $btn = $(this);
                e.preventDefault();
                var $payPrice = $(".PayInsurancePrice");
                var price = self.getPrice($payPrice.val());
                var payPrice = self.getPrice($payPrice.data("price"));
                var isRenewal  = false;
                if ($btn.hasClass("SubmitRenewalInsurancePayInfo")) {
                    isRenewal = true;
                }
                if (price < payPrice && !isRenewal) {
                    vex.dialog.alert("支付金额不得低于" + payPrice + "元!");
                    return;
                }
                var orderBeginTime = $(".OrderBeginTime").val();
                if (orderBeginTime == "") {
                    vex.dialog.alert("请设置车险生效时间!");
                    return;
                }
                var pic = $(".InsuranceOrderPic").val();
                if (pic == "" && !isRenewal) {
                    vex.dialog.alert("请上传车险保单!");
                    return;
                }
                var insurance = {
                    id: self.getPrice($(".InsuranceOrderId").val()),
                    infoId: self.getPrice($(".InsuranceInfoId").val()),
                    totalPrice: self.getPrice($(".InsuranceTotalPrice").val()),
                    orderPrice: price,
                    orderPic: pic,
                    orderMemo: $(".PayOrderMemo").val(),
                    orderBeginTime: orderBeginTime
                };
                $.ajax({
                    url: "/carInsurance/orderPay",
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(insurance),
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        $btn.removeClass("Disabled").text("提交");
                        var $vexContent = vex.dialog.alert("提交成功!");
                        setTimeout(function(){
                            vex.close($vexContent.data().vex.id);
                            location.reload();
                        }, 1500)
                    },
                    error: function(e) {
                        $btn.removeClass("Disabled").text("提交");
                        vex.dialog.alert(e.responseJSON.message);
                    }
                })
            });
            $(".GetInsuranceMsg").on("click", function(){
                $(".DialogShowRenewal").show();
                // if ($(this).hasClass("HideBtn")) {
                //     $("#HasInsuranceQuoteForm .BtnGroup").hide();
                // } else {
                //     $("#HasInsuranceQuoteForm .BtnGroup").show();
                // }
                // $(".ChangeReadOnly").show();
                $.ajax({
                    url: "/carInsurance/getRenewalInfo?carId=" + $(this).data("carid"),
                    method: "get",
                    dataType: "html",
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        $(".DialogShowRenewal .FromInner").html(data);
                        $(".DialogShowRenewal input").attr("disabled", "disabled");
                        self.calculateTotal();
                    },
                    error: function(e) {
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
            });
        },
        calculateTotal: function() {
            var total = 0;
            var self = this;
            $(".CalculateItem").each(function(){
                var $detailCheck = $(this).parent().find(".DetailCheck");
                if ($detailCheck[0] && !$detailCheck.is(":checked")) {
                    return;
                }
                if ($(this).hasClass("DeductibleCheckPrice") && !$(this).parent().find(".DeductibleCheck").is(":checked")) {
                    return;
                }
                total += self.getPrice($(this).val());
            });
            $('.InsuranceQuoteItemShowTotal span').text(total);
        },

        getPrice: function(val) {
            var item = parseInt(val, 10);
            if (!isNaN(item)) {
                return item;
            }
            return 0;
        },

        initClickEvent: function() {
            var self = this;
            $(".InsuranceQuoteBtn").on("click", function(){
                $($(this).data("dialog")).show();
                $("body").addClass("vex-open");
            });
            $(".DialogClose").on("click", function(){
                $($(this).data("close")).hide();
                $("body").removeClass("vex-open");
            });

            $(".NotInsuranceQuote").on("click", function(){
                var title = $(this).data("cartitle");
                var list = $(this).parent().find("select").html();
                var id = $(this).data("carid");
                var $dialog = $(".DialogNotInsuranceQuote");
                $dialog.find("h2").text(title);
                $dialog.find("select").html(list).trigger("chosen:updated");
                $dialog.find("input[name='carId']").val(id);
                var url = $dialog.find(".PreViewInsuranceQuote").data("url");
                $dialog.find(".PreViewInsuranceQuote").prop("data-url", url + id);
            });

            $(".ShowInsuranceList").on("click", function(){
                var title = $(this).data("cartitle");
                var $dailog = $(".DialogOnInsuranceQuote");
                $dailog.find("h2").text(title);
                $dailog.show();
                var $data = $(this).parent().find(".InsuranceListData");
                var html = $data.html();
                if (!$data[0]) {
                    html = $(this).parent().parent().find(".InsuranceListData").html();
                }
                $dailog.find(".InsuranceListWrapper")
                    .html(html);
            });

            $(".ShowInsuranceListAjax").on("click", function(){
                var title = $(this).data("cartitle");
                var $dailog = $(".DialogOnInsuranceQuote");
                $dailog.find("h2").text(title);
                $dailog.show();
                var url = "/carInsurance/getQuoteInfos?carId=" + $(this).data("carid");
                if ($(this).hasClass("GetRenewalQuoteInfos")) {
                    url = "/carInsurance/getRenewalQuoteInfos?carId=" + $(this).data("carid");
                }
                $.ajax({
                    url: url,
                    method: "get",
                    dataType: "html",
                    success: function(data) {
                        $dailog.find(".InsuranceListWrapper")
                            .html(data);
                    },
                    error: function(e) {
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
                var $data = $(this).parent().find(".InsuranceListData");
                var html = $data.html();
                if (!$data[0]) {
                    html = $(this).parent().parent().find(".InsuranceListData").html();
                }
                $dailog.find(".InsuranceListWrapper")
                    .html(html);
            });


            $(".PreViewInsuranceQuote").on("click", function(){
                window.open("http://" + location.host + $(this).prop("data-url"), "", 'width=640,height=800, top=100,left=200');
            });

            $(".SubmitInsuranceQuote").on("click", function(){
                if (!$("#quoterId").val().trim()) {
                    vex.dialog.alert("请选择报价人!");
                    return;
                }
                var $form = $($(this).data("form"));
                var $btn = $(this);
                if ($btn.hasClass("Disabled")) {
                    return
                }
                if ($btn.hasClass("NotSuccessInsurance")) {
                    $btn.addClass("Disabled");
                    self.initClock($btn);
                } else {
                    $btn.addClass("Disabled").text("提交中...");
                }
                $.ajax({
                    url: $form.attr('action'),
                    type: "post",
                    dataType: "json",
                    data: $form.serialize(),
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        if (!$btn.hasClass("NotSuccessInsurance")) {
                            $btn.removeClass("Disabled").text("提交报价单");
                        }
                        var $vexContent = vex.dialog.alert("提交成功!");
                        setTimeout(function(){
                            vex.close($vexContent.data().vex.id);
                        }, 1500)
                    },
                    error: function(e) {
                        if (!$btn.hasClass("NotSuccessInsurance")) {
                            $btn.removeClass("Disabled").text("提交报价单");
                        }
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
            });

            $(".SubmitQuote").on("click", function(){
                var $form = $($(this).data("form"));
                var $btn = $(this);
                if ($btn.hasClass("Disabled")) {
                    return
                }
                $("#HasInsuranceQuoteForm input").each(function(){
                    if(!$(this).hasClass("NotCheck") && $(this).val()== "") {
                        $(this).val("0");
                    }
                });
                if ($btn.hasClass("NotSuccessInsurance")) {
                    $btn.addClass("Disabled");
                    self.initClock($btn);
                } else {
                    $btn.addClass("Disabled").text("提交中...");
                }
                $.ajax({
                    url: $form.attr('action'),
                    type: "post",
                    dataType: "json",
                    contentType: "application/json",
                    data: JSON.stringify(self.getQuoteData()),
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        $btn.removeClass("Disabled").text("提交");
                        var $vexContent = vex.dialog.alert("提交成功!");
                        $("#HasInsuranceQuoteForm input[type='text']").attr("readonly", "readonly");

                        $(".HiddenImportedInfo").hide();

                        if ($(".HiddenImportedInfo").val() == "0") {
                            $(".SpanImportedInfo").text("国产").show();
                        } else {
                            $(".SpanImportedInfo").text("进口").show();
                        }

                        $(".ChangeReadOnly").show();
                        setTimeout(function(){
                            vex.close($vexContent.data().vex.id);
                        }, 1500)
                    },
                    error: function(e) {
                        $btn.removeClass("Disabled").text("提交");
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
            });

            var self = this;
            $("body").delegate(".ShowInsuranceDetail", "click", function(){
                $(".DialogHasInsuranceQuote").show();
                if ($(this).hasClass("HideBtn")) {
                    $("#HasInsuranceQuoteForm .BtnGroup").hide();
                } else {
                    $("#HasInsuranceQuoteForm .BtnGroup").show();
                }
                $(".ChangeReadOnly").show();
                $.ajax({
                    url: "/carInsurance/getInsuranceQuoteTpl?id=" + $(this).data("infoid"),
                    method: "get",
                    dataType: "html",
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        $("#HasInsuranceQuoteForm .SubmitQuote").removeClass("Disabled");
                        $(".DialogHasInsuranceQuote .FromInner").html(data);
                        self.calculateTotal();
                    },
                    error: function(e) {
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });

            });
        },
        getQuoteData: function() {
            var data = [];
            var self = this;
            $(".DialogHasInsuranceQuote .InsuranceQuoteFormGroupData").each(function(){
                var $this= $(this);
                var detail = {
                    id: self.getPrice($this.find('.DetailDataId').val())
                };
                if ($this.find(".Coverage")[0]) {
                    detail.coverage = self.getPrice($this.find(".Coverage").val());
                }
                // 价格
                detail.price = self.getPrice($this.find(".Price").val());

                var $detailCheck = $this.find('.DetailCheck');
                // 该项是否有可选,有,再判断是否选中,否则默认选中
                if (($detailCheck[0] && $detailCheck.is(":checked")) || !$detailCheck[0]) {
                    detail.isConfirm = 1;
                } else {
                    detail.isConfirm = 0;
                }
                var $deductibleCheck = $this.find(".DeductibleCheck");
                if (($deductibleCheck[0] && $deductibleCheck.is(":checked")) || !$deductibleCheck[0]) {
                    detail.isConfirmDeductible = 1;
                } else {
                    detail.isConfirmDeductible = 0;
                }
                // 不计免赔
                detail.nonDeductible = self.getPrice($this.find(".DeductibleCheckPrice").val());
                detail.infoId = self.getPrice($this.find(".DetailDataInfoId").val());
                if ($this.find(".IsImported")[0]) {
                    detail.isImported = self.getPrice($this.find(".IsImported").val());
                }
                data.push(detail);
            });
            return data;
        },
        initClock: function($button) {
            var count = 60;
            var oldText = $button.text();
            var interval = setInterval(function(){
                if (count > 0) {
                    $button.text("再次提交(" + count + ")");
                    count--;
                } else {
                    clearInterval(interval);
                    $button.text(oldText).removeClass("Disabled");
                }
            },1000);
        }
    }
    InsuranceQuote.init();
});