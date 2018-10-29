class UserProfile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items, dependent: :destroy
  has_one :history, dependent: :destroy
  has_many :borrow_requests, dependent: :destroy
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
