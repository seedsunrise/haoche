$(function(){
    window.Message = {
        alert: function(msg) {
            vex.dialog.alert(msg);
        }
    };

    window.FormDateShort = function() {
        $(".FormatDateShort").each(function(){
            var $this = $(this);
            var value = $this.text();
            if (value.length == 8) {
                $this.text(value.substring(0,4) + "年" + value.substring(4,6) + "月" + value.substring(6,8));
            }
        });

    };
    window.FormDate = function() {
        $(".FormatDate").each(function(){
            if ($(this).text()!= "") {
                $(this).text(getDate($(this).text()));
            }
        });

    };
    var getDate = function(dateString) {
        if (!dateString) {
            return "";
        }
        var date = new Date(dateString);
        return date.getFullYear() + "年" + formatNumber(date.getMonth() + 1) + "月" + formatNumber(date.getDate());
    };
    var formatNumber = function(number) {
        if (number > 9) {
            return number;
        }
        return "0" + number.toString();
    };


    window.Util = {
        /**
         *  requestParam = {
         *      $btn: $btn, // 可选
         *      normalText: "", // 可选
         *      pendingText: "", // 可选
         *      successMsg: "", // 可选
         *      "url": xxx,
         *      "type": 'post', // 可选
         *      "dataType": 'json', // 可选
         *      "data": xxx, // 可选
         *      "nameSpace": xxx, // 事件(成功/失败)前缀
         *  }
         *
         * // 事件监听例子
         * $("body").on("ChoseInsurance:SUCCESS", function(e, data){
         *      console.log(e);
         *      console.log(data);
         * });
         *
         */
        Ajax: function(requestParam) {
            if (!requestParam) {
                console.log("requestParam 参数必须");
                return;
            }
            var self = this;
            if (!requestParam.noInterActive && requestParam.$btn) {
                if (requestParam.$btn.hasClass("Disabled")) {
                    return
                }
                var pendingText = requestParam.pendingText || "提交中...";
                requestParam.$btn.addClass("Disabled").text(pendingText);
            }
            if (!requestParam.url) {
                console.log("requestParam.url 参数必须");
                return;
            }
            $.ajax({
                url: requestParam.url,
                type: requestParam.type || "post",
                // contentType: "application/json; charset=utf-8",
                dataType: requestParam.dataType || "json",
                data: requestParam.data || {},
                beforeSend: function(xhr){
                    xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                },
                success: function(data) {
                    if (!requestParam.noInterActive) {
                        self.resetBtn(requestParam);
                        var $vexContent = vex.dialog.alert(requestParam.successMsg || "提交成功!");
                        setTimeout(function(){
                            vex.close($vexContent.data().vex.id);
                        }, 1500)
                    }

                    // 回传参数
                    var returnData = {
                        requestParam: requestParam,
                        data: data
                    };
                    if (requestParam.nameSpace) {
                        // 触发成功事件
                        $("body").trigger(requestParam.nameSpace + ":SUCCESS", [returnData]);
                    }
                },
                error: function(e) {
                    self.resetBtn(requestParam);
                    // 回传参数
                    var error = {
                        response: e,
                        requestParam: requestParam
                    };
                    vex.dialog.alert(e.responseJSON.message);
                    // 回传参数
                    var returnData = {
                        requestParam: requestParam,
                        error: e
                    };
                    if (requestParam.nameSpace) {
                        // 触发失败事件
                        $("body").trigger(requestParam.nameSpace + ":ERROR", [returnData]);
                    }
                }
            });
        },
        resetBtn: function(requestParam) {
            if (requestParam.$btn) {
                var normalText = requestParam.normalText || "提 交";
                requestParam.$btn.removeClass("Disabled").text(normalText);

            }
        }
    };
});