module SessionsHelper
  def registerInProgress
    if current_user == nil
      false
    else
    User.find(current_user.id).user_profile.username == ""
    end
  end
end
