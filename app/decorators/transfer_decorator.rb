class TransferDecorator < ApplicationDecorator
  decorates_association :payment
  decorates_association :sender
  delegate_all
  delegate :full_name, to: :sender, prefix: true
  delegate :decorated_currency, to: :payment

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def created_time
    format_datetime created_at, :time_format
  end
end
