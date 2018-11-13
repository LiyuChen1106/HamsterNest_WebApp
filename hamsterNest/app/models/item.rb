class Item < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_one :history, dependent: :destroy
  has_many :borrow_requests, dependent: :destroy
end
