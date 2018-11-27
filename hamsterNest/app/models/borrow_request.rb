class BorrowRequest < ApplicationRecord
  belongs_to :item
  belongs_to :user_profile

  validates :request_message, length: {maximum: 40}
  validate :borrow_date_cannot_in_past
  validate :return_date_cannot_less_than_borrow_date


  def borrow_date_cannot_in_past
    if borrow_date.present? && borrow_date<Date.today
      errors.add(:borrow_date, "can't be in the past")
    end
  end

  def return_date_cannot_less_than_borrow_date
    if return_date.present? && return_date< borrow_date
      errors.add(:return_date, "can't be in less than borrow date")
    end
  end
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
