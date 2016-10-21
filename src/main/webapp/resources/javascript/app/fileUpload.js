$(function(){
    $(".FileUpload").fileupload({
        done: function (e, data) {
            $(e.target).parent().find(".Btn").text("上传图片");
            if (data.result.error == 0) {
                var $input = $(this).parent().parent().find(".ImageSourceUrl");
                var url = getImageUrl(data.result.file_path);
                var originUrl = $input.val();
                var $preShow = $(this).parent().parent().find(".PreShowList");
                // 是否为多张图片
                if ($(this).hasClass("Multiple")) {
                    if (originUrl) {
                        $input.val(getSplitImageUrl(originUrl) + "|" + url);
                    } else {
                        $input.val(url);
                    }
                    var $img = $('<div class="ImageActionWrapper" data-source="' + url + '"><div class="DeleteImage">-</div><img class="ImagePreShow FancyBoxImg" href="' + data.result.file_path + '" src="' + data.result.file_path + '"></div>');
                    //if ($("#CarPhoto")[0]) {
                    //    $img = $('<img class="ImagePreShow" src="' + data.result.file_path + '">');
                    //}
                    $preShow.append($img);
                    // 针对商品图片上传
                    //if ($("#CarPhoto")[0]) {
                    //    initShapeshift();
                    //}
                } else {
                    $input.val(url);
                    var $image = $preShow.find(".ImagePreShow");
                    if ($image[0]) {
                        $image.attr("src", data.result.file_path);
                    } else {
                        $image = $('<div class="ImageActionWrapper" data-source="' + url + '"><div class="DeleteImage">-</div><img class="ImagePreShow FancyBoxImg" href="' + data.result.file_path + '" s src="' + data.result.file_path + '"></div>');
                        $preShow.append($image);
                    }
                }
            } else {
                vex.dialog.alert(data.result.error);
            }
        },
        add: function (e, data) {
            $(e.target).parent().find(".Btn").text("上传中...");
            data.submit();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            vex.dialog.alert(errorThrown);
        }
    });

    window.initShapeshift = function() {
        //$(".ImageWrapper").shapeshift({
        //    align: "left",
        //    colWidth: 1,
        //    columns: 1,
        //    paddingX: 0,
        //    paddingY: 0
        //});
        //$(".PreShowList").removeAttr("style");
        //var $containers = $(".ImageWrapper");
        //$containers.on("ss-added", function(e, selected){
        //    $(".PreShowList").removeAttr("style");
        //    if (!$(this).parent().hasClass("FileUploadWrapper")) {
        //        var $existsImage = $(this).find("img");
        //        // 已经有一张图片
        //        if ($existsImage.length > 1) {
        //            $(".FileUploadWrapper .PreShowList").append(
        //                '<img class="ImagePreShow" src="' +  $existsImage.eq(0).attr("src") + '">');
        //            $existsImage.eq(0).remove();
        //
        //            // 放回到上传区域必须重新初始化
        //            $(".ImageWrapper").shapeshift({
        //                align: "left",
        //                colWidth: 1,
        //                columns: 1,
        //                paddingX: 0,
        //                paddingY: 0
        //            });
        //        }
        //    }
        //});
        //$containers.on("ss-drop-complete", function(e, selected){
        //    var imgCount = $(".PreShowList img").length;
        //    var height = 0;
        //    if (imgCount > 0) {
        //        if (imgCount%2 == 0) {
        //            height = imgCount / 2 * 100;
        //        } else {
        //            height = Math.ceil(imgCount / 2) * 100;
        //        }
        //    }
        //    $(".PreShowList").css({
        //        "height": height + "px"
        //    });
        //    setImageUrl();
        //});

    };

    window.setImageUrl = function() {
        $('.PhotoWrapper .ImageWrapper').each(function(){
            var $img = $(this).find("img");
            var $input = $(this).parent().find("input");
            if ($img[0]) {
                $input.val(getImageUrl($img.attr("src")));
            } else {
                $input.val("");
            }
        });
    }
    function getImageUrl(imageUrl) {
        var imageUrl = imageUrl.split("/");
        var out = "";
        for(var i=3;i<imageUrl.length;i++) {
            out += "/" + imageUrl[i];
        }
        return out;
    }
    function getSplitImageUrl(imageUrl) {
        if (!imageUrl) {
            return "";
        }
        var imageUrl = imageUrl.split("|");
        if (imageUrl.length > 0) {
            return imageUrl.join("|");
        }
    }

    $("body").delegate(".DeleteImage", "click", function(e){
        var $wrapper = $(this).parent().parent();
        $(this).parent().remove();
        var $source = $wrapper.parent().find(".ImageSourceUrl");
        var out = "";
        var $all = $wrapper.find(".ImageActionWrapper");
        var length = $all.length;

        for (var index = 0; index < length; index++) {
            var tmp = $all.eq(index).data("source");
            if (index == length - 1) {
                out += tmp;
            } else {
                out += tmp + "|";
            }
        }
        $source.val(out);
    });
});