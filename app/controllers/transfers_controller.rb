# TransfersController
class TransfersController < ApplicationController
  def new
    @transfer = Transfer.new
    @transfer.build_sender
    @transfer.build_recipient
    @transfer.build_payment
  end

  def create
  end
end
