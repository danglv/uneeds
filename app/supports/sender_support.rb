# SenderSupport
class SenderSupport
  def country_options
    Sender.countries.keys.map do |country|
      [I18n.t("dictionary.#{country}"), country]
    end
  end
end
