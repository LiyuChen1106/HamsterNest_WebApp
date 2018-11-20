class UserProfile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items, dependent: :destroy
  has_one :history, dependent: :destroy
  has_many :borrow_requests, dependent: :destroy
  has_one_attached :avatar
  # Validation for avatar
  # Validate content type
  # validates_attachment_content_type :avatar, content_type: /\Aimage/
  # # Validate filename
  # validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]

  after_save :update_profile_id_in_users

  def update_profile_id_in_users
    @user = User.find(self.user_id)
    if @user.present?
      @user.update_attribute(:user_profile_id, self.id)
    end
  end

  def auto_fill_username_and_account(user)
    @new_username = "#{self.first_name.downcase}#{self.last_name.downcase}#{rand(1000)}"

    self.username = @new_username

    self.user_id = user.id
  end
end
