class CommentsController < ApplicationController
  before_action :authenticate_user
  #def show
  #want to show at user_profile or itme
  #end
  def new
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
    @item = Item.find(params[:item_id])
    @attr = comment_params
    @attr[:user_profile_id] = current_user.id
    @comment = @item.comments.create(@attr)

    if @comment.save
      flash[:notice] = "comment created."
      redirect_to root_path
    else
      flash[:notice] = "Error occured! "
      flash[:alert] = @comment.errors.full_messages
      render "new"
    end
  end

  private

  def comment_params
    params.require(:user_profile).permit(:comment_message)
  end
end
