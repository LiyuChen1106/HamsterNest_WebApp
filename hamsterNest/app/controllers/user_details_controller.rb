class UserDetailsController < ApplicationController

  def index
    @user_details = UserDetail.all
  end
  
  def show
    @user_detail = UserDetail.find(params[:id])
  end
  
  def new
    @user_detail = UserDetail.new
  end
  
  def edit
    @user_detail = UserDetail.find(params[:id])
  end
  
  def create
    @user_detail = UserDetail.new(profile_params)
    
    if @user_detail.save
      flash[:notice] = "Profile added"
      redirect_to :root
    else
      flash[:alert] = "Problem"
      render new
    end
  end
  
  def update
	  @user_detail = UserDetail.find(params[:id])
 
  	if @user_detail.update(profile_params)
    	redirect_to @user_detail
  	else
    	render 'edit'
  	end
	end
  
  private
    def profile_params
      params.require(:user_detail).permit(:username, :first_name, :last_name, :birthday)
    end
end
