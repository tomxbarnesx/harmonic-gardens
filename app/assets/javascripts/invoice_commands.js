$(document).ready( function () {
    $(".invoice-clip-container").hide()
    $(document).on("click", ".hide-button", function() {
        if ($(this).data("closed") == undefined || $(this).data("closed") == "true") {
            $(this).nextAll(".invoice-clip-container").slideDown( 450 )
            // $(this).parent().css({"overflow": "hidden", "height": "5.5em"});
            $(this).html("<i class='fas fa-chevron-circle-down'></i>");
            $(this).data("closed", "false");
        } else {
            $(this).nextAll(".invoice-clip-container").slideUp( 450 );
            // $(this).parent().css({"overflow": "visible", "height": "100%"});
            $(this).html("<i class='fas fa-chevron-circle-up'></i>");
            $(this).data("closed", "true");
        }
    });
});