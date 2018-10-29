class BorrowRequest < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :user_profile, dependent: :destroy

  validates :request_message length: {maximum: 40}
end
