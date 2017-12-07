class RecipientsController < ApplicationController
  def index
    @recipients = current_user.recipients.decorate
  end
end
