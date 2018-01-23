class Admin::TransferParams
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def to_create_params
    assign_user_id_param
    assign_payment_params
    permitted_params
  end

  private

  def permitted_params
    @permitted_params ||= params.require(:transfer).permit(
      Transfer::ADMIN_CREATE_ATTRIBUTES
    ).merge(kind: :above)
  end

  def assign_user_id_param
    permitted_params[:sender_attributes][:user_id] = permitted_params[:user_id]
    permitted_params[:recipient_attributes][:user_id] = permitted_params[
      :user_id
    ]
  end

  def assign_payment_params
    assign_fee_param
    assign_transfer_amount_param
  end

  def assign_fee_param
    permitted_params[:payment_attributes][:fee] ||=
      Admin::Transfers::CalculateFeeService.new(amount, sender_currency).call
                                           .to_f
  end

  def amount
    permitted_params[:payment_attributes][:amount].to_f
  end

  def sender_currency
    permitted_params[:sender_attributes][:currency]
  end

  def guaranteed_rate
    permitted_params[:payment_attributes][:guaranteed_rate].to_f
  end

  def assign_transfer_amount_param
    permitted_params[:payment_attributes][:transfer_amount] ||=
      (amount - fee) * guaranteed_rate
  end
end
