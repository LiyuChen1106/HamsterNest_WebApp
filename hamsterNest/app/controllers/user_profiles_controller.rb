class UserProfilesController < ApplicationController

  def index
    @user_profiles = UserProfile.all
  end
  
  def show
    @user_profile = UserProfile.find(params[:id])
  end
  
  def new
    @user_profile = UserProfile.new
  end
  
  def edit
    @user_profile = UserProfile.find(params[:id])
  end
  
  def create
    @user_profile = UserProfile.new(profile_params)
    
    if @user_profile.save
      flash[:notice] = "Profile added"
      redirect_to :root
    else
      flash[:alert] = "Problem"
      render new
    end
  end
  
  def update
	  @user_profile = UserProfile.find(params[:id])
 
  	if @user_profile.update(profile_params)
    	redirect_to @user_profile
  	else
    	render 'edit'
  	end
	end
  
  private
    def profile_params
      params.require(:user_profile).permit(:email, :username, :first_name, :last_name, :birthday)
    end
end
