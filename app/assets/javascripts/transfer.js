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
    var amount = $("#transfer_payment_attributes_amount").val();


    $.ajax({
      type: "POST",
      contentType: "application/json; charset=utf-8",
      url: "/transfers/fee",
      data: JSON.stringify({amount: amount}),
      dataType: "json",
      success: function (result) {
        $(".transfer_fee .fee").text(result["fee"]);
        var real_amount = amount - result["fee"];
        $(".real_amount .amount").text(real_amount);
        if (amount - result["fee"] <= 0) {
          var error_str = '<span class="help-block">amount must be greater than fee!</span>';
          $(".transfer_payment_amount").addClass("has-error");
          $(".transfer_payment_amount").find("span").remove();
          $(".transfer_payment_amount").append(error_str);
        } else {
          $(".transfer_payment_amount").removeClass("has-error");
          $(".transfer_payment_amount").find("span").remove();
          var transfer_amount = $(".guaranteed_rate:visible").text() * real_amount;
          $("input.transfer_amount").val(transfer_amount);
        }
      },
      error: function (){
        window.alert("get fee fail!");
      }
    });
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
