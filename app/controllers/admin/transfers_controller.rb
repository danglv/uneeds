# transfer
class Admin::TransfersController < Admin::BaseController
  def index
    @transfers = Transfer.all
  end
end
