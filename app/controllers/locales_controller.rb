# change locales
class LocalesController < ApplicationController
  def change
    I18n.default_locale = params[:locale]
    I18n.locale = params[:locale]
    render json: { message: "success" }
  end
end
