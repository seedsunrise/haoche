/*
*
* [jquery validate 表单验证]
* 文档地址: https://jqueryvalidation.org/documentation/
* 1. Form 添加 ValidateForm class
* 2. 自定义错误信息请在 messages中加入对应的 name:messages
*
 */
$(function(){
    var Validate = {
        init: function() {
            var self = this;
            jQuery.validator.addMethod("mobile", function(value, element) {
                return /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value);
            }, $.validator.format("请输入正确的手机号"));

            $(".ValidateForm").each(function(){
                var $thisForm = $(this);
                $thisForm.validate({
                    errorClass: "ValidateError",
                    rules:{
                        repwd: {
                            required: true,
                            equalTo: "#password"
                        },
                        confirmPassword: {
                            required: true,
                            equalTo: "#newPassword"
                        },
                        mobile: {
                            required: true,
                            mobile: true
                        },
                        BuyUserMobile: {
                            required: true,
                            mobile: true
                        },
                        SaleUserMobile: {
                            required: true,
                            mobile: true
                        },
                    },
                    messages: {
                        cityName: "请输入城市名称",
                        baiduCityCode: "请输入百度城市Code",
                        realName: "请输入员工中文姓名",
                        baseCityId: "请选择所在城市",
                        departmentId: "请选择所属部门",
                        positionId: "请选择岗位",
                        mobile: {
                            required: "请输入手机号",
                            mobile: "请输入正确的手机号"
                        },
                        password: "请输入登录密码",
                        repwd: {
                            required: "请输入密码确认",
                            equalTo: "两次输入的密码不一致"
                        },
                        confirmPassword: {
                            required: "请输入新密码",
                            equalTo: "确认密码和新密码不一致"
                        },
                        departmentName: "请输入部门名称",
                        cityChar: "请选择城市首字母",
                        shopName: "请输入门店名称",
                        shopType: "请选择门店类型",
                        shopAddress: "请输入门店地址",
                        businessName: "请输入品牌名",
                        businessLogo: "请上传车商Logo",
                        star: "请选择星级",
                        address: "请输入地址",
                        groupName: "请输入角色名称",
                        cityId: "请选择所在城市",
                        brandName: "请输入品牌中文名称",
                        brandChar: "请选择品牌索引",
                        brandIcon: "请上传品牌缩略图",
                        subBrandName: "请输入生产厂商称",
                        carBrandId: "请选择所属品牌",
                        lineName: "请输入车系名称",
                        carSubBrandId: "请选择所属生成厂商",
                        modelName: "请输入车型名称",
                        businessCityId: "请选择所在城市",
                        businessProfile: "请输入经销公司",
                        carVin: "请输入车辆VIN码",
                        carTitle: "请输入商品标题",
                        salePriceClone: "请输入车主售价",
                        newCarGuidancePriceClone: "请输入款新车费用",
                        servicePriceClone: "请输入品质保障服务费",
                        carLineId: "请选择车系",
                        carModelId: "请选择车型",
                        positionName: "请输入职位名称",
                        shopId: "请选择门店",
                        checkCarNum: "请输入已检测车辆数",
                        level: "请输入资质等级",
                        profile: "请输入鉴定师简介",
                        levelCountry: "请输入国家资质等级",
                        newPassword: "请输入新密码",
                        loanAmount: "请输入银行放款金额",
                        alreadyPay: "请先确定应付额度",
                        content: "请输入备注",
                        contractImage: "请上传图片",
                        newDrivingLicense: "请上传新行驶证",
                        newRegistration: "请上传新登记证",
                        transferInvoice: "请上传过户发票",
                        newCarLicense: "请输入新车牌号",
                        projectTitle: "请输入项目标题",
                        BuyUserName: "请输入客户姓名",
                        BuyUserMobile: {
                            required: "请输入客户电话",
                            mobile: "请输入正确的手机号"
                        },
                        SaleUserMobile: {
                            required: "请输入顾问识别码",
                            mobile: "请输入正确的手机号"
                        },
                        BuyUserAddress: "请输入客户地址",
                        BuyUserIdCardNumber: "请输入客户身份证号码",
                        bannerType: "请选择广告类型",
                        clickType: "请选择点击效果",
                        bannerPic: "请上传广告图片"
                    },
                    submitHandler:function(form){
                        self.handleRoles();
                        if (self.handleImageNumberLimit()){
                            return;
                        }
                        var $form = $thisForm;
                        var $btn = $thisForm.find(".FormBtnSubmit");
                        if ($btn.hasClass("Disabled")) {
                            return
                        }
                        $btn.addClass("Disabled").text("提交中...");
                        self.handleCheckCarNum();
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
                                if ( data.code && data.code == 1001){
                                    vex.dialog.alert("上传图片过多!最多3张");
                                    return false;
                                }

                                vex.dialog.alert("保存成功!");
                                if ($form.hasClass("HistoryGo")) {
                                    setTimeout(function(){
                                        history.go(-1);
                                    }, 2000);
                                } else {
                                    if (data.data && data.data.url) {
                                        var url = data.data.url;
                                        if ($form.data("reloadurl")) {
                                            url = $form.data("reloadurl");
                                        }
                                        if (!$form.hasClass("NoRedirect")) {

                                            setTimeout(function(){
                                                location.href = url;
                                            }, 3000)
                                        }
                                    }
                                }
                            },
                            error: function(e) {
                                $btn.removeClass("Disabled").text("提交");
                                vex.dialog.alert(e.responseJSON.message);
                            }
                        });
                    }
                });
            });
        },
        // 针对角色(将checkbox的值统一到一个ActionsInput中)
        handleRoles: function() {
            var $actions = $("#ActionsInput");
            if ($actions[0]) {
                var allId = [];
                $("input:checked").each(function(){
                    allId.push($(this).data("actionid"));
                });
                $actions.val(allId);
            }
        },
        // 限制图片的数量
        handleImageNumberLimit: function() {
            var $all = $(".ImageSourceUrl");
            var length = $all.length;
            for (var item = 0; item < length; item++) {
                var $this = $all.eq(item);
                var total = $this.val().split("" + "|");
                var limit = parseInt($this.attr("image-number-limit"), 10);
                if (!isNaN(limit) && limit < total.length) {
                    Message.alert($this.attr("image-number-limit-msg") + "不能超过" + limit + "张");
                    return true;
                }
            }
            return false;
        },
        handleCheckCarNum: function() {
            if ($("#checkCarNum")[0] && $("#checkCarNum").val() == "") {
                $("#checkCarNum").val("0");
            }
        },
    };
    Validate.init();
});