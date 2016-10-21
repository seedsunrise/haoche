$(function(){
    $(".carSourcesEditForm").find("#carVin").on("blur",function(){
        debugger;
        console.info("input===="+$(".carSourcesEditForm").find("input[name='id']"));
        var id = $("input[name='id']").val();
        var id2 = $(".carSourcesEditForm").find("#carInfoId").val();
        console.info(id);
        console.info("id2====="+id2);
        if(id==="0"){
            var carVin = $(this).val();
            if(carVin==="" || carVin===null){

            }else{
                console.info("x2");
                $.ajax({
                    url: "/carSource/carVinValidate",
                    method: "post",
                    dataType: "json",
                    data: {"carVin":carVin},
                    beforeSend: function(xhr){
                        xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
                    },
                    success: function(data) {
                        console.info(data);
                        if(data.data===1){
                            $("#carVin").val("");
                            vex.dialog.alert("该车源已成功添加，请核对后重新输入");
                        }else{

                        }
                    },
                    error: function(e) {
                        vex.dialog.alert(e.responseJSON.message);
                    }
                });
            }
        }
    })
});