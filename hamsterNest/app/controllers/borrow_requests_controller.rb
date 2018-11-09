class BorrowRequestsController < ApplicationController
  def index
    # test: show all
    @borrow_requests = BorrowRequest.all
    @item_id = params[:item_id]
    @item = Item.find(@item_id)
    @item_name = @item.item_name
    @borrow_request = @item.borrow_request
  end

  def show
    @borrow_request = BorrowRequest.find(params[:id])
    @item = Item.find(params[:item_id])
    @borrower = @borrow_request.user_profile
    # test: show all requests
    #@item_id = params[:item_id]
    #@item = Item.find(@item_id)
    #@item_name = @item.item_name
    #@borrow_request = @item.borrow_request

    ##@user_profile = UserProfile.find(@borrow_request.)
  end

  def new
    @item_id = params[:item_id]
    @item = Item.find(@item_id)
    @owner = @item.user_profile
    @user_name = @owner.username
    @item_name = @item.item_name
    @owner = @item.user_profile
    @owner_name = @owner.username
    @borrower_id = current_user.user_profile_id
  end

  def edit
    @borrow_request = BorrowRequest.find(params[:id])
  end

  def create
    @item = Item.find(params[:item_id])
    @attr = request_params
    @attr[:user_profile_id] = current_user.id
    @borrow_request = @item.create_borrow_request(@attr)

    if @borrow_request.save
      flash[:notice] = "Borrow request created."
      redirect_to item_path(@item)
    else
      flash[:notice] = "Error occured! "
      flash[:alert] = @borrow_request.errors.full_messages
      redirect_to item_path(@item)
    end
  end

  def update
    @borrow_request = BorrowRequest.find(params[:id])
    if @borrow_request.update(request_params)
      flash[:notice] = "Borrow request updated."
      redirect_to @borrow_request
    else
      flash[:alert] = @borrow_request.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @borrow_request = BorrowRequest.find(params[:id])
    @borrow_request.destroy

    redirect_to borrow_requests_path
  end

  private

  def request_params
    params.require(:borrow_request).permit(:approval, :borrow_date, :return_date, :request_message)
  end
end
