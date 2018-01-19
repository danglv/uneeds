# transfer
class Admin::TransfersController < Admin::BaseController
  def index
    @transfers = Transfer.order(created_at: :desc).decorate
  end
end
