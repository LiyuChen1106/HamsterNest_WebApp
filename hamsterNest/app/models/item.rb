class Item < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_one :history, dependent: :destroy
  has_many :borrow_requests, dependent: :destroy

  has_attached_file :image
  # Validation for avatar
  # Validate content type
  validates_attachment_content_type :image, content_type: /\Aimage/
  # Validate filename
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

  after_create :set_left_quantity

  private

  def set_left_quantity
    self.left_quantity = self.quantity
  end
end
