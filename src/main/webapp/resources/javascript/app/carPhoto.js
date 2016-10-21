$(function(){
    $(".FileUpload").fileupload({
        singleFileUploads: true,
        sequentialUploads: true,
        done: function (e, data) {
            if (data.result.error == 0) {
                var url = getImageUrl(data.result.file_path);
                $image = $('<div class="Container" data-source="' + url + '"><div class="Delete">-</div><img class="ImagePreShow FancyBoxImg" href="'+ data.result.file_path +'" src="' + data.result.file_path + '"></div>');
                $(".ImageGroupWrapper").append($image);
                initShapeShift();
            } else {
                vex.dialog.alert(data.result.error);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            vex.dialog.alert(errorThrown);
        }
    });
    // 必须先初始化
    var imgPrefix = $("#ImagePreFix").val();
    $(".Source input").each(function(){
        var url = $(this).val();
        if (url) {
            var tmp = imgPrefix + url;
            var img = '<div class="Container" data-source="' + url + '"><div class="Delete">-</div><img class="ImagePreShow FancyBoxImg" href="'+ tmp +'" src="' + tmp +'" /></div>';
            $(".ImageGroupWrapper").append(img);
        }
    });
    initShapeShift();
    $(".SubmitPhotoBtn").on("click", function(){
        var $source = $(".Source input");
        $source.each(function(){
            $(this).val("");
        });
        $(".ImageGroupWrapper .Container").each(function(index){
            var src = $(this).data("source");
            $source.eq(index).val(src);
        });
        if (!$(".ValidateRequired").val()) {
            vex.dialog.alert($(".ValidateRequired").data("error"));
            return;
        }
        var $form = $("#PhotoForm");
        $.ajax({
            url: $form.attr("action"),
            method: "post",
            dataType: "json",
            data: $form.serialize(),
            beforeSend: function(xhr){
                xhr.setRequestHeader("X-CSRF-TOKEN", $("input[name='_csrf']").val());
            },
            success: function() {
                var $vexContent = vex.dialog.alert("保存成功!");
                setTimeout(function(){
                    vex.close($vexContent.data().vex.id);
                }, 1500)
            },
            error: function(e) {
                vex.dialog.alert(e.responseJSON.message);
            }
        });

    });

    function getImageUrl(imageUrl) {
        var imageUrl = imageUrl.split("/");
        var out = "";
        for(var i=3;i<imageUrl.length;i++) {
            out += "/" + imageUrl[i];
        }
        return out;
    }

    function initShapeShift() {
        $(".ImageGroupWrapper").shapeshift({
            align: "left",
            gutterX: 20,
            gutterY: 20,
            colWidth: 150,
            columns: 6,
            paddingX: 0,
            paddingY: 0
        });
    }

    $("body").delegate(".Delete", "click", function(){
        $(this).parent().remove();
        $(".ImageGroupWrapper").trigger("ss-rearrange");
    });

    $(".FancyBoxImg").fancybox();
});
