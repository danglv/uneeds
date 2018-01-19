# SenderDecorator
class SenderDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def full_name
    "#{name}"
  end

  def full_name_katakana
    "#{name_katakana}"
  end

  def decorated_currency
    I18n.t "dictionary.currencies.#{object.currency}" if object.currency
  end

  # def country
  #   I18n.t "dictionary.#{object.country}" if object.country
  # end

  # def birthday
  #   format_datetime object.birthday, :date_format
  # end
end
