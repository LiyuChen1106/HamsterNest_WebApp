# todo: add current user as the
class ItemsController < ApplicationController
  respond_to :json, :js, :html

  def index
    @search = Item.ransack(params[:q])
    @search_items = @search.result(distinct: true)
    @user_profile = UserProfile.find(params[:user_profile_id])
    #@items = @user_profile.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @user_profile = UserProfile.find(params[:id])
    @item = @user_profile.items.create(request_params)

    if @item.save
      flash[:notice] = "Item created."
      redirect_to user_profile_path(@user_profile)
    else
      flash[:alert] = @item.errors.full_messages
      render "new"
    end
  end

  def new
    @user_profile = UserProfile.find(params[:user_profile_id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @user_profile = UserProfile.find(params[:user_profile_id])
    @item = @user_profile.items.create(item_params)
    if @item.save
      redirect_to user_profile_item_path(:id => @item.id)
    else
      render new_user_profile_item_path
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end
end

private

def item_params
  params.require(:item).permit(:item_name, :category_id, :status, :search_text)
end
