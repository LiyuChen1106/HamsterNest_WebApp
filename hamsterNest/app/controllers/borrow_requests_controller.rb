class BorrowRequestsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

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
    @item = Item.find(params[:item_id])
    @owner = @item.user_profile
    @borrower = @borrow_request.user_profile
    @I_am_borrower = false
    if @borrower.id == current_user.id
      @I_am_borrower = true
    end
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
    @start_date = 0
    @end_date = 0
    @max_start = 0
    if @item.status == false
      @item.borrow_requests.each do |request|
        if request.approval
          if (Time.now.to_date < request.return_date.to_date)
            @max_start = (request.return_date.to_date - Time.now.to_date).to_i + 1
          end
          if @max_start > @start_date
            @start_date = @max_start
          end
        end
      end
    end
    @item.borrow_requests.each do |request|
      #flash[:notice] = "someone else has borrowed this item"

      if (@borrower_id == request.user_profile_id && request.return_date.to_date > Time.now.to_date)
        flash[:notice] = "You have already borrowed this item please check your request list"
        redirect_to item_path(@item)
      end
    end
  end

  def edit
    @borrow_request = BorrowRequest.find(params[:id])
  end

  def create
    @item = Item.find(params[:item_id])
    @attr = request_params
    @attr[:user_profile_id] = current_user.id
    @borrow_request = @item.borrow_requests.create(@attr)

    if @borrow_request.save
      flash[:notice] = "Borrow request created."

      UserMailer.with(lender: @item.user_profile.user, borrower: current_user, item: @item, borrow_request: @borrow_request).borrow_request_confirmation_email.deliver_later

      redirect_to root_path
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
    @borrower = @borrow_request.user_profile.user

    #if click Accept || Reject, update approval
    if !params[:approval].nil?
      @borrow_request.update_attribute(:approval, params[:approval])

      if @borrow_request.approval == true
        flash[:notice] = "You have approved this request"
        if @borrow_request.borrow_date.to_date == Time.now.to_date
          @borrow_request.item.update_attribute(:status, false)
        end
        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).borrow_request_approved_email.deliver
      elsif @borrow_request.approval == false
        flash[:notice] = "You have rejected this request"
        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).borrow_request_rejected_email.deliver
      end
    end

    # Update the return status
    if !params[:return_status].nil?
      @borrow_request.update_attribute(:return_status, params[:return_status])

      if @borrow_request.return_status == "1"
        #flash[:notice] = "set return status as returned(1)"
      elsif @borrow_request.return_status == "2"
        #flash[:notice] = "set return status as received (2)"
        @borrow_request.item.update_attribute(:status, true)
        @borrow_request.update_attribute(:actual_return_date, Time.now.to_date)
      end
    end

    if !params[:read_status].nil? && params[:read_status] == "true"
      @borrow_request.update(:read_status => params[:read_status])
      flash[:notice] = "update read_status"
    end

    # return to item page
    if @borrow_request.return_status == 1
      redirect_to lend_rating_path(:id => @borrow_request.item.user_profile.id)
    else
      redirect_to item_borrow_request_path(:item_id => @item.id, :id => @borrow_request.id)
    end
    #    if @borrow_request.update(request_params)
    #      flash[:notice] = "Borrow request updated."
    #      redirect_to item_borrow_request(:item_id => @item.id, :id => @borrow_request.id)
    #    else
    #      flash[:alert] = @borrow_request.errors.full_messages
    #      render "edit"
    #    end

  end

  def destroy
    #@item = Item.find(params[:item_id])
    #@borrow_request = @item.borrow_requests.find(params[:id])
    @borrow_request = BorrowRequest.find(params[:id])
    @borrow_request.destroy
    flash[:notice] = "Borrow request deleted."
    redirect_to root_path
  end

  private

  def request_params
    params.require(:borrow_request).permit(:approval, :borrow_date, :return_date, :quantity, :request_message)
  end
end
