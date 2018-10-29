class Item < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_one :history, dependent: :destroy
  has_one :borrow_request, dependent: :destroy
end
