$(function(){
    var Home = {
        init: function() {
            this.initHomeStatic();

        },
        initHomeStatic: function() {
            var $form = $(".HomeStaticForm");
             $form.find("input").on("change", function(){
                 $form.submit();
            });
        }
    }
    Home.init();
});