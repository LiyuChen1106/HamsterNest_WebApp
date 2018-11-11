class BorrowRequest < ApplicationRecord
  belongs_to :item
  belongs_to :user_profile

  validates :request_message, length: {maximum: 40}
end
