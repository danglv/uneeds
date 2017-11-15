# base controller
class Admin::BaseController < ApplicationController
  before_action :authorization_admin!

  private

  def authorization_admin!
    raise "access denied" unless current_user.has_role? :admin
  end
end
