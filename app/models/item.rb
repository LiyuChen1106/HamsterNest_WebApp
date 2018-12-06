class Item < ApplicationRecord
  # relations
  belongs_to :user_profile
  belongs_to :category
  has_many :borrow_requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  # validations
  validates :description, length: {maximum: 200}
  validates :item_name, presence: true,
                        length: {maximum: 50}
  validate :correct_image_type
  #no quantity right now
  #validates :quantity, numericality: {only_integer: true, greater_than: 0}

  # actions
  before_create :set_default_image
  #after_create :set_left_quantity

  private

  #def set_left_quantity
  #  self.left_quantity = self.quantity
  #end

  def correct_image_type
      if self.image.attached? && !self.image.content_type.start_with?('image/')
        self.errors.add(:self, 'Must be an image')
      end
    end

  def set_default_image
    if !self.image.attached?
      self.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_item.jpg")), filename: "default_item.jpg", content_type: "image/jpg")
    end
  end
end
