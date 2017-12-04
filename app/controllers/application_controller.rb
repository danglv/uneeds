class ApplicationController < ActionController::Base
  if proc { |c| c.request.format == "application/json" }
    protect_from_forgery with: :null_session
  else
    protect_from_forgery with: :exception
  end

  before_action :set_locale, :authenticate_user!

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def authenticate_user!(options={})
    if user_signed_in?
      super(options)
    else
      return if devise_controller?
      redirect_to new_user_session_path
    end
  end
end
