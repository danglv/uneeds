class TransferDecorator < ApplicationDecorator
  decorates_association :payment
  delegate_all

  delegate :name, :decorated_currency, to: :sender_object, prefix: :sender
  delegate :full_name, :decorated_currency, to: :recipient_object,
    prefix: :recipient

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def decorated_created_time
    format_datetime created_at, :time_format
  end

  def sender_object
    Sender.new(sender_data).decorate
  end

  def recipient_object
    Recipient.new(recipient_data).decorate
  end
end
