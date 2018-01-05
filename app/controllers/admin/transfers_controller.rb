# transfer
class Admin::TransfersController < Admin::BaseController
  def index
    @transfers_below = Transfer.below
    @transfers_above = Transfer.above
  end
end
