class BorrowRequest < ApplicationRecord
  belongs_to :item
  belongs_to :user_profile
end
