$(function() {
  $(".change_locale").on("click", function(){
    $.ajax({
      type: "POST",
      contentType: "application/json; charset=utf-8",
      url: "/locales/change",
      data: JSON.stringify({locale: $(this).attr("alt")}),
      dataType: "json",
      success: function (result) {
      },
      error: function (){
        window.alert("set up fail!");
      }
    });
  });

  // spinner when ajax call
  $( document ).ajaxStart(function() {
    $("#page-loader").removeClass("hide");
  });

  $(document).ajaxSuccess(function() {
    $("#page-loader").addClass("hide");
  });
});
