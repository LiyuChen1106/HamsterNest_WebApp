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
    lend_rating = 1
    @user_profile = UserProfile.new(profile_params)
    #    @user_profile.auto_fill_username_and_account(current_user)

    if @user_profile.save
      flash[:notice] = "Profile added"
      redirect_to :root
    else
      @s = ""
      for m in @user_profile.errors.full_messages
        @s = @s + m + ".   "
      end
      flash[:alert] = @s

      render "new"
    end
  end

  def update
    @id = params[:id]

    if (@id.to_i == current_user.id)
      @user_profile = UserProfile.find(params[:id])
      @registerInProgress = @user_profile.birthday.nil?
      @updateResult = @user_profile.update(profile_params)

      if @updateResult && !@registerInProgress
        @user_profile.errors.clear
        flash[:notice] = "Profile updated"
        redirect_to @user_profile
      elsif @updateResult && @registerInProgress
        @user_profile.errors.clear
        flash[:notice] = "Profile added"
        redirect_to :root
      else
        flash[:error] = @user_profile.errors.full_messages.map(&:inspect).join()
        render "edit"
      end
    else
      @lrating = params.require(:user_profile)
      @lrating = @lrating[:lend_rating].to_i
      if (@lrating!=0)
        puts "22222222"
        @user_profile = UserProfile.find(params[:id])
        @l_rating = @user_profile.lend_rating
        @l_people = @user_profile.lpeople
        @l_rating = @l_rating * @l_people
        @l_people = @l_people + 1
        @rating = params.require(:user_profile)
        @rating = @rating[:lend_rating].to_i
        @l_rating = (@l_rating + @rating) / @l_people
        if @user_profile.update_attribute(:lend_rating, @l_rating) && @user_profile.update_attribute(:lpeople, @l_people)
          redirect_to :root
        else
          render "lend_rating"
        end
      else
        puts "333333333"
        @user_profile = UserProfile.find(params[:id])
        @b_rating = @user_profile.borrow_rating
        @b_people = @user_profile.bpeople
        @b_rating = @b_rating * @b_people
        @b_people = @b_people + 1
        @rating = params.require(:user_profile)
        @rating = @rating[:borrow_rating].to_i
        @b_rating = (@b_rating + @rating) / @b_people
        if @user_profile.update_attribute(:borrow_rating, @b_rating) && @user_profile.update_attribute(:bpeople, @b_people)
          redirect_to :root
        else
          render "borrow_rating"
        end
      end
    end
  end

  #items that I lent to others
  def lend_to_others
    @user_profile = UserProfile.find(current_user.id)
    @items = @user_profile.items
  end

  #items that I borrowed from others
  def borrow_from_others
    @user_profile = UserProfile.find(current_user.id)
    @user_name = @user_profile.username
    @borrow_requests = @user_profile.borrow_requests
  end

  def comment_history
    @user_profile = UserProfile.find(current_user.id)

  end

  #rating other people
  def lend_rating
    @user_profile = UserProfile.find(params[:id])
  end

  def borrow_rating
    @user_profile = UserProfile.find(params[:id])
  end
  private

  def profile_params
    params.require(:user_profile).permit(:account_id, :username, :first_name, :last_name, :birthday, :avatar, address: [:street_address, :city, :province_id, :postal_code])
  end

  def rate_params
    params.require(:user_profile).permit(:lend_rating, :lpeople)
  end
end
