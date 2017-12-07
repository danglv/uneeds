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
    "#{first_name} #{last_name}"
  end

  def full_name_katakana
    "#{first_name_katakana} #{last_name_katakana}"
  end

  def country
    I18n.t "dictionary.#{object.country}" if object.country
  end

  def birthday
    format_datetime object.birthday, :date_format
  end
end
