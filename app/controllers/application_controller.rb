class ApplicationController < ActionController::Base
  if proc { |c| c.request.format == "application/json" }
    protect_from_forgery with: :null_session
  else
    protect_from_forgery with: :exception
  end

  before_action :authenticate_user!

  protected

  def authenticate_user!(options={})
    if user_signed_in?
      super(options)
    else
      return if devise_controller?
      redirect_to new_user_session_path
    end
  end
end
