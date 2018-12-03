class BorrowRequestsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    # test: show all
    @item_id = params[:item_id]
    @item = Item.find(@item_id)
    @borrow_requests = @item.borrow_requests

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
    @start_date = Date.today
    @end_date = 0
    @max_start = Date.today
    if @item.status == false
      @item.borrow_requests.each do |request|
        if request.approval && request.return_status != 2
          if Date.today <= request.return_date && Date.today >= request.borrow_date
            @max_start = request.return_date
          end
          if @max_start > @start_date
            @start_date = @max_start + 1
          end
        end
      end
    end
    @item.borrow_requests.each do |request|
      #flash[:notice] = "someone else has borrowed this item"

      if (@borrower_id == request.user_profile_id && request.return_date > Date.today)
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
    @owner = @item.user_profile
    @attr = request_params
    @attr[:user_profile_id] = current_user.id
    @borrow_date = @attr[:return_date].to_date
    @return_date = @attr[:borrow_date].to_date
    @item.borrow_requests.each do |request|
      if !request.approval.nil?
        if request.approval && !@borrow_date.nil? && !@return_date.nil? && request.return_status!=2
          if request.borrow_date <= @borrow_date && request.return_date >= @borrow_date
            flash[:notice] = "please check borrow period"
            @attr[:return_date] = "1995-01-01"
          elsif request.borrow_date <= @return_date && request.return_date >= @return_date
            flash[:notice] = "please check borrow period"
            @attr[:borrow_date] = "1995-01-01"
          end
        end
      end
    end
    if @borrow_date.nil? || @borrow_date.nil?
      @attr[:return_date] = "1995-01-01"
      @attr[:borrow_date] = "1995-01-01"
    end
    @borrow_request = @item.borrow_requests.create(@attr)

    if @borrow_request.save
      flash[:notice] = "An email has been sent to the owner. Please wait for confirmation."

      UserMailer.with(lender: @item.user_profile.user, borrower: current_user, item: @item, borrow_request: @borrow_request).borrow_request_confirmation_email.deliver

      redirect_to root_path
    else
      @s = ""
      for m in @borrow_request.errors.full_messages
        @s = @s + m + ".   "
      end
      flash[:alert] = @s
      #redirect_to item_path(@item)
      redirect_to item_path(:id => @item.id)
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
        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).borrow_request_approved_email.deliver
      elsif @borrow_request.approval == false
        flash[:notice] = "You have rejected this request"
        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).borrow_request_rejected_email.deliver
      end
    end

    # Update the return status
    if !params[:return_status].nil?
      @borrow_request.update_attribute(:return_status, params[:return_status])

      if @borrow_request.return_status == 1 #borrower return
        flash[:notice] = "set return status as borrower returned(1)"
        #send email
        UserMailer.with(lender: @item.user_profile.user, borrower: current_user, item: @item, borrow_request: @borrow_request).item_return_email.deliver
      elsif @borrow_request.return_status == 2 #lender received
        flash[:notice] = "set return status as lender received (2)"
        @borrow_request.item.status = true
        @borrow_request.update_attribute(:actual_return_date, Date.today)
        #send email
        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).item_return_confirmation_email.deliver
      elsif @borrow_request.return_status == 3 #lender sended
        @borrow_request.item.status = false
        #send email
        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).item_delivery_email.deliver
      elsif @borrow_request.return_status == 4 #borrow received
        @borrow_request.update_attribute(:actual_borrow_date, Date.today)
        #send email
        UserMailer.with(lender: @item.user_profile.user, borrower: current_user, item: @item, borrow_request: @borrow_request).item_delivery_confirmation_email.deliver
      end
    end

    if !params[:read_status].nil? && params[:read_status] == "true"
      @borrow_request.update_attribute(:read_status, params[:read_status])
      flash[:notice] = "update read_status"
    end

    if !params[:borrower_read_status].nil?
      @borrow_request.update_attribute(:borrower_read_status, params[:borrower_read_status])
      flash[:notice] = "update borrow_read_status"
    end

    # return to item page
    if  @borrow_request.user_profile_id == current_user.id && !params[:return_status].nil?
      if params[:return_status]== "1"
        redirect_to new_item_comment_path(:item_id=>@item.id, :tryid => @borrow_request.item.user_profile.id)

      else
        redirect_to item_borrow_request_path(:item_id => @item.id, :id => @borrow_request.id)
      end
    elsif @borrow_request.user_profile_id != current_user.id && !params[:return_status].nil?
      if params[:return_status]=="2"
        redirect_to borrow_rating_path(:id=>@borrow_request.user_profile_id)
      else
        redirect_to item_borrow_request_path(:item_id => @item.id, :id => @borrow_request.id)
      end
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
