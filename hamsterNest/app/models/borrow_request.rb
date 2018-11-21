class BorrowRequest < ApplicationRecord
  belongs_to :item
  belongs_to :user_profile

  validates :request_message, length: {maximum: 40}
  
#  after_update :send_approval_email
#  
#  def send_approval_email
#    
#    if approval_changed?
#      @item = self.item
#      @borrower = self.user_profile.user
#      
#      if self.approval
#        flash[:notice] = "You have borrowed this item"
#        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).borrow_request_approved_email.deliver
#      else
#        flash[:notice] = "You have borrowed this item"
#        UserMailer.with(lender: current_user, borrower: @borrower, item: @item, borrow_request: self).borrow_request_rejected_email.deliver
#      end
#    end
#  end
  
end
