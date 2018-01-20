module Admin::TransfersHelper
  def user_options
    User.without_role(:admin).pluck(:id, :email).map do |user_id, email|
      [email, user_id]
    end
  end
end
