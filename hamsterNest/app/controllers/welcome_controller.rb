class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    if user_signed_in?
      @current_user = User.find(current_user.id)
      @current_user_profile = @current_user.user_profile
      @user_name = @current_user_profile.username

      if current_user.superadmin_role?
        redirect_to rails_admin_path
      elsif current_user.supervisor_role?
        redirect_to "/admin/user"
      end
    end
  end

  def about
  end
end
