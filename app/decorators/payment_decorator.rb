class PaymentDecorator < ApplicationDecorator
  decorates_association :transfer
  delegate_all
  delegate :sender_decorated_currency, :recipient_decorated_currency,
    to: :transfer

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
end
