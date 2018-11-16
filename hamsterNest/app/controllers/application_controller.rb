class ApplicationController < ActionController::Base
  before_action :set_search

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      new_user_profile_path
    else
      root_path
    end
  end


  def after_sign_out_path_for(resource)
      root_path
  end


  def set_search
    @search = Item.ransack(params[:q])
  end


end
