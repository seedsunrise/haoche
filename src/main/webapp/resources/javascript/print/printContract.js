$(function(){
    $(".PrintBtn").on("click", function(){
        window.print();
    });
    $(".Action").scrollToFixed();
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
});