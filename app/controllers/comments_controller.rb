class CommentsController < ApplicationController
  before_action :authenticate_user!
  #def show
  #want to show at user_profile or itme
  #end
  def new
    @tryid = params[:tryid]
    @item_id = params[:item_id]
    @item = Item.find(@item_id)
    @owner = @item.user_profile
    @user_id = current_user.id
    #also need to check history
    @item.comments.each do |com|
      if @user_id == com.user_profile_id
        flash[:notice] = "You have commented this item"
        redirect_to root_path
      end
    end
  end

  def create

    @user_profile = item.user_profile
    @l_rating = @user_profile.lend_rating
    @l_people = @user_profile.lpeople
    @l_rating = @l_rating * @l_people
    @l_people = @l_people + 1
    @rating = params.require(:comment)
    @rating = @rating[:lend_rating].to_i
    @l_rating = (@l_rating + @rating) / @l_people

    @item = I.tem.find(params[:item_id])
    @attr = comment_params
    @attr[:user_profile_id] = current_user.id
    @attr[:comment_date]=Time.now
    @comment = @item.comments.create(@attr)

    if @comment.save && @user_profile.update_attribute(:lend_rating, @l_rating) && @user_profile.update_attribute(:lpeople, @l_people)
      flash[:notice] = "success comment and rating."
      redirect_to root_path
    else
      flash[:notice] = "Error occured! "
      flash[:alert] = @comment.errors.full_messages
      render "new"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_message)
  end
end
