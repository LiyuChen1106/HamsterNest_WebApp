# todo: add current user as the
class ItemsController < ApplicationController
  respond_to :json, :js, :html

  def index
    @unlogin = params[:user_profile_id].nil?
    @notsearching = params[:q].nil?
    @search = Item.ransack(params[:q])
    #TODO: where should we put it
    #check and update status for all the items..
    @all_items = Item.all
    @all_items.each do |status_item|
      status_item.borrow_requests.each do |request|
        if request.approval == true
          #check if any accepted items lend out today
          if (request.return_status ==0 && !request.actual_borrow_date.nil?)|| request.return_status ==3 || request.return_status ==4
            request.item.update_attribute(:status, false)
          else
            request.item.update_attribute(:status, true)
          end

        end
      end
    end
    #TODO

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
      flash[:alert] = @item.errors.full_messages
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
      flash[:alert] = @item.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to user_profile_items_path
  end

  def load_markers(search_items)
   @load_markers = Gmaps4rails.build_markers(search_items.all) do |item, marker|

    @item = item
    @user_profile = @item.user_profile

    marker.lat @user_profile.latitude
    marker.lng @user_profile.longitude

    @status = @item.status
    @category = @item.category_id

    if @status == true
      @status = "Available"
    else
      @status = "Currently unavailable"
    end

    marker.infowindow render_to_string(:partial => "/gmap/template", :locals => {:item => @item, :status => @status})
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :category_id, :quantity, :status,
                                 :search_text, :image, :description)
  end

end
