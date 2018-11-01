$(document).ready( function () {
    $(".hide-button").on("click", function() {
        if ($(this).data("open") == undefined || $(this).data("open") == "false") {
            $(this).parent().css({"overflow": "hidden", "height": "5.5em"});
            $(this).html("&#x21a7;");
            $(this).data("open", "true");
        } else {
            $(this).parent().css({"overflow": "visible", "height": "100%"});
            $(this).html("&#x21a5;");
            $(this).data("open", "false");
        }
    });
});