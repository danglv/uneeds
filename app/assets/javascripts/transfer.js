$(function() {
  function change_ensign() {
    var jpy = $(".ensign.jpy");
    var cny = $(".ensign.cny");
    jpy.removeClass("jpy").addClass("cny");
    cny.removeClass("cny").addClass("jpy");
  }

  function init_ensign() {
    var exchange_id = $("#transfer_payment_attributes_exchange_id").val();
    var ensign = exchange_id == "1" ? "cny" : "jpy";
    if (exchange_id == "2") {change_ensign()};
    $(".exchange_" + ensign).toggle();
    $(".sender_info_name_" + ensign).toggle();
  }

  function change_exchange() {
    var exchange_id = $("#transfer_payment_attributes_exchange_id").val();
    var new_exchange_id = (exchange_id % 2) + 1;
    $("#transfer_payment_attributes_exchange_id").val(new_exchange_id);
  }

  function change_amount() {
    var amount = $("#transfer_amount").val()/$(".guaranteed_rate:visible").text();
    $("#transfer_payment_attributes_amount").val(amount);
  }
  // init ensign
  init_ensign();

  $('.fa-exchange').on("click", function(){
    change_exchange();
    change_ensign();

    $(".exchange").children().each(function(){
      $(this).toggle();
    });
    $(".sender_info_name").children().each(function(){
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
    change_amount();
  });
});
