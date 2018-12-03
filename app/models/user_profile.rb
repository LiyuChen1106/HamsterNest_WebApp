class UserProfile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items, dependent: :destroy
  has_many :borrow_requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar
  # Validation for avatar
  # Validate content type
  # validates_attachment_content_type :avatar, content_type: /\Aimage/
  # # Validate filename
  # validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]

  # validate postal code must exist
  validates :username, presence: {message: "must exist"}
  validate :address_exists?
  validate :lrating?
  validate :brating?
  validate :correct_avatar_type
  geocoded_by :address
  after_validation :geocode

  before_create :set_default_avatar
  after_save :update_profile_id_in_users

  def update_profile_id_in_users
    @user = User.find(self.user_id)
    if @user.present?
      @user.update_attribute(:user_profile_id, self.id)
    end
  end

  def lrating?
    if self[:lend_rating]==nil
      return
    end

    if self[:lend_rating] > 5
      self.errors.add(:lend_rating,"can not be greater than 5")
    end
    if self[:lend_rating] < 0
      self.errors.add(:lend_rating,"can not be smaller than 0")
    end
  end

  def brating?
    if self[:borrow_rating]==nil
      return
    end

    if self[:borrow_rating] > 5
      self.errors.add(:lend_rating,"can not be greater than 5")
    end
    if self[:borrow_rating] < 0
      self.errors.add(:lend_rating,"can not be smaller than 0")
    end
  end

  def address_exists?
    if self.address.nil?
      return
    end

    if self.address["street_address"] == ""
      self.errors.add(:street_address, "can not be empty")
    end

    if self.address["city"] == ""
      self.errors.add(:city, "can not be empty")
    end

    if (self.address["postal_code"] =~ /\A[abceghjklmnprstvxyABCEGHJKLMNPRSTVXY]{1}\d{1}[a-zA-Z]{1}[ -]?\d{1}[a-zA-Z]{1}\d{1}\z/).nil?
      self.errors.add(:postal_code, "invalid!")
    end
  end

  def correct_avatar_type
      if self.avatar.attached? && !self.avatar.content_type.start_with?('image/');
        self.errors.add(:self, 'Must be an image')
      end
    end

  def set_default_avatar
    if !self.avatar.attached?
      self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_avatar.png")), filename: "default_avatar.png", content_type: "image/png")
    end
  end
end
