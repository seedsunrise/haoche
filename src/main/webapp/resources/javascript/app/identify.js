$(function(){
    var Identify = {
        init: function() {
            this.initEvent();
        },

        initEvent: function() {
            $(".GroupList li").on("click", function(){
                var $this = $(this);
                if ($this.hasClass("OnGroupList")) {
                    return;
                }
                $.ajax({
                    url: $this.data("url"),
                    dataType: "html",
                    type: "get",
                    success: function(data) {
                        $(".OnGroupList").removeClass("OnGroupList");
                        $this.addClass("OnGroupList");
                        $(".DetailWrapper").html(data);
                        var $checkList = $(".CheckList li");
                        if ($checkList.length) {
                            $checkList.eq(0).trigger("click");
                        }
                        window.FormDate();
                        window.FormDateShort();
                    },
                    error: function(e) {
                        Message.alert("获取数据失败!");
                    }
                });
            });
            $("body").delegate(".CheckList li", "click", function(){
                var $this = $(this);
                if ($this.hasClass("OnCheckList")) {
                    return;
                }
                $.ajax({
                    url: $this.data("url") + "&identifyType=" + $("#IdentifyType").val() + "&carId=" + $("#CarId").val() + "&carVin=" + $("#CarVin").val(),
                    dataType: "html",
                    type: "get",
                    success: function(data) {
                        $(".OnCheckList").removeClass("OnCheckList");
                        $this.addClass("OnCheckList");
                        $(".CheckResultWrapper").html(data);
                    },
                    error: function(e) {
                        Message.alert("获取数据失败!");
                    }
                });
            });
        }
    }
    Identify.init();
});