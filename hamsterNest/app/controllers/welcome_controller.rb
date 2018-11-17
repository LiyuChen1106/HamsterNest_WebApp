class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @current_user = User.find(current_user.id)
      @current_user_profile = @current_user.user_profile
      @user_name = @current_user_profile.username
    end
  end
  def about
  end
end
