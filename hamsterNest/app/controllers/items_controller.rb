# todo: add current user as the
class ItemsController < ApplicationController
  respond_to :json, :js, :html

  def index
    @unlogin = params[:user_profile_id].nil?
    @notsearching = params[:q].nil?
    @search = Item.ransack(params[:q])
    if !@notsearching
      @search_items = @search.result(distinct: true)
    elsif !@unlogin
      @user_profile = UserProfile.find(params[:user_profile_id])
      @search_items = @user_profile.items
    else
      @search_items = Item.all
    end
  end

  def show
    @unlogin = params[:user_profile_id].nil?

    @item = Item.find(params[:id])
    #  @borrow_request = @item.borrow_request
    @borrow_requests = @item.borrow_requests
  end

  def create
    @user_profile = UserProfile.find(params[:user_profile_id])
    @item = @user_profile.items.create(item_params)

    if @item.save
      flash[:notice] = "Item created."
      redirect_to user_profile_items_path(@user_profile)
    else
      flash[:alert] = @item.errors.full_messages
      render "new"
    end
  end

  def new
    @user_profile = UserProfile.find(params[:user_profile_id])
  end

  def edit
    @user_profile = UserProfile.find(params[:user_profile_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @user_profile = @item.user_profile
    if @item.update(item_params)
      redirect_to user_profile_item_path(:user_profile_id => @user_profile.id)
    else
      render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to user_profile_items_path
  end
end

private

def item_params
  params.require(:item).permit(:item_name, :category_id, :quantity, :status, :search_text, :image)
end
