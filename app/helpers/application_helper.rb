module ApplicationHelper
  def admin?
    current_user&.has_role?(:admin)
  end

  def normal_user?
    current_user && !admin?
  end
end
