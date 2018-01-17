# transfer
class Admin::TransfersController < Admin::BaseController
  def index
    @transfers_below = Transfer.below.decorate
    @transfers_above = Transfer.above.decorate
  end
end
