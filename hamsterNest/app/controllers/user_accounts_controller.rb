class UserAccountsController < ApplicationController
  
  def index
    @user_accounts = UserAccount.all
  end
  
  def show
    @user_account = UserAccount.find(params[:id])
  end
  
  def new
    @user_account = UserAccount.new
  end
  
  def edit
    @user_account = UserAccount.find(params[:id])
  end
  
  def create
    @user_account = UserAccount.new(params.require(:user_account).permit(:username_id, :email, :password))
    
    if @user_account.save
      flash[:notice] = "Signup Sucessfully"
      # render to fill up their user information
      redirect_to new_user_detail_path#:root
    else
      flash[:alert] = "Problem"
      render new
    end
  end
  
  def update
	  @user_account = UserAccount.find(params[:id])
 
  	if @user_account.update(account_params)
    	redirect_to @user_account
  	else
    	render 'edit'
  	end
	end
  
  private
    def account_params
      params.require(:user_account).permit(:username_id, :email, :password)
    end
end
