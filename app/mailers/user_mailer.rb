class UserMailer < ApplicationMailer
  
  default from: 'notification@hamsternest.com'
 
  def return_reminder_the_day_before_email
    @return_list = params[:return_list]
    
    @return_list.each do |borrower_profile, requests|
      @email = borrower_profile.user.email
      @borrower = borrower_profile
      @item_infos = []
      requests.each do |request|
        @item = request.item
        @itemname = @item.item_name
        @return_date = request.return_date
        @url = item_borrow_request_url(:item_id => @item.id, :id => request.id)
        @item_info = {:itemname => @itemname, :url => @url, :returndate => @return_date}
        
        @item_infos.push(@item_info)
      end
      puts @item_infos
      mail(to: @email, subject: 'Reminder: item(s) to be returned')
    end
  end
  
  def return_confirmation_reminder_the_day_before_email
    @return_list = params[:return_list]
    
    @return_list.each do |lender_profile, requests|
      @email = lender_profile.user.email
      @lender = lender_profile
      @item_infos = []
      requests.each do |request|
        @item = request.item
        @itemname = @item.item_name
        @return_date = request.return_date
        @url = item_borrow_request_url(:item_id => @item.id, :id => request.id)
        @item_info = {:itemname => @itemname, :url => @url, :returndate => @return_date}
        
        @item_infos.push(@item_info)
      end
      puts @item_infos
      mail(to: @email, subject: 'Reminder: check if item(s) have been returned')
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
    @url = item_borrow_request_url(:item_id => @item.id, :id => @borrow_request.id)
    
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
    @url = item_borrow_request_url(:item_id => @item.id, :id => @borrow_request.id)
    
    mail(to: @borrower.email, subject: 'Item is on the way')
  end
  
  def item_delivery_confirmation_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_borrow_request_url(:item_id => @item.id, :id => @borrow_request.id)
    
    mail(to: @lender.email, subject: 'Item recieved by the borrower')
  end
  
  def item_return_email
    @lender = params[:lender]
    @borrower = params[:borrower]
    @item = params[:item]
    @borrow_request = params[:borrow_request]
    @url = item_borrow_request_url(:item_id => @item.id, :id => @borrow_request.id)
    
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
