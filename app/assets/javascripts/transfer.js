//= require "./transfers/_form"
$(function() {
  expand_panel_if_error_occur();
  if ($("#user_add_transfer").length > 0)
    user_calculate_received_amount();
  $("#user_add_transfer .fa-exchange").on("click", function(){
    swap_currency();
    user_change_exchange();
    user_calculate_received_amount();
  });

  $("#user_add_transfer #amount").on("change", function(){
    user_calculate_received_amount();
  });

  $("#user_add_transfer #received_amount").on("change", function(){
    user_calculate_amount();
  });
});

function user_change_exchange() {
  exchange_id = $(".from_ensign .ensign").data("exchange-id");
  guaranteed_rate = $(".from_ensign .ensign").data("guaranteed-rate");
  $("#exchange_id").val(exchange_id);
  $("#guaranteed_rate").val(guaranteed_rate);
}

function user_calculate_received_amount() {
  user_calculate_fee();
  real_amount = $("#real_amount").val();
  guaranteed_rate = $("#guaranteed_rate").val();
  $received_amount = $("#received_amount");
  calculate_received_amount(real_amount, guaranteed_rate, $received_amount);
}

function user_calculate_fee() {
  exchange_id = $(".from_ensign .ensign").data("exchange-id");
  options = {exchange_id: exchange_id};
  calculate_fee(options);
}

function user_calculate_amount() {
  received_amount = $("#received_amount").val();
  guaranteed_rate = $("#guaranteed_rate").val();
  fee = $("#fee").val();
  $amount = $("#amount");
  $real_amount = $("#real_amount");
  calculate_amount(received_amount, guaranteed_rate, $real_amount, fee, $amount);
}
