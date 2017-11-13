$(function() {
  $('.fa-exchange').on("click", function(){
    var exchange_id = $("#transfer_payment_exchange_id").val();
    var new_exchange_id = (exchange_id % 2) + 1;
    $("#transfer_payment_exchange_id").val(new_exchange_id);
    var jpy = $(".ensign.jpy");
    var cny = $(".ensign.cny");
    jpy.removeClass("jpy").addClass("cny");
    cny.removeClass("cny").addClass("jpy");
  });
});
