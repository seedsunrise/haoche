$(function(){
    $('.PrintArea').hide("fast");
    $(".ChangeBind").on("change input", function(){
        var className = "." + $(this).attr("id").replace("Action", "");
        var val = $(this).val();
        $(className).text(val);
        var maxlength = $(this).attr("maxlength");
        var leftWord = maxlength - val.length;
        if (leftWord < 0) {
            leftWord = 0;
        }
        $($(this).data("notice")).find("span").text(leftWord);
    });
    $(".ChangeBind").trigger("change");
    $(".PrintQRCode").on("click", function(){
        if($("#ActionChassisNumber").val().length != 17) {
            vex.dialog.alert("车架号必须为17位!");
            return;
        }
        window.print();
    });
    function minLength(text, maxLength) {
        if (text.length < maxLength) {
            return text;
        }
        return text.substring(0, maxLength);
    }
});