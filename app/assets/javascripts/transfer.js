$(function() {
  function swap_ensign() {
    from_exchange = $(".from_ensign").html();
    to_exchange = $(".to_ensign").html();
    $(".from_ensign").html(to_exchange);
    $(".to_ensign").html(from_exchange);
  }

  function change_exchange() {
    exchange_id = $(".from_ensign .ensign").data("exchange-id");
    rate = $(".from_ensign .ensign").data("guaranteed-rate");
    $("#payment_exchange_id").val(exchange_id);
    $("#payment_guaranteed_rate").text(rate);
  }

  function change_amount() {
    //Call when user change transfer_amount (recipient get)
    transfer_amount = $("#transfer_amount").val();
    guaranteed_rate = $("#payment_guaranteed_rate").text();
    fee = parseFloat($("#fee").text());
    amount = transfer_amount/guaranteed_rate + fee;
    $("#amount").val(amount);
  }

  function calculate_fee() {
    amount = $("#amount").val();
    if(amount.length == 0) return;
    exchange_id = $("#payment_exchange_id").val();
    $.ajax({
      type: "POST",
      contentType: "application/json; charset=utf-8",
      url: "/transfers/fee",
      data: JSON.stringify({amount: amount, exchange_id: exchange_id}),
      dataType: "json",
      success: function (result) {
        fee = result["fee"];
        $("#fee").text(fee);

        if (amount - fee <= 0) {
          error_str = "<span class='help-block'>" + result["msg"] + "</span>"
          $(".transfer_payment_amount").addClass("has-error");
          $(".transfer_payment_amount").find("span").remove();
          $(".transfer_payment_amount").append(error_str);
        } else {
          $(".transfer_payment_amount").removeClass("has-error");
          $(".transfer_payment_amount").find("span").remove();
          real_amount = amount - fee;
          guaranteed_rate = $("#payment_guaranteed_rate").text();
          transfer_amount = real_amount * guaranteed_rate;
          $("#real_amount").text(real_amount);
          $("#transfer_amount").val(transfer_amount);
        }
      },
      error: function (){
        error_msg = $("#failure_to_get_fee").text();
        window.alert(error_msg);
      }
    });
  }

  function change_input_currency() {
    from_currency = $(".from_ensign .ensign").data("currency");
    $("#sender_currency").val(from_currency);

    to_currency = $(".to_ensign .ensign").data("currency");
    $("#recipient_currency").val(to_currency);
  }

  calculate_fee();

  $(".fa-exchange").on("click", function(){
    swap_ensign();
    change_exchange();
    calculate_fee();
    $("#sender_katakana_name").toggle();
    change_input_currency();
  });

  $("#amount").on("change", function(){
    calculate_fee();
  });

  $("#transfer_amount").on("change", function(){
    change_amount();
  });

  $(".panel-body").each(function(){
    if ($(this).find(".has-error").length != 0) {
      $(this).addClass("in");
    }
  });
});
