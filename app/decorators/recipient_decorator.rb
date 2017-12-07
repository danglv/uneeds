class RecipientDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def account_type
    I18n.t "dictionary.account_types.#{object.account_type}" if
      object.account_type
  end

  def currency
    I18n.t "dictionary.currencies.#{object.currency}" if object.currency
  end
end
