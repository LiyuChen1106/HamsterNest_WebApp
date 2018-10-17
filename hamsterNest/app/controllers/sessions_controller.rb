class SessionsController < ApplicationController
  
  protected
    def after_sign_in_path_for(resource)
      if current_user.sign_in_count == 1
        new_user_profile_path
      else
        root_path
      end
    end
end
