class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index

    if user_signed_in?
      @current_user = User.find(current_user.id)
      @current_user_profile = @current_user.user_profile
      @user_name = @current_user_profile.username
      # checking if there are importance request message?
      @current_user_profile.items.each do |item|
        item.borrow_requests.each do |request|
          if !request.read_status
            #flash[:notice] = "new requsets incoming"
          elsif request.return_status == 3 && request.borrow_date <= Date.today
            #flash[:notice] = "have items need to be deliverd now"
          elsif request.return_status == 1
            #flash[:notce] = "You item returned"
          end
        end
      end
      @current_user_profile.borrow_requests.each do |request|
        if request.approval && request.return_status == 3
          #flash[:notice] = "deliverd check received?"
        elsif request.return_status == 4 && request.return_date <= Date.today
          #flash[:notice] = "Return!!!"
        end
      end

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
