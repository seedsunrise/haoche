$(function(){
    var App = {
        init: function() {
            this.initUserSetting();
            this.initPagination();
            this.initSelect();
            this.initOther();
            this.initAjaxBtn();
            this.initYesNo();
            this.initCarSourceList();
            this.initGoods();
            this.initCarTotalNum();
            this.initGetCarConfig();
            this.initImage();
            this.initSort();
            this.initScrollTo();
            this.initAjaxForm();
            this.initMustParseInt();
        },
        initMustParseInt: function() {
            $(".MustParseInt").on("change", function(){
                var value = parseInt($(this).val(), 10);
                if (isNaN(value)) {
                    value = 0;
                }
                $(this).val(value);
            });
        },
        initAjaxForm: function() {
            $(".AjaxFormBtnSubmit").on("click", function(e){
                e.preventDefault();
                var $form = $($(this).data("form"));
                var valid= true;
                var $required = $form.find(".Required");
                for (var i =0; i < $required.length; i++) {
                    var $this = $required.eq(i);
                    if (!$this.val()) {
                        vex.dialog.alert($this.data("msg"));
                        valid = false;
                        break;
                    }
                }
                if (!valid) {
                    return
                }
                var $btn = $(this);
                if ($btn.hasClass("Disabled")) {
                    return
                }
                $btn.addClass("Disabled").text("提交中...");
                $.ajax({
                    url: $form.attr('action'),
                    type: "post",
                    dataType: "json",
                    data: $form.serialize(),
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        $btn.removeClass("Disabled").text("提交");
                        vex.dialog.alert("保存成功!");
                        var url = $form.data("reloadurl");
                        if (!$form.hasClass("NoRedirect")) {
                            setTimeout(function(){
                                location.href = url;
                            }, 2000)
                        }
                    },
                    error: function(e) {
                        $btn.removeClass("Disabled").text("提交");
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
            });
        },
        initScrollTo: function() {
            if (/EditDrivingLicensePhoto/.test(location.hash.replace("#", ""))) {
                $('body').animate({
                    scrollTop: $(".ShowDrivingLicensePhoto").offset().top
                }, 300);
            }
        },

        // 车源列表排序
        initSort: function() {
            $(".SortList a").click(function(){
                var $sortInput = $("#sortInput");
                var $scInput = $("#scInput");
                var sort = $sortInput.val();
                var sc = $scInput.val();
                $sortInput.val($(this).attr("sort"));
                if (sc == 'asc') {
                    $scInput.val("desc");
                } else {
                    $scInput.val("asc");
                }
                $(".MainSearchForm").submit();
            });
        },

        // 上传图片初始化
        initImage: function(){
            // 针对上传页面的图片预览
            $('.ImageSourceUrl').each(function(){
                var originUrl = $(this).val();
                if (originUrl) {
                    var list = originUrl.split("|");
                    var $preShow = $(this).parent().find(".PreShowList");
                    var prefix = $("#ImagePreFix").val();
                    for (var i = 0;i< list.length; i++) {
                        var tmp = prefix + list[i];
                        var $img = $('<div class="ImageActionWrapper" data-source="' + list[i] + '"><div class="DeleteImage">-</div><img class="ImagePreShow FancyBoxImg" href="' + tmp + '"src="' + tmp + '"></div>');
                        $preShow.append($img);
                    }
                }
            });
            // 上传图片页面图片反显
            $(".ImageShowList").each(function(){
                var originUrl = $(this).data("source");
                if (originUrl) {
                    var list = originUrl.split("|");
                    var $preShow = $(this);
                    var prefix = $("#ImagePreFix").val();
                    for (var i = 0;i< list.length; i++) {
                        var tmp = prefix + list[i];
                        var $img = $('<a class="FancyBoxImg" href="' + tmp + '"><img src="' + tmp + '"></a>');
                        $preShow.append($img);
                    }
                }
            });
            $(".FancyBoxImg").fancybox();
        },

        // 编辑车源获取车辆配置
        initGetCarConfig: function() {
            $(".ShowTutorial").on("click", function(){
                $(".DialogGetCarConfigTutorial").show();
            });
            var self = this;
            // 获取配置
            if ($('.GetCarConfig')[0]) {
                $("#carModelId").on("change", function(){
                    var modelId = $(this).val();
                    $("#GetCarConfigInput").val("");
                    if (!modelId) {
                        $('.CarConfigBtn').hide();
                        $(".GetCarConfig span").text("等待选择车型后匹配");
                        return;
                    }
                    if (modelId) {
                        $.ajax({
                            url: "/carConfig/getConfig?carModleId=" + modelId,
                            dataType: "json",
                            type: "get",
                            success: function(data) {
                                self.renderCarConfig(data, modelId);
                            },
                            error: function() {
                                vex.dialog.alert("获取配置失败!");
                            }
                        });
                    }
                });
                $(".UpdateCarConfig").on("click", function(){
                    $(".DialogGetCarConfig").show();
                });
                $(".NotFoundCarConfigUpdate").on("click", function(){
                    $(".DialogGetCarConfig").show();
                });

                // 更新配置
                $(".GetCarConfigBtn").on("click", function(){
                    var $this = $(this);
                    if ($this.hasClass("BtnDisabled")) {
                        return;
                    }
                    var autoHomeId = $('#GetCarConfigInput').val();
                    if (!autoHomeId) {
                        vex.dialog.alert("请输入车辆在汽车之家的ID!");
                        return;
                    }
                    $this.addClass("BtnDisabled");
                    var modelId = $("#carModelId").val();
                    if (!modelId) {
                        vex.dialog.alert("请选择车辆车型!");
                        return;
                    }
                    var textPrefix = $this.text();
                    $this.text("获取中...");
                    $.ajax({
                        url: "/carConfig/updateCarConfig",
                        dataType: "json",
                        type: "post",
                        data: {
                            "carModleId": modelId,
                            "autohomeId": autoHomeId
                        },
                        beforeSend: function(xhr){
                            xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                        },
                        success: function(data) {
                            $this.removeClass("BtnDisabled").text("提交");
                            var $vexContent;
                            if (data.code == 500) {
                                $vexContent = vex.dialog.alert("获取配置失败!");
                            } else {
                                $vexContent = vex.dialog.alert("获取配置成功!");
                            }
                            setTimeout(function(){
                                vex.close($vexContent.data().vex.id);
                                $(".DialogGetCarConfig").hide();
                            }, 1500);
                            self.renderCarConfig(data, modelId);
                        },
                        error: function() {
                            $this.removeClass("BtnDisabled").text("提交");
                            var $vexContent = vex.dialog.alert("获取配置失败!");
                            setTimeout(function(){
                                vex.close($vexContent.data().vex.id);
                            }, 1500)
                        }
                    });
                });
            }
        },
        renderCarConfig: function(data, modelId) {
            $(".CarConfigBtn").hide();
            if (data.code == 500) {
                $(".GetCarConfig span").text("未找到车型配置,请获取配置");
                $(".NotFoundCarConfigUpdate").show();
            } else {
                $(".GetCarConfig span").text("已匹配到车型配置");
                var $showCarConfig = $(".ShowCarConfig");
                var url = $showCarConfig.data("urlpre") + modelId;
                $showCarConfig.data("url", url).show();
                $(".UpdateCarConfig").show();
                $("#GetCarConfigInput").val(data.data.config.che168Id);
            }
        },
        initGoods: function() {
            // 列表也处理图片大小
            $(".FixImage").each(function(){
                var source = $(this).data("source");
                if (source) {
                    var url = source.split(".");
                    url = url[0] + $(this).data("param") + "." + url[1];
                    url = $(this).data("pre") + url;
                    var $img = $('<img src="' + url + '"/>');
                    $(this).append($img);
                }
            });

            var self = this;
            $(".LinkPrice").on("change", function(){
                var price = parseFloat($(this).val());
                if (!isNaN(price)) {
                    //$("#servicePriceClone").val(price*300);
                }
                self.calculatePrice();
                var id = "#" + $(this).attr("id").replace("Clone", "");
                if ($(this).hasClass("LinkPriceYuan")) {
                    $(id).val( self.parMoneyYuan($(this).val()).toFixed(0) );
                } else {
                    $(id).val( self.parMoney($(this).val()).toFixed(0));
                }
            });
            $(".PrintSelect").on("change", function(){
                var targetClass = $(this).val();
                $(this).val("");
                if (targetClass) {
                    $(this).parent().find(targetClass)[0].click();
                }
            });
        },

        calculatePrice: function() {
            var salPrice =  parseFloat(this.parMoney($(".LinkSalePrice").val()).toFixed(2));
            var newCarGuidancePrice = this.parMoney($(".LinkNewCarGuidancePrice").val());
            var servicePrice = this.parMoneyYuan($(".LinkServicePrice").val());
            var $savePrice = $(".LinkSavePrice");
            var price = newCarGuidancePrice - salPrice;
            $savePrice.text((price/10000).toFixed(2));
            var $totalPrice = $(".LinkTotalPrice");
            $totalPrice.text(((salPrice*10000 + servicePrice*10000)/10000/10000).toFixed(2));
        },

        // 传入万元
        parMoney: function(money) {
            var money = parseFloat(money);
            if (!isNaN(money)) {
                return (money.toFixed(4) * 100000000) / 10000;
            }
            return 0;
        },

        parMoneyYuan: function(money) {
            var money = parseInt(money, 10);
            if (!isNaN(money)) {
                return money;
            }
            return 0;
        },

        initCarSourceList: function() {
            // 操作记录
            //$(".GetCarOperationLog").onclick(function(){
            //
            //});
            // 调价定价
            $(".SetSalePrice").on("click", function(){
                var carid = $(this).data("carid");
                vex.dialog.open({
                    className: 'vex vex-theme-default SetSalePriceDialog',
                    message: $(this).text(),
                    input:
                    '<div class="DialogFormWrapper + DialogForm-' + carid + '" >' +
                        '<h2>' + $(this).data("carname") + '</h2>' +
                        '<form action="/carSource/updatePrice" method="post">'+
                            '<input type="hidden" value="' + carid + '" name="carInfoId" />' +
                            '<div class="FormItem ClearFix">' +
                                '<label class="FormLayout" for="salePrice">车主售价：</label>' +
                                '<div class="FormLayout FormItemControl">' +
                                    '<input placeholder="请输入车主售价" class="FormInput" type="text" id="salePrice" name="salePrice" value="'+ $(this).data("salprice") + '">' +
                                    '<span class="UnitYuan">元</span>' +
                                '</div>' +
                            '</div>' +
                            '<div class="FormItem ClearFix">' +
                                '<label class="FormLayout" for="servicePrice">品质保障服务费：</label>' +
                                '<div class="FormLayout FormItemControl">' +
                                    '<input placeholder="请输入乾坤服务费" class="FormInput" type="number" id="servicePrice" name="servicePrice" value="' + $(this).data("serviceprice") + '">' +
                                    '<span class="UnitYuan">元</span>' +
                                '</div>' +
                            '</div>' +
                        '</form>' +
                    '</div>',
                    callback: function(data) {
                        if (data) {
                            var $form = $(".DialogForm-" + carid).find("form");
                            $.ajax({
                                url: $form.attr('action'),
                                type: "post",
                                dataType: "json",
                                data: $form.serialize(),
                                beforeSend: function(xhr){
                                    xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                                },
                                success: function() {
                                    vex.dialog.alert("保存成功!");
                                    setTimeout(function(){
                                        location.reload();
                                    }, 1500)
                                },
                                error: function(e) {
                                    vex.dialog.alert(e.responseJSON.message);
                                }
                            });
                        }
                    }
                });
            });
        },

        initYesNo: function() {
            $(".YesNo").on("click", function(){
                var $this = $(this);
                if ($this.hasClass("BtnPrimary")) {
                    $this.removeClass("BtnPrimary");
                    $this.parent().find("input").val("0");
                    return;
                }
                $this.parent().find(".BtnPrimary").removeClass("BtnPrimary");
                $this.addClass("BtnPrimary");
                if ($this.hasClass("Yes")) {
                    $this.parent().find("input").val("1");
                    $($this.data("show")).show();
                } else {
                    $this.parent().find("input").val("2");
                    $($this.data("show")).hide();
                }
            });
            $(".YesNoIsExtendedWarranty").on("click", function(){
                var $this = $(this);
                $this.parent().find(".BtnPrimary").removeClass("BtnPrimary");
                $this.addClass("BtnPrimary");
                if ($this.hasClass("Yes")) {
                    $this.parent().find("input").val("0");
                } else {
                    $this.parent().find("input").val("1");
                }
            });
        },


        // 顶部用户设置弹框
        initUserSetting: function() {
            $(".HeaderUserWrapper .UserName").on("click", function(){
                $(".UserSetting").toggleClass("ShowUserSetting")
            });
        },

        // 分页跳转
        initPagination: function() {
            $(".PageNowGO").on("click", function(){
                var number = parseInt($(".PageInput").val());
                if (isNaN(number)) {
                    number = 1;
                }
                location.href = $(this).find("a").data("url") + (number - 1);
            });
        },

        // 自定义select
        initSelect: function() {
            var self = this;
            $(".CustomSelect").each(function(){
                if (!$(this).hasClass("NoCustomSelect")) {
                    $(this).chosen({
                        no_results_text: "没有找到"
                    });
                }
            });

            // 二级关联无法选中,触发选中
            $("select").each(function(){
                var value = $(this).attr("value");
                $(this).find("option").each(function(){
                    if ($(this).attr("value") == value) {
                        $(this).attr("selected", "selected");
                    }
                });
                $(this).trigger("chosen:updated");
            });

            $(".LinkSelect").on("change", function(){
                if (!$(this).val()) {
                    self.clearLinkSelect($(this));
                    return;
                };
                var $target = $("#" + $(this).data("link"));
                $.ajax({
                    url: $(this).data('url') + $(this).val(),
                    type: "get",
                    dataType: "html",
                    success: function(data) {
                        var value = $target.attr("value");
                        $target.html($(data));
                        $target.find("option").each(function(){
                            if ($(this).attr("value") == value) {
                                $(this).attr("selected", "selected");
                            }
                        });
                        $target.trigger("change", ["notSearch"]);
                        $target.trigger("chosen:updated");
                        self.clearLinkSelect($target);
                    },
                    error: function(e) {
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
            });

            $(".LinkSelect").each(function(){
                $(this).trigger("change",["notSearch"]);
            });
            $(".LinkedInput").on("change", function(){
                var $option = $(this).find("option:selected");
                var all = $(this).data("input");
                if (all) {
                    all = all.split(" ");
                    for(var index = 0;index < all.length; index++) {
                        $("." + all[index]).val($option.text());
                    }
                }
            });
            $(".LinkShopAddress").on("change", function(){
                var $option = $(this).find("option:selected");
                $("#shopAddress").val($option.data("address"));
            });
        },

        // 多级关联select 清除子选择项内容(父级已经改变)
        clearLinkSelect: function($target) {
            while ($target.hasClass("LinkSelect")) {
                $target = $("#" + $target.data("link"));
                $target.val("");
                //$target.attr("value", "");
                $target.html("<option value=''>请选择</option>");
                $target.trigger("change");
                $target.trigger("chosen:updated");
            }
        },

        initOther: function() {
            var self = this;
            // 角色页面点击checkbox 阻止事件
            $("input[type='checkbox']").on("click", function(e){
                e.stopPropagation();
            });

            $(".PermissionItem").on("click", function(){
                $(this).find("input[type='checkbox']").trigger("click");
                $(this).toggleClass("Selected");
            });

            $("input[type='radio']").on("click", function(e){
                e.stopPropagation();
            });
            $(".SourceTableItem").on("click", function(){
                var $radio = $(this).find("input[type='radio']");
                $radio.trigger("click");
                $(".Selected").removeClass("Selected");
                if ($radio.is(":checked")) {
                    $(this).addClass("Selected");
                } else {
                    $(this).removeClass("Selected");
                }
            });

            $(".SubmitCarGoods").on("click", function(){
                $(".ValidateForm").submit();
            });
            window.FormDate();
            window.FormDateShort();
            $("#runKmTmp").on("change", function() {
                var run = parseFloat($(this).val());
                if (isNaN(run)) {
                    run = 0;
                }

                if (!isNaN(run) && run > 0) {
                    $("#runKm").val(run * 10000);
                }
            });
            $(".RunKmFormat").each(function(){
                var run = parseFloat($(this).text());
                if (!isNaN(run) && run > 0) {
                    $(this).text(run/10000);
                }
            });

            $("#departmentId").on("change", function(){
                if ($(this).find("option:selected").text() == "品质整备部") {
                    $("#IdentifyFormGroup").addClass("IdentifyFormGroupHidden");
                } else {
                    $("#IdentifyFormGroup input").each(function(){
                        $(this).val("");
                    });
                    $("#IdentifyFormGroup").removeClass("IdentifyFormGroupHidden");
                }
            });
            if (!$("#SideBar .NoFixed")[0]) {
                $('#SideBar').scrollToFixed();
            }
            $(".SearchBox select").on("change", function(e, param){
                if (param == "notSearch") {
                    return;
                }
                if ($(this).attr("name") == "carBrandId") {
                    $("#carLineId").val("");
                }
                $(".MainSearchForm").submit();
            });
            $(".SearchBox .DatePicker").on("change", function(e, param){
                $(".MainSearchForm").submit();
            });

            $('.BtnPreView').on("click", function(){
                window.open($(this).data("url"), "", 'width=640,height=800, top=100,left=200');
            });

            $(".CalculateTotalPic").each(function(){
                var data = $(this).data("source");
                if (data) {
                    var tmp = data.split("|");
                    var $span = $(this).find("span");
                    if ($span[0]) {
                        $span.text(tmp.length);
                    }
                }
            });
        },

        // Ajax 按钮提交
        initAjaxBtn: function() {
            var self = this;
            $('.AjaxBtn').on("click", function(){
                var $this = $(this);
                if ($this.hasClass("OnAjax")) {
                    return;
                }
                var oldText = $this.text();
                if($this.hasClass("AjaxBtnInput")){
                    vex.dialog.open({
                        message: $this.data("title"),
                        input:'<input name="saleOnOffContent" type="text" class="CustomInput" placeholder="下架理由" required />',
                        buttons: [
                            $.extend({}, vex.dialog.buttons.YES, { text: '确认' }),
                            $.extend({}, vex.dialog.buttons.NO, { text: '取消' })
                        ],
                        callback: function(value) {
                            if (!value) {
                                return;
                            } else {
                                self.AjaxBtnSend($this, value)
                            }
                        }
                    })
                }
                else if ($this.hasClass("AjaxBtnConfirm")) {
                    vex.dialog.confirm({
                        message: $this.data("confirm"),
                        callback: function(value) {
                            if (!value) {
                                return;
                            } else {
                                self.AjaxBtnSend($this, oldText)
                            }
                        }
                    });
                } else {
                    self.AjaxBtnSend($this, oldText)
                }


            });

            $('.AjaxSelect').on("change", function(){
                var $this = $(this);
                if (!$this.val()) {
                    return;
                }
                var $select = $this.find("option:selected");
                if ($select.hasClass("OptionRedirect")) {
                    var win = window.open($select.val(), '_blank');
                    win.focus();
                } else {
                    if ($select.hasClass("AjaxBtnConfirm")) {
                        vex.dialog.confirm({
                            message: $select.data("confirm"),
                            callback: function(value) {
                                if (!value) {
                                    return;
                                } else {
                                    self.AjaxBtnSend($select, "")
                                }
                            }
                        });
                    } else {
                        self.AjaxBtnSend($select, "")
                    }
                }
            });

        },

        AjaxBtnSend: function($this, oldText) {
            console.info("oldText",oldText.saleOnOffContent);
            if ($this.data("pendingType") == "dialog") {
                vex.dialog.alert($this.data("pending"))
            } else {
                $this.text($this.data("pending"));
            }
            $this.addClass("OnAjax")
            var url = $this.data("url");
            if($this.data("dialogtype")==="input"){
                url = url+oldText.saleOnOffContent;
                console.info("url=="+url)
            }
            var reloadUrl = $this.data("reloadurl");
            $.ajax({
                url: url,
                type: "post",
                beforeSend: function(xhr){
                    xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                },
                success: function(data) {
                    if ($this.parent().hasClass("CustomSelectText")) {
                        $this.parent().find("option").eq(0).attr("selected", "selected");
                    }
                    if ($this.data("pendingType") == "dialog") {
                        vex.dialog.closeAll();
                    } else {
                        $this.text(oldText);
                    }
                    $this.removeClass("OnAjax");
                    vex.dialog.alert($this.data("msg"));
                    if (!reloadUrl && data.data && data.data.url) {
                        reloadUrl = data.data.url;
                    } else {
                    }
                    if (reloadUrl) {
                        setTimeout(function(){
                            location.href = reloadUrl;
                        }, 1500)
                    } else {
                        setTimeout(function(){
                            location.reload();
                        }, 1500)
                    }

                },
                error: function(e) {
                    if ($this.data("pendingtype") == "dialog") {
                    } else {
                        $this.text(oldText);
                    }
                    $this.removeClass("OnAjax");
                    vex.dialog.alert(e.responseJSON.message);
                }
            });
        },
        initCarTotalNum: function() {
            if ($(".GetCarPhotoNumber")[0]) {
                var $tmp = $(".GetCarPhotoNumber");
                $.ajax({
                    url: $tmp.data("url"),
                    method: "get",
                    dataType: "json",
                    success: function(data) {
                        if (data.data) {
                            $(".CarPhotoNumber").text(data.data.total);
                        }
                    }
                });
            }
        }
    };
    App.init();
});