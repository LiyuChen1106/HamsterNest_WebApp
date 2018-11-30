class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_user_location!, if: :storable_location?
  before_action :set_search
  before_action :authenticate_user!
  before_action :new_message

  # checking if there are new message
  def new_message
    @new_message=false
    @message_num= 0
    @new_requests=Array.new
    if !current_user.nil?
      @current_user = User.find(current_user.id)
      @current_user_profile = @current_user.user_profile
      @user_name = @current_user_profile.username
      # checking if there are importance request message?
      @current_user_profile.items.each do |it|
        it.borrow_requests.each do |req|
          if !req.read_status
            @new_message=true
            @message_num=@message_num+1
            @new_requests<<req.id
            #flash[:notice] = "new requsets incoming"
          elsif req.return_status == 3 && req.borrow_date <= Date.today
            @new_message=true
            @message_num=@message_num+1
            @new_requests<<req.id
            #flash[:notice] = "have items need to be deliverd now"
          elsif req.return_status == 1
            @new_message=true
            @message_num=@message_num+1
            @new_requests<<req.id
            #flash[:notce] = "You item returned"
          end
        end
      end
      @current_user_profile.borrow_requests.each do |req|
        if req.approval && req.return_status == 3
          @new_message=true
          @message_num=@message_num+1
          @new_requests<<req.id
          #flash[:notice] = "deliverd check received?"
        elsif req.return_status == 4 && req.return_date <= Date.today
          @new_message=true
          @message_num=@message_num+1
          @new_requests<<req.id
          #flash[:notice] = "Return!!!"
        end
      end

    end
    
  end


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
