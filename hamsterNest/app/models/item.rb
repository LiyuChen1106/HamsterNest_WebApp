class Item < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_one :history, dependent: :destroy
  has_many :borrow_requests, dependent: :destroy

  has_one_attached :image
  # Validation for image
  # Validate content type
  # validates_attachment_content_type :image, content_type: /\Aimage/
  # # Validate filename
  # validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]
  before_create :set_default_image
  after_create :set_left_quantity

  private

  def set_left_quantity
    self.left_quantity = self.quantity
  end

  def set_default_image
     if !self.image.attached?
         self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_item.jpg')), filename: 'default_item.jpg', content_type: 'image/jpg')
     end
  end
end
