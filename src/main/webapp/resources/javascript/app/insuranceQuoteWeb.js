$(function(){
    var drivingLicensePhoto = $("#DrivingLicensePhoto").val();
    if (drivingLicensePhoto) {
        var list = drivingLicensePhoto.split("|");
        var $wrapper = $(".swiper-wrapper");
        var prefix = $("#ImagePreFix").val();
        var html = "";
        for (var i = 0;i< list.length; i++) {
            html += '<div class="swiper-slide"><img src="' + prefix + list[i] +'"></div>';
        }
        $wrapper.append(html);
        $(".swiper-container").show();
        var mySwiper = new Swiper ('.swiper-container', {
            direction: 'horizontal',
            pagination: '.swiper-pagination'
        })
    }

    $("input[type='text']").on("focus", function(){
        if ($(this).val() == 0) {
            $(this).val("");
        }
    });

    $(".GlassInsuranceWrapper input").on("change", function(){
        $(".GlassInsuranceWrapper").trigger("click");
    });

    var $glassWrapper = $(".GlassInsurance");
    var price = $glassWrapper.find(".Price").val();
    if ($glassWrapper.find(".GlassType").val() == "1") {
        $(".GlassInsuranceWrapperImported .GlassInsuranceChecked").show();
        $(".GlassInsuranceWrapperNotImported .GlassInsuranceNotChecked").show();
        $(".GlassInsuranceWrapperImported input").val(price);
    } else {
        $(".GlassInsuranceWrapperNotImported .GlassInsuranceChecked").show();
        $(".GlassInsuranceWrapperImported .GlassInsuranceNotChecked").show();
        $(".GlassInsuranceWrapperNotImported input").val(price);
    }

    $(".GlassInsuranceWrapper").on("click", function(){
        var $price = $glassWrapper.find(".Price");
        var $type = $glassWrapper.find(".GlassType");
        var $this = $(this)
        $('.GlassInsuranceChecked').hide();
        $('.GlassInsuranceNotChecked').show();
        $this.find(".GlassInsuranceNotChecked").hide();
        $this.find(".GlassInsuranceChecked").show();
        var value = parseInt($this.find("input").val(), 10);
        if (isNaN(value)) {
            value = 0;
        }
        $(".OnGlassInsurance").removeClass("OnGlassInsurance");
        $this.addClass("OnGlassInsurance");
        if ($this.hasClass("GlassInsuranceWrapperImported")) {
            $type.val("1");
            $price.val(value);
        } else {
            $type.val("0");
            $price.val(value);
        }
    });

    $(".InsuranceForm").on("submit", function(e){
        e.preventDefault();
        var $form = $(this);
        var $btn = $(".FormBtnSubmit");
        if ($btn.hasClass("Disabled")) {
            return
        }
        $btn.addClass("Disabled").text("提交中...");

        $.ajax({
            url: $form.attr('action'),
            type: "post",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(getQuoteData()),
            beforeSend: function(xhr){
                xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
            },
            success: function(data) {
                $btn.removeClass("Disabled").text("提交");
                vex.dialog.alert("保存成功!");
            },
            error: function(e) {
                $btn.removeClass("Disabled").text("提交");
                if (e.responseJSON && e.responseJSON.message) {
                    vex.dialog.alert(e.responseJSON.message);
                } else {
                    vex.dialog.alert("发生错误了!");
                }
            }
        });
    });
    var getQuoteData = function() {
        var data = [];
        $(".DetailGroup").each(function(){
            var $this= $(this);
            var detail = {
                id: getPrice($this.find('.DetailDataId').val()),

            };
            if ($this.find(".Coverage")[0]) {
                detail.coverage = getPrice($this.find(".Coverage").val());
            }
            // 价格
            detail.price = getPrice($this.find(".Price").val());

            // 不计免赔
            detail.nonDeductible = getPrice($this.find(".DeductibleCheckPrice").val());
            detail.infoId = getPrice($this.find(".DetailDataInfoId").val());
            if ($this.find(".GlassType")[0]) {
                detail.isImported = getPrice($this.find(".GlassType").val());
            }
            detail.isConfirm = getPrice($this.find(".IsConfirm").val());
            detail.isConfirmDeductible = getPrice($this.find(".IsConfirmDeductible").val());
            data.push(detail);
        });
        return data;
    };

    var getPrice = function(val) {
        var item = parseInt(val, 10);
        if (!isNaN(item)) {
            return item;
        }
        return 0;
    };
});