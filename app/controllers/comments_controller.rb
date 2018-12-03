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

  end

  def edit
    @item = Item.find(params[:item_id])
    @comment=Comment.find(params[:id])
  end

  def update
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:id])
    @attr = comment_params
    @comment_message=@attr[:comment_message]

    if @comment.update_attribute(:comment_message, @comment_message)
      flash[:notice] = "success change the comment."
      redirect_to root_path
    else
      flash[:notice] = "Error occured! "
      flash[:alert] = @comment.errors.full_messages
      render "edit"
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @user_profile = @item.user_profile
    @l_rating = @user_profile.lend_rating
    @l_people = @user_profile.lpeople
    @l_rating = @l_rating * @l_people
    @l_people = @l_people + 1
    @rating = params.require(:comment)
    @rating = @rating[:lend_rating].to_i
    @l_rating = (@l_rating + @rating) / @l_people

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

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to root_path
  end
  private

  def comment_params
    params.require(:comment).permit(:comment_message)
  end
end
