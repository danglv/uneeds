//= require "../transfers/_form"
$(function() {
  expand_panel_if_error_occur();

  $("#admin_add_transfer .fa-exchange").on("click", function(){
    swap_currency();
    admin_calculate_fee();
    admin_calculate_received_amount();
  });

  $("#admin_add_transfer #amount").on("change", function(){
    admin_calculate_fee();
    admin_calculate_received_amount();
  });

  $("#admin_add_transfer #guaranteed_rate").on("change", function(){
    admin_calculate_received_amount();
  });

  $("#admin_add_transfer #received_amount").on("change", function(){
    admin_calculate_amount();
  });
});

function admin_calculate_received_amount() {
  real_amount = $("#real_amount").val();
  guaranteed_rate = $("#guaranteed_rate").val();
  $received_amount = $("#received_amount");
  calculate_received_amount(real_amount, guaranteed_rate, $received_amount);
}

function admin_calculate_fee() {
  currency = $(".from_ensign .ensign").data("currency");
  options = {currency: currency};
  calculate_fee(options);
}

function admin_calculate_amount() {
  received_amount = $("#received_amount").val();
  guaranteed_rate = $("#guaranteed_rate").val();
  fee = $("#fee").val();
  $amount = $("#amount");
  $real_amount = $("#real_amount");
  calculate_amount(received_amount, guaranteed_rate, $real_amount, fee, $amount);
}
