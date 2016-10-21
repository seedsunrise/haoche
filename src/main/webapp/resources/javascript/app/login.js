$(function(){
    var index  = "/carSource/list?status=1";
    $.ajax({
        url: "/emp/isLogin",
        type: "post",
        dataType: "json",
        success: function(data) {
            if (data.msg == "已登录") {
                location.href = index;
            }
        }
    });
    $(".LoginForm").validate({
        errorClass: "LoginError",
        rules:{
            UserName: {
                required: true
            },
            Password: "required"
        },
        messages: {
            UserName: {
                required: "请填写用户名/手机号码",
            },
            Password: "密码不能为空"
        },
        submitHandler:function(form){
            var $form = $(".LoginForm");
            var $btn = $(".SubmitBtn");
            if ($btn.hasClass("Disabled")) {
                return
            }
            $btn.addClass("Disabled").text("登录中...");
            $.ajax({
                url: $form.attr('action'),
                type: "post",
                dataType: "json",
                data: {
                    "userName": $form.find("#UserName").val(),
                    "password": $form.find("#Password").val()
                },
                beforeSend: function(xhr){
                    xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                },
                success: function() {
                    location.href = index;
                },
                error: function(e) {
                    $btn.removeClass("Disabled").text("登录");
                    vex.dialog.alert(e.responseJSON.message);
                }
            });
        }
    });
});