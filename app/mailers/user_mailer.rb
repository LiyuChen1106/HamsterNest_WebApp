class UserMailer < ApplicationMailer
  
  default from: 'notification@hamsternest.com'
 
  def return_notification_email
    @return_list = params[:return_list]
    
    @return_list.each do |unit|
      @borrower = unit.user_profile
      @email = unit.user_profile.user.email
      @borrow_requests = unit.requests
      @due_date = @borrow_requests.first.return_date
      @url = item_url(:id => @item.id)
      mail(to: @user.email, subject: 'Reminder: items to be returned')
    end
  end
  
  def return_confirmation_notification_email
    @return_list = params[:return_list]
    
    @return_list.each do |unit|
      @borrower = unit.user_profile
      @email = unit.user_profile.user.email
      @borrow_requests = unit.requests
      @due_date = @borrow_requests.first.return_date
      @url = item_url(:id => @item.id)
      mail(to: @user.email, subject: 'Reminder: items to be returned')
    end
  end
  
  def borrow_request_confirmation_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_borrow_request_url(:item_id => @item.id, :id => @borrow_request.id)
    
    mail(to: @lender.email, subject: 'Borrow request on your item')
  end
  
  def borrow_request_approved_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_url(:id => @item.id)
    
    mail(to: @borrower.email, subject: 'Borrow request approved!')
  end
  
  def borrow_request_rejected_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @item_name = @item.item_name
    @url = item_url(:id => @item.id)
    
    mail(to: @borrower.email, subject: 'Borrow request rejected')
  end
  
  def item_delivery_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_url(:id => @item.id)
    
    mail(to: @borrower.email, subject: 'Item is on the way')
  end
  
  def item_delivery_confirmation_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_url(:id => @item.id)
    
    mail(to: @lender.email, subject: 'Item recieved by the borrower')
  end
  
  def item_return_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_url(:id => @item.id)
    
    mail(to: @lender.email, subject: 'Item is on the way back')
  end
  
  def item_return_confirmation_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_url(:id => @item.id)
    
    mail(to: @borrower.email, subject: 'Item recieved by the owner')
  end
end