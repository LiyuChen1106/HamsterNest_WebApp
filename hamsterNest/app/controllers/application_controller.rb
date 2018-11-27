class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_user_location!, if: :storable_location?
  before_action :set_search
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      edit_user_profile_path(User.find(current_user.id).user_profile.id)
    else
      stored_location_for(resource) || root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def set_search
    @search = Item.ransack(params[:q])
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
