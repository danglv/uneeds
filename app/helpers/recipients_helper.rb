module RecipientsHelper
  def account_type_options
    Recipient.account_types.keys.map do |account_type|
      [I18n.t("dictionary.account_types.#{account_type}"), account_type]
    end
  end

  def currency_options
    Recipient.currencies.keys.map do |currency|
      [I18n.t("dictionary.currencies.#{currency}"), currency]
    end
  end
end
