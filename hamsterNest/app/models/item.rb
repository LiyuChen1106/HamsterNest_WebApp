class Item < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_one :history, dependent: :destroy
  has_one :borrow_request, dependent: :destroy

  after_create :set_left_quantity

  private

  def set_left_quantity
    self.left_quantity = self.quantity
  end
end
