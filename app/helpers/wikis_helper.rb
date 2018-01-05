module WikisHelper
  def user_has_private_access?
    current_user && (current_user.premium? || current_user.admin?)
  end          
end