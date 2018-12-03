# todo: add current user as the
class ItemsController < ApplicationController
  respond_to :json, :js, :html

  def index
    @unlogin = params[:user_profile_id].nil?
    @notsearching = params[:q].nil?
    @search = Item.ransack(params[:q])

    if !@notsearching
      @search_items = @search.result(distinct: true)
      @search_words = params[:q][:item_name_or_description_cont]
    elsif !@unlogin
      @user_profile = UserProfile.find(params[:user_profile_id])
      @search_items = @user_profile.items
      @search_words = ""
    else
      @search_items = Item.all
      @search_words = ""
    end

    @markers = load_markers(@search_items)
    @current_latlon = {:lat => current_user.user_profile.latitude, :lng => current_user.user_profile.longitude}
  end

  def show
    @unlogin = params[:user_profile_id].nil?

    @item = Item.find(params[:id])
    #  @borrow_request = @item.borrow_request
    @borrow_requests = @item.borrow_requests
    @owner = UserProfile.find(@item.user_profile.id)
  end

  def create
    @user_profile = UserProfile.find(params[:user_profile_id])
    @item = @user_profile.items.create(item_params)

    if @item.save
      redirect_to user_profile_items_path(@user_profile)
      flash[:notice] = "Item created."
    else
      @s = ""
      for m in @item.errors.full_messages
        @s = @s + m + ".   "
      end
      flash[:alert] = @s
      render "new"
    end
  end

  def new
    @user_profile = UserProfile.find(params[:user_profile_id])
    @item = Item.new
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
      flash[:notice] = "Item updated."
    else
      @s = ""
      for m in @item.errors.full_messages
        @s = @s + m + ".   "
      end
      flash[:alert] = @s
      render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to user_profile_items_path
  end

  def load_markers(search_items)
    
    @item_infos = Hash.new
    search_items.each do |item|
      @profile = item.user_profile
      latlon = {:lat => @profile.latitude, :lon => @profile.longitude}
      
      if !@item_infos[latlon].nil?
        @item_infos[latlon].push(item)
      else
        @item_infos[latlon] = [item]
      end
    end
    
    @infos_array = []
    @item_infos.each do |latlon, items|
      @infos_array.push({:latlon => latlon, :items => items})
    end
    
    @load_markers = 
    Gmaps4rails.build_markers(@infos_array) do |info, marker|
      @items = info[:items]
      @latlon = info[:latlon]

      marker.lat @latlon[:lat]
      marker.lng @latlon[:lon]

      marker.infowindow render_to_string(:partial => "/items/infowindow_template", :locals => {:items => @items})
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category_id, :quantity, :status,
                                 :search_text, :image, :description)
  end
end
