$(function() {
  $(".exchange_cny").toggle();
  $('.fa-exchange').on("click", function(){
    var exchange_id = $("#transfer_payment_exchange_id").val();
    var new_exchange_id = (exchange_id % 2) + 1;
    $("#transfer_payment_exchange_id").val(new_exchange_id);
    var jpy = $(".ensign.jpy");
    var cny = $(".ensign.cny");
    jpy.removeClass("jpy").addClass("cny");
    cny.removeClass("cny").addClass("jpy");
    $(".exchange").children().each(function(){
      $(this).toggle();
    });

    var transfer_amount = $(".guaranteed_rate:visible").text() * $("#transfer_payment_attributes_amount").val();
    $("input.transfer_amount").val(transfer_amount);
  });

  $("#transfer_payment_attributes_amount").on("change", function(){
    var transfer_amount = $(".guaranteed_rate:visible").text() * $("#transfer_payment_attributes_amount").val();
    $("input.transfer_amount").val(transfer_amount);
  });

  $("#transfer_amount").on("change", function(){
    var amount = $("#transfer_amount").val()/$(".guaranteed_rate:visible").text();
    $("#transfer_payment_attributes_amount").val(amount);
  });
});
