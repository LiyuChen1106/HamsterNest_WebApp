class BorrowRequestsController < ApplicationController
  def index
    # test: show all
    @borrow_requests = BorrowRequest.all
    @item_id = params[:item_id]
    @item = Item.find(@item_id)
    @item_name = @item.item_name
    @borrow_request = @item.borrow_requests
  end

  def show
    @borrow_request = BorrowRequest.find(params[:id])
    @borrow_request.update(:read_status => params[:read_status])
    @item = Item.find(params[:item_id])
    @borrower = @borrow_request.user_profile
<<<<<<< HEAD

=======
    @I_am_borrower=false
    if @borrower.id == current_user.id
      @I_am_borrower=true
    end
>>>>>>> 2b015c868906c2136abf752cc753ef07964ba4d4
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
    @borrower_id = current_user.id
<<<<<<< HEAD
    if !(@item.borrow_request.nil?)
      flash[:notice] = "someone else has borrowed this item"
      if @borrower_id == @item.borrow_request.user_profile_id
        flash[:notice] = "You have borrowed this item please check your request list"
        redirect_to item_path(@item)
=======
    @item.borrow_requests.each do |request|
      #flash[:notice] = "someone else has borrowed this item"
      if @borrower_id == request.user_profile_id
      flash[:notice] = "You have borrowed this item please check your request list"
      redirect_to item_path(@item)
>>>>>>> 2b015c868906c2136abf752cc753ef07964ba4d4
      end
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @borrow_request = @item.borrow_requests.find(params[:id])
    #@borrow_request = BorrowRequest.find(params[:id])
  end

  def create
    @item = Item.find(params[:item_id])
    @attr = request_params
    @attr[:user_profile_id] = current_user.id
    @borrow_request = @item.borrow_requests.create(@attr)

    if @borrow_request.save
      flash[:notice] = "Borrow request created."
      redirect_to item_path(@item)
    else
      flash[:notice] = "Error occured! "
      flash[:alert] = @borrow_request.errors.full_messages
      #redirect_to item_path(@item)
      render "new"
    end
  end

  def update
    @item = Item.find(params[:item_id])
    @borrow_request = @item.borrow_requests.find(params[:id])
    #@borrow_request = BorrowRequest.find(params[:id])
    if @borrow_request.update(request_params)
      flash[:notice] = "Borrow request updated."
      redirect_to item_borrow_request(:item_id=>@item.id, :id=>@borrow_request.id)
    else
      flash[:alert] = @borrow_request.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @borrow_request = @item.borrow_requests.find(params[:id])
    @borrow_request.destroy
    flash[:notice] = "Borrow request deleted."
    redirect_to root_path
  end

  private

  def request_params
    params.require(:borrow_request).permit(:approval, :borrow_date, :return_date, :quantity, :request_message)
  end
end
