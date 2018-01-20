function swap_currency() {
  $active_title = $("#payment_title .active");
  $hidden_title = $("#payment_title .hidden");
  $from_ensign = $(".from_ensign");
  $to_ensign = $(".to_ensign");
  $from_unit = $(".from_unit");
  $to_unit = $(".to_unit");
  $sender_currency = $("#sender_currency");
  $recipient_currency = $("#recipient_currency");

  change_payment_title($active_title, $hidden_title);
  swap_ensign($from_ensign, $to_ensign);
  swap_currency_inputs_unit($from_unit, $to_unit);
  swap_currency_params($sender_currency, $recipient_currency);
}

function change_payment_title($active_title, $hidden_title) {
  $active_title.removeClass("active").addClass("hidden");
  $hidden_title.removeClass("hidden").addClass("active");
}

function swap_ensign($from_ensign, $to_ensign) {
  from_html = $from_ensign.html();
  to_html = $to_ensign.html();
  $from_ensign.html(to_html);
  $to_ensign.html(from_html);
}

function swap_currency_inputs_unit($from_unit, $to_unit) {
  from_unit = $from_unit.first().text();
  to_unit = $to_unit.text();
  $from_unit.text(to_unit);
  $to_unit.text(from_unit);
}

function swap_currency_params($sender_currency, $recipient_currency) {
  from_currency = $sender_currency.val();
  to_currency = $recipient_currency.val();
  $sender_currency.val(to_currency);
  $recipient_currency.val(from_currency);
}

function calculate_fee(options = {}) {
  $amount = $("#amount");
  $fee = $("#fee");
  $real_amount = $("#real_amount");

  url = $fee.data("url");
  amount = $amount.val();
  if(amount.length == 0 || url.length == 0) return;
  options["amount"] = amount;
  $.ajax({
    type: "POST",
    contentType: "application/json; charset=utf-8",
    url: url,
    data: JSON.stringify(options),
    dataType: "json",
    async: false,
    success: function (result) {
      fee = result["fee"];
      $wrapper = $amount.closest(".form-group");
      $wrapper.find("span.help-block").remove();
      if (amount - fee <= 0) {
        error_str = "<span class='help-block error_span'>" + result["msg"] + "</span>"
        $wrapper.addClass("has-error");
        $wrapper.append(error_str);
      } else {
        $wrapper.removeClass("has-error");
        $fee.val(fee);
        real_amount = amount - fee;
        $real_amount.val(real_amount);
      }
    },
    error: function (){
      error_msg = $("#failure_to_get_fee").text();
      window.alert(error_msg);
    }
  });
}

function calculate_received_amount(real_amount, guaranteed_rate, $received_amount) {
  if(real_amount.length == 0 || guaranteed_rate.length == 0) return;
  received_amount = real_amount * guaranteed_rate;
  $received_amount.val(received_amount);
}

function calculate_amount(received_amount, guaranteed_rate, $real_amount, fee, $amount) {
  if(received_amount.length == 0 || guaranteed_rate.length == 0 || fee.length == 0) return;
  real_amount = received_amount/guaranteed_rate;
  amount = real_amount + parseFloat(fee);
  $real_amount.val(real_amount);
  $wrapper = $amount.closest(".form-group");
  $wrapper.find("span.help-block").remove();
  $wrapper.removeClass("has-error");
  $amount.val(amount);
}

function expand_panel_if_error_occur() {
  $(".panel-body").each(function(){
    if ($(this).find(".has-error").length != 0) {
      $(this).addClass("in");
    }
  });
}
